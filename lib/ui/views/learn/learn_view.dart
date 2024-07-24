import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'learn_view.desktop.dart';
import 'learn_view.tablet.dart';
import 'learn_view.mobile.dart';
import 'learn_viewmodel.dart';

class LearnView extends StackedView<LearnViewModel> {
  const LearnView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LearnViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const LearnViewMobile(),
      tablet: (_) => const LearnViewTablet(),
      desktop: (_) => const LearnViewDesktop(),
    );
  }

  @override
  LearnViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LearnViewModel();
}
