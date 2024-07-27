// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i18;
import 'package:stacked/stacked.dart' as _i17;
import 'package:stacked_services/stacked_services.dart' as _i16;

import '../ui/views/aicoach/aicoach_view.dart' as _i8;
import '../ui/views/auth/auth_view.dart' as _i4;
import '../ui/views/code/code_view.dart' as _i13;
import '../ui/views/design/design_view.dart' as _i12;
import '../ui/views/downloads/downloads_view.dart' as _i5;
import '../ui/views/home/home_view.dart' as _i2;
import '../ui/views/info/info_view.dart' as _i6;
import '../ui/views/learn/learn_view.dart' as _i11;
import '../ui/views/login/login_view.dart' as _i3;
import '../ui/views/postspage/postspage_view.dart' as _i9;
import '../ui/views/profile/profile_view.dart' as _i10;
import '../ui/views/robotics/robotics_view.dart' as _i14;
import '../ui/views/signup/signup_view.dart' as _i7;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/unknown/unknown_view.dart' as _i15;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i16.StackedService.navigatorKey);

class StackedRouterWeb extends _i17.RootStackRouter {
  StackedRouterWeb({_i18.GlobalKey<_i18.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    AuthViewRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.AuthView(),
      );
    },
    DownloadsViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.DownloadsView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InfoViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.InfoView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignupViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.SignupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    AicoachViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.AicoachView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PostspageViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.PostspageView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i10.ProfileView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LearnViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i11.LearnView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DesignViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i12.DesignView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CodeViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i13.CodeView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RoboticsViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i14.RoboticsView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownViewRoute.name: (routeData) {
      return _i17.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i15.UnknownView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i17.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i17.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i17.RouteConfig(
          AuthViewRoute.name,
          path: '/auth-view',
        ),
        _i17.RouteConfig(
          DownloadsViewRoute.name,
          path: '/downloads-view',
        ),
        _i17.RouteConfig(
          InfoViewRoute.name,
          path: '/info-view',
        ),
        _i17.RouteConfig(
          SignupViewRoute.name,
          path: '/signup-view',
        ),
        _i17.RouteConfig(
          AicoachViewRoute.name,
          path: '/aicoach-view',
        ),
        _i17.RouteConfig(
          PostspageViewRoute.name,
          path: '/postspage-view',
        ),
        _i17.RouteConfig(
          ProfileViewRoute.name,
          path: '/profile-view',
        ),
        _i17.RouteConfig(
          LearnViewRoute.name,
          path: '/learn-view',
        ),
        _i17.RouteConfig(
          DesignViewRoute.name,
          path: '/design-view',
        ),
        _i17.RouteConfig(
          CodeViewRoute.name,
          path: '/code-view',
        ),
        _i17.RouteConfig(
          RoboticsViewRoute.name,
          path: '/robotics-view',
        ),
        _i17.RouteConfig(
          UnknownViewRoute.name,
          path: '/404',
        ),
        _i17.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/404',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i17.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i17.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i3.LoginView]
class LoginViewRoute extends _i17.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i4.AuthView]
class AuthViewRoute extends _i17.PageRouteInfo<void> {
  const AuthViewRoute()
      : super(
          AuthViewRoute.name,
          path: '/auth-view',
        );

  static const String name = 'AuthView';
}

/// generated route for
/// [_i5.DownloadsView]
class DownloadsViewRoute extends _i17.PageRouteInfo<void> {
  const DownloadsViewRoute()
      : super(
          DownloadsViewRoute.name,
          path: '/downloads-view',
        );

  static const String name = 'DownloadsView';
}

/// generated route for
/// [_i6.InfoView]
class InfoViewRoute extends _i17.PageRouteInfo<void> {
  const InfoViewRoute()
      : super(
          InfoViewRoute.name,
          path: '/info-view',
        );

  static const String name = 'InfoView';
}

/// generated route for
/// [_i7.SignupView]
class SignupViewRoute extends _i17.PageRouteInfo<void> {
  const SignupViewRoute()
      : super(
          SignupViewRoute.name,
          path: '/signup-view',
        );

  static const String name = 'SignupView';
}

/// generated route for
/// [_i8.AicoachView]
class AicoachViewRoute extends _i17.PageRouteInfo<void> {
  const AicoachViewRoute()
      : super(
          AicoachViewRoute.name,
          path: '/aicoach-view',
        );

  static const String name = 'AicoachView';
}

/// generated route for
/// [_i9.PostspageView]
class PostspageViewRoute extends _i17.PageRouteInfo<void> {
  const PostspageViewRoute()
      : super(
          PostspageViewRoute.name,
          path: '/postspage-view',
        );

  static const String name = 'PostspageView';
}

/// generated route for
/// [_i10.ProfileView]
class ProfileViewRoute extends _i17.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: '/profile-view',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i11.LearnView]
class LearnViewRoute extends _i17.PageRouteInfo<void> {
  const LearnViewRoute()
      : super(
          LearnViewRoute.name,
          path: '/learn-view',
        );

  static const String name = 'LearnView';
}

/// generated route for
/// [_i12.DesignView]
class DesignViewRoute extends _i17.PageRouteInfo<void> {
  const DesignViewRoute()
      : super(
          DesignViewRoute.name,
          path: '/design-view',
        );

  static const String name = 'DesignView';
}

/// generated route for
/// [_i13.CodeView]
class CodeViewRoute extends _i17.PageRouteInfo<void> {
  const CodeViewRoute()
      : super(
          CodeViewRoute.name,
          path: '/code-view',
        );

  static const String name = 'CodeView';
}

/// generated route for
/// [_i14.RoboticsView]
class RoboticsViewRoute extends _i17.PageRouteInfo<void> {
  const RoboticsViewRoute()
      : super(
          RoboticsViewRoute.name,
          path: '/robotics-view',
        );

  static const String name = 'RoboticsView';
}

/// generated route for
/// [_i15.UnknownView]
class UnknownViewRoute extends _i17.PageRouteInfo<void> {
  const UnknownViewRoute()
      : super(
          UnknownViewRoute.name,
          path: '/404',
        );

  static const String name = 'UnknownView';
}

extension RouterStateExtension on _i16.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToHomeView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToAuthView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const AuthViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToDownloadsView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const DownloadsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToInfoView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const InfoViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSignupView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SignupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToAicoachView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const AicoachViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToPostspageView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const PostspageViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLearnView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LearnViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToDesignView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const DesignViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCodeView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const CodeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToRoboticsView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const RoboticsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToUnknownView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithAuthView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const AuthViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithDownloadsView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const DownloadsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithInfoView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const InfoViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSignupView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SignupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithAicoachView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const AicoachViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithPostspageView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const PostspageViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLearnView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LearnViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithDesignView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const DesignViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCodeView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const CodeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithRoboticsView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const RoboticsViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithUnknownView(
      {void Function(_i17.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const UnknownViewRoute(),
      onFailure: onFailure,
    );
  }
}
