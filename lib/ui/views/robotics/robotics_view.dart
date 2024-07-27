import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'robotics_view.desktop.dart';
import 'robotics_view.tablet.dart';
import 'robotics_view.mobile.dart';
import 'robotics_viewmodel.dart';

class RoboticsView extends StackedView<RoboticsViewModel> {
  const RoboticsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RoboticsViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const RoboticsViewMobile(),
      tablet: (_) => const RoboticsViewTablet(),
      desktop: (_) => const RoboticsViewDesktop(),
    );
  }

  @override
  RoboticsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RoboticsViewModel();
}
