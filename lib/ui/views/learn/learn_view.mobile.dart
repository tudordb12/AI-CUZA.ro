import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'learn_viewmodel.dart';

class LearnViewMobile extends ViewModelWidget<LearnViewModel> {
  const LearnViewMobile({super.key});

  @override
  Widget build(BuildContext context, LearnViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, MOBILE UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
