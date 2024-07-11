import 'package:stacked/stacked.dart';
import 'package:aicuzaro/app/app.bottomsheets.dart';
import 'package:aicuzaro/app/app.dialogs.dart';
import 'package:aicuzaro/app/app.locator.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_strings.dart';
import 'package:aicuzaro/ui/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aicuzaro/firebase_options.dart';

import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _routerService = locator<RouterService>();

  Future<void> navigateToSignUpView() async {
    await _routerService.replaceWith(const SignupViewRoute());
  }

  Future<void> SignIn() async {
    await _routerService.replaceWith(const AuthViewRoute());
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var message = Text(
    '',
  );

  Future<void> _showAlertDialog() async {
    message = Text('Acest utilizator nu există!');
  }

  Future<void> navigateToHomeView() async {
    await _routerService.replaceWith(const HomeViewRoute());
  }

  Future<void> navigateToLoginView() async {
    await _routerService.replaceWith(const LoginViewRoute());
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

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      SignIn();
    } on FirebaseAuthException catch (e) {
      errorMessage();
    }
  }

  void errorMessage() {
    message = Text('Nu v-am putut conecta!');
  }
}
