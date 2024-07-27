import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'aicoach_view.desktop.dart';
import 'aicoach_view.tablet.dart';
import 'aicoach_view.mobile.dart';
import 'aicoach_viewmodel.dart';

class AicoachView extends StackedView<AicoachViewModel> {
  const AicoachView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AicoachViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const AicoachViewMobile(),
     // tablet: (_) => const AicoachViewTablet(),
      desktop: (_) => const AicoachViewDesktop(),
    );
  }

  @override
  AicoachViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AicoachViewModel();
}
