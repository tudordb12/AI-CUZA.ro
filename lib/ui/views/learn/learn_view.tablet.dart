import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'learn_viewmodel.dart';

class LearnViewTablet extends ViewModelWidget<LearnViewModel> {
  const LearnViewTablet({super.key});

  @override
  Widget build(BuildContext context, LearnViewModel viewModel) {
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
