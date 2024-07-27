import 'package:aicuzaro/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:aicuzaro/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:aicuzaro/ui/views/home/home_view.dart';
import 'package:aicuzaro/ui/views/startup/startup_view.dart';
import 'package:aicuzaro/ui/views/unknown/unknown_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aicuzaro/ui/views/login/login_view.dart';
import 'package:aicuzaro/ui/views/auth/auth_view.dart';
import 'package:aicuzaro/ui/views/downloads/downloads_view.dart';
import 'package:aicuzaro/ui/views/info/info_view.dart';
import 'package:aicuzaro/ui/views/signup/signup_view.dart';
import 'package:aicuzaro/ui/views/aicoach/aicoach_view.dart';
import 'package:aicuzaro/ui/views/postspage/postspage_view.dart';
import 'package:aicuzaro/ui/views/profile/profile_view.dart';
import 'package:aicuzaro/ui/views/learn/learn_view.dart';
import 'package:aicuzaro/ui/views/design/design_view.dart';
import 'package:aicuzaro/ui/views/code/code_view.dart';
import 'package:aicuzaro/ui/views/robotics/robotics_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: StartupView, initial: true),
    CustomRoute(page: HomeView),
    CustomRoute(page: LoginView),
    MaterialRoute(page: AuthView),
    CustomRoute(page: DownloadsView),
    CustomRoute(page: InfoView),
    CustomRoute(page: SignupView),
    CustomRoute(page: AicoachView),
    CustomRoute(page: PostspageView),
    CustomRoute(page: ProfileView),
    CustomRoute(page: LearnView),
    CustomRoute(page: DesignView),
    CustomRoute(page: CodeView),
    CustomRoute(page: RoboticsView),
// @stacked-route

    CustomRoute(page: UnknownView, path: '/404'),

    /// When none of the above routes match, redirect to UnknownView
    RedirectRoute(path: '*', redirectTo: '/404'),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
