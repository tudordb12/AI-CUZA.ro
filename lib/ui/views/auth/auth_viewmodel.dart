import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/app/app.bottomsheets.dart';
import 'package:aicuzaro/app/app.dialogs.dart';
import 'package:aicuzaro/app/app.locator.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_strings.dart';
import 'package:aicuzaro/ui/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();

  Future<void> navigateToSignUpView() async {
    await _routerService.replaceWith(const SignupViewRoute());
  }

  Future<void> navigateToDashboardView() async {
    await _routerService.replaceWith(const PostspageViewRoute());
  }

  Future<void> NotSignedIn() async {
    await _routerService.replaceWith(const LoginViewRoute());
  }
}
