import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'design_view.desktop.dart';
import 'design_view.tablet.dart';
import 'design_view.mobile.dart';
import 'design_viewmodel.dart';

class DesignView extends StackedView<DesignViewModel> {
  const DesignView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DesignViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const DesignViewMobile(),
      tablet: (_) => const DesignViewTablet(),
      desktop: (_) => const DesignViewDesktop(),
    );
  }

  @override
  DesignViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DesignViewModel();
}
