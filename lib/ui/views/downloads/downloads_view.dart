import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'downloads_view.desktop.dart';
import 'downloads_view.tablet.dart';
import 'downloads_view.mobile.dart';
import 'downloads_viewmodel.dart';

class DownloadsView extends StackedView<DownloadsViewModel> {
  const DownloadsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DownloadsViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const DownloadsViewMobile(),
      //tablet: (_) => const DownloadsViewTablet(),
      desktop: (_) => const DownloadsViewDesktop(),
    );
  }

  @override
  DownloadsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DownloadsViewModel();
}
