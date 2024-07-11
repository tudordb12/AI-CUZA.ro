import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'postspage_viewmodel.dart';

class PostspageViewTablet extends ViewModelWidget<PostspageViewModel> {
  const PostspageViewTablet({super.key});

  @override
  Widget build(BuildContext context, PostspageViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, TABLET UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
