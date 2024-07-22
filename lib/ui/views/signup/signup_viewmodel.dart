import 'package:stacked/stacked.dart';
import 'package:aicuzaro/app/app.bottomsheets.dart';
import 'package:aicuzaro/app/app.dialogs.dart';
import 'package:aicuzaro/app/app.locator.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_strings.dart';
import 'package:aicuzaro/ui/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class SignupViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();

  Future<void> navigateToLoginView() async {
    await _routerService.replaceWith(const LoginViewRoute());
  }

  Future<void> navigateToSignUpView() async {
    await _routerService.replaceWith(const SignupViewRoute());
  }

  Future<void> navigateToHomeView() async {
    await _routerService.replaceWith(const HomeViewRoute());
  }

  Future<void> navigateToAuthView() async {
    await _routerService.replaceWith(const AuthViewRoute());
  }

  Future<void> navigateToDownloadsView() async {
    await _routerService.replaceWith(const DownloadsViewRoute());
  }

  Future<void> navigateToInfoView() async {
    await _routerService.replaceWith(const InfoViewRoute());
  }

  Future<void> SignIn() async {
    await _routerService.replaceWith(const AuthViewRoute());
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('usernames');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var message2 = Text('');

  Future<void> username() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final imageUrl = '';
    final defaultUrl =
        'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/onlineres%2F654a4d851561c2f04731f7fb3838f020.png?alt=media&token=bff7b2d9-90bf-4cd1-b219-6fda61c14495';

    String itemName = nameController.text;
    String username = emailController.text;

    DocumentReference docRef = firestore.collection('usernames').doc(username);

    //Create a Map of data
    Map<String, String> dataToSend = {
      'name': itemName,
      'email': username,
      'image': defaultUrl,
      //'location' : '',
    };

    //Add a new item
    // _reference.add(dataToSend);
    docRef.set(dataToSend);

    DocumentReference followingDocRef =
        firestore.collection('following').doc(username);
    await followingDocRef.set({
      'followers': [],
    });
    /*  //Add a new item
                      _reference2.add(Send);*/
    // Use the imageUrl as needed (e.g., save it to a database or display it)

    // Update the url variable with the download URL

    notifyListeners();
  }

  Future<void> profilepic() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Open a file picker to choose an image file
      final result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result == null) {
        // User canceled the picker
        return;
      }

      // Get the bytes of the picked image file
      final bytes = result.files.single.bytes;

      if (bytes == null) {
        // Unable to read bytes
        return;
      }

      // Create a reference to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();

      // Specify the destination path for the uploaded image
      final destinationPath =
          'images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Create a reference to the destination path
      final imageRef = storageRef.child(destinationPath);

      // Upload the image file
      final uploadTask = imageRef.putData(bytes);

      // Get the upload task snapshot to track the upload progress
      final snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      final imageUrl = await snapshot.ref.getDownloadURL();

      String itemName = nameController.text;
      String username = emailController.text;

      DocumentReference docRef =
          firestore.collection('usernames').doc(username);

      //Create a Map of data
      Map<String, String> dataToSend = {
        'name': itemName,
        'email': username,
        'image': imageUrl,
      };

      //Add a new item
      // _reference.add(dataToSend);
      docRef.set(dataToSend);

      DocumentReference followingDocRef =
          firestore.collection('following').doc(username);
      await followingDocRef.set({
        'followers': [],
      });
      /*  //Add a new item
                      _reference2.add(Send);*/
      // Use the imageUrl as needed (e.g., save it to a database or display it)

      // Update the url variable with the download URL

      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
    }
  }

  void signUserUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        navigateToLoginView();
        username();
      } else {
        NotMatchMessage();
      }
    } on FirebaseAuthException catch (e) {
      message2 = Text(e.message.toString());
    }
  }

  void NotMatchMessage() {
    message2 = Text('Parolele nu corespund!');
  }

  void UnexErrorMessage() {
    message2 = Text('A avut loc o eroare neașteptată!');
  }

  void signUserUp2() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        profilepic();
        navigateToLoginView();
      } else {
        NotMatchMessage2();
      }
    } on FirebaseAuthException catch (e) {
      message2 = Text(e.message.toString());
    }
  }

  void NotMatchMessage2() {
    message2 = Text('Parolele nu corespund!');
  }

  void UnexErrorMessage2() {
    message2 = Text('A avut loc o eroare neașteptată!');
  }
}
