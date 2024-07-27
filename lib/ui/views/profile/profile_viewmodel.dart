import 'package:stacked/stacked.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aicuzaro/app/app.bottomsheets.dart';
import 'package:aicuzaro/app/app.dialogs.dart';
import 'package:aicuzaro/app/app.locator.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_strings.dart';
import 'package:aicuzaro/ui/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class ProfileViewModel extends BaseViewModel {
  Map<int, bool> _isHovering = {};
  // Boolean to track the visibility of the menu
  bool _isMenuVisible = true;

  // Initialize hover states
  AccountpageViewModel() {
    for (int i = 1; i <= 6; i++) {
      _isHovering[i] = false;
    }
  }

  // Get hover state
  bool isHovering(int index) => _isHovering[index] ?? false;

  // Set hover state
  void setHovering(int index, bool value) {
    _isHovering[index] = value;
    notifyListeners();
  }

  // Get menu visibility state
  bool get isMenuVisible => _isMenuVisible;

  // Toggle menu visibility
  void toggleMenuVisibility() {
    _isMenuVisible = !_isMenuVisible;
    notifyListeners();
  }

  final _routerService = locator<RouterService>();

  Future<void> navigateToAuthView() async {
    await _routerService.replaceWith(const AuthViewRoute());
  }

  Future<void> navigateToProfileView() async {
    await _routerService.replaceWith(const ProfileViewRoute());
  }

  Future<void> navigateToHomeView() async {
    await _routerService.replaceWith(const PostspageViewRoute());
  }

  Future<void> navigateToHome() async {
    await _routerService.replaceWith(const HomeViewRoute());
  }

  Future<void> navigateToAICOACH() async {
    await _routerService.replaceWith(const AicoachViewRoute());
  }

  Future<void> navigateToLearnView() async {
    await _routerService.replaceWith(const LearnViewRoute());
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    navigateToAuthView();
  }

  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('posts');
  CollectionReference _reference2 =
      FirebaseFirestore.instance.collection('urls');

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  Future<void> postAttach() async {
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
      /* Map<String, String> Send = {
                        
                        'url': imageUrl,
                      };
*/
      String userName = user.email!;
      String postCaption = textController.text;

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MMM d yyyy').format(now);
      //Create a Map of data
      FirebaseFirestore.instance.collection('posts').add({
        'name': userName,
        'description': postCaption,
        'image': imageUrl,
        'date': formattedDate,
        'Likes': [],
        'saved': [],
      });

      //'date':

      //Add a new item

      /*  //Add a new item
                      _reference2.add(Send);*/
      // Use the imageUrl as needed (e.g., save it to a database or display it)
      print('Image uploaded successfully. Download URL: $imageUrl');

      // Update the url variable with the download URL
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
    }
    notifyListeners();
  }

  Future<void> postOnline() async {
    final imageUrl = '';

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM d yyyy').format(now);
    //Create a Map of data
    String userName = user.email!;
    String postCaption = textController.text;

    //Create a Map of data
    FirebaseFirestore.instance.collection('posts').add({
      'name': userName,
      'description': postCaption,
      'image': imageUrl,
      'date': formattedDate,
      'Likes': [],
      'saved': [],
    });
    notifyListeners();
  }

  Future<void> changeprofilepic() async {
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

      DocumentReference docRef =
          firestore.collection('usernames').doc(user.email);

      // Create a Map of data to send
      Map<String, String> dataToSend = {
        'image': imageUrl,
      };

      // Update the document with the new data
      await docRef.update(dataToSend);

      // Use the imageUrl as needed (e.g., save it to a database or display it)

      // Notify listeners or update UI
      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
    }
  }
}
