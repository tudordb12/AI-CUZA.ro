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
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'register_web_webview_stub.dart'
    if (dart.library.html) 'register_web_webview.dart';

class CodeViewModel extends BaseViewModel {
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
    await _routerService.replaceWith(const HomeViewRoute());
  }

  Future<void> navigateToAICOACH() async {
    await _routerService.replaceWith(const AicoachViewRoute());
  }

   Future<void> navigateToDesign() async {
    await _routerService.replaceWith(const DesignViewRoute());
  }

   Future<void> navigateToCode() async {
    await _routerService.replaceWith(const CodeViewRoute());
  }

   Future<void> navigateToRobotics() async {
    await _routerService.replaceWith(const RoboticsViewRoute());
  }
   Future<void> navigateToLoginView() async {
    await _routerService.replaceWith(const LoginViewRoute());
  }

  
  Future<void> navigateToDownloadsView() async {
    await _routerService.replaceWith(const DownloadsViewRoute());
  }

  Future<void> navigateToInfoView() async {
    await _routerService.replaceWith(const InfoViewRoute());
  }


  Future<void> navigateToLearnView() async {
    await _routerService.replaceWith(const LearnViewRoute());
  }

  Future<void> navigateToDesignView() async {
    await _routerService.replaceWith(const DesignViewRoute());
  }

  Future<void> navigateToCodeView() async {
    await _routerService.replaceWith(const CodeViewRoute());
  }

  Future<void> navigateToRoboticsView() async {
    await _routerService.replaceWith(const RoboticsViewRoute());
  }

  Future<void> navigateToPostsView() async {
    await _routerService.replaceWith(const PostspageViewRoute());
  }

  Future<void> navigateToAICOACHView() async {
    await _routerService.replaceWith(const AicoachViewRoute());
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    navigateToAuthView();
  }

  final user = FirebaseAuth.instance.currentUser!;

  ScrollController scrollController = ScrollController();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
