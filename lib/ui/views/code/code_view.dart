import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'code_view.desktop.dart';
import 'code_view.tablet.dart';
import 'code_view.mobile.dart';
import 'code_viewmodel.dart';

class CodeView extends StackedView<CodeViewModel> {
  const CodeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CodeViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const CodeViewMobile(),
      tablet: (_) => const CodeViewTablet(),
      desktop: (_) => const CodeViewDesktop(),
    );
  }

  @override
  CodeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CodeViewModel();
}
