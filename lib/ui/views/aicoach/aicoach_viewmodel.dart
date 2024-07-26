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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;

// Import the consts file
import 'package:aicuzaro/consts.dart';

class AicoachViewModel extends BaseViewModel {

   Future<void> initializeData() async {
    await fetchDocumentFieldContent('apiKey'); // Replace with your document ID
  }
  Map<int, bool> _isHovering = {};
  bool _isMenuVisible = true;

  AicoachViewModel() {
    for (int i = 1; i <= 6; i++) {
      _isHovering[i] = false;
    }
    
  }

  bool isHovering(int index) => _isHovering[index] ?? false;

  void setHovering(int index, bool value) {
    _isHovering[index] = value;
    notifyListeners();
  }

  bool get isMenuVisible => _isMenuVisible;

  void toggleMenuVisibility() {
    _isMenuVisible = !_isMenuVisible;
    notifyListeners();
  }

  final _routerService = locator<RouterService>();

  Future<void> navigateToAuthView() async {
    await _routerService.replaceWith(const AuthViewRoute());
  }

  Future<void> navigateToPostsView() async {
    await _routerService.replaceWith(const PostspageViewRoute());
  }

  Future<void> navigateToLearnView() async {
    await _routerService.replaceWith(const LearnViewRoute());
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    navigateToAuthView();
  }

   Future<void> fetchDocumentFieldContent(String documentId) async {
    try {
      // Get a reference to the Firestore collection and document
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('API_KEY') // Replace with your collection name
          .doc('apiKeys');

      // Fetch the document snapshot
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Extract data from the document
        Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
        
        // Access specific fields
        String field1 = data?['openAI'] ?? 'No data'; // Replace 'field1' with your actual field name


        // Use the data as needed
        print('Field 1: $field1');
     

        // You can update a property in your ViewModel with the retrieved data if needed
        // For example:
        // _field1 = field1;
        // _field2 = field2;
        // notifyListeners(); // Notify listeners if you are updating properties that affect the UI
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching document: $e');
    }
  }
 final user = FirebaseAuth.instance.currentUser!;

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Robo', lastName: 'User');
  final ChatUser _gptCurrentUser =
      ChatUser(id: '2', firstName: 'Robo', lastName: 'Coach');
  final _bottomSheetService = locator<BottomSheetService>();

  // Load the API key from the consts file
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY, // Load from consts
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
    ),
    enableLog: true,
  );

  List<ChatMessage> messages = <ChatMessage>[];

  void addMessage(ChatMessage message) {
    messages.insert(0, message);
    notifyListeners();
  }

  Future<void> getChatResponse(ChatMessage message) async {
    addMessage(message);
    List<Messages> messagesHistory = messages.reversed.map((m) {
      return Messages(
        role: m.user == _currentUser ? Role.user : Role.assistant,
        content: m.text,
      );
    }).toList();

    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: messagesHistory,
      maxToken: 200,
    );

    try {
      final response = await _openAI.onChatCompletion(request: request);
      if (response != null && response.choices.isNotEmpty) {
        for (var element in response.choices) {
          if (element.message != null) {
            addMessage(
              ChatMessage(
                user: _gptCurrentUser,
                createdAt: DateTime.now(),
                text: element.message!.content,
              ),
            );
          }
        }
      }
    } catch (e) {
      // Handle the error appropriately
      print('Error fetching chat response: $e');
    }
  }
}
