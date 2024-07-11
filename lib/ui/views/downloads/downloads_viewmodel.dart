import 'package:stacked/stacked.dart';
import 'package:aicuzaro/app/app.bottomsheets.dart';
import 'package:aicuzaro/app/app.dialogs.dart';
import 'package:aicuzaro/app/app.locator.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_strings.dart';
import 'package:aicuzaro/ui/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadsViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();
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

  Future<void> _launchURLInBrowser() async {
    const url =
        'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/CUZZAppInstaller.zip?alt=media&token=468808fc-9eac-4bec-95f0-e48cc7be4fd4';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
