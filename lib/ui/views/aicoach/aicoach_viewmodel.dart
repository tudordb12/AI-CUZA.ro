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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AicoachViewModel extends BaseViewModel {
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

  Future<void> navigateToPostsView() async {
     await _routerService.replaceWith(const PostspageViewRoute());
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    navigateToAuthView();
  }

  final user = FirebaseAuth.instance.currentUser!;

  //final apiKey = dotenv.env['OPENAI_API_KEY'];

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Robo', lastName: 'User');
  final ChatUser _gptCurrentUser =
      ChatUser(id: '2', firstName: 'Robo', lastName: 'Coach');
  final _bottomSheetService = locator<BottomSheetService>();

  final _openAI = OpenAI.instance.build(
    token: 'OPENAI_API_KEY',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
    ),
    enableLog: true,
  );

  List<ChatMessage> messages = <ChatMessage>[];
  void addMessage(ChatMessage message) {
    messages.insert(0, message);
    notifyListeners(); // Notifies the UI to rebuild
  }

  Future<void> getChatResponse(ChatMessage message) async {
    // Simulate an async operation, like fetching a response from an API
    addMessage(message);
    List<Messages> messagesHistory = messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: messagesHistory,
        maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        messages.insert(
            0,
            ChatMessage(
                user: _gptCurrentUser,
                createdAt: DateTime.now(),
                text: element.message!.content));
        notifyListeners();
      }
    }
  }
}
