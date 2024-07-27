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

class AicoachViewModel extends BaseViewModel {
  String? _openAiApiKey;
  OpenAI? _openAI;
  Future<void>? _initializationFuture;

  AicoachViewModel() {
    _initializationFuture = initializeData();
  }

  Future<void> initializeData() async {
    await fetchDocumentFieldContent('apiKeys'); // Replace with your document ID
    _addInitialMessage(); // Add the initial message
  }

  Map<int, bool> _isHovering = {};
  bool _isMenuVisible = true;

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
          .doc(documentId);

      // Fetch the document snapshot
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Extract data from the document
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        // Access specific fields
        _openAiApiKey = data?['openAI'];

        // Initialize OpenAI instance with the fetched API key
        if (_openAiApiKey != null) {
          _openAI = OpenAI.instance.build(
            token: _openAiApiKey!,
            baseOption: HttpSetup(
              receiveTimeout: const Duration(seconds: 5),
            ),
            enableLog: true,
          );
        }

        notifyListeners();
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

  List<ChatMessage> messages = <ChatMessage>[];

  void addMessage(ChatMessage message) {
    messages.insert(0, message);
    notifyListeners();
  }

  void _addInitialMessage() {
    final initialMessage = ChatMessage(
      user: _gptCurrentUser,
      createdAt: DateTime.now(),
      text: 'Salut, Jill Kendall! Cum te pot ajuta?',
    );
    addMessage(initialMessage);
  }

  Future<void> getChatResponse(ChatMessage message) async {
    // Wait for initialization to complete
    if (_initializationFuture != null) {
      await _initializationFuture;
    }

    if (_openAI == null) {
      print('OpenAI is not initialized');
      return;
    }

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
      final response = await _openAI!.onChatCompletion(request: request);
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
