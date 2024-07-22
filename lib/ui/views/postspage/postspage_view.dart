import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'postspage_view.desktop.dart';
import 'postspage_view.tablet.dart';
import 'postspage_view.mobile.dart';
import 'postspage_viewmodel.dart';

class PostspageView extends StackedView<PostspageViewModel> {
  const PostspageView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PostspageViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const PostspageViewMobile(),
      // tablet: (_) => const PostspageViewTablet(),
      desktop: (_) => PostspageViewDesktop(),
    );
  }

  @override
  PostspageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PostspageViewModel();
}
