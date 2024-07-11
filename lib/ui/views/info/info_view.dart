import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'info_view.desktop.dart';
import 'info_view.tablet.dart';
import 'info_view.mobile.dart';
import 'info_viewmodel.dart';

class InfoView extends StackedView<InfoViewModel> {
  const InfoView({super.key});

  @override
  Widget builder(
    BuildContext context,
    InfoViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const InfoViewMobile(),
      //tablet: (_) => const InfoViewTablet(),
      desktop: (_) => const InfoViewDesktop(),
    );
  }

  @override
  InfoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      InfoViewModel();
}
