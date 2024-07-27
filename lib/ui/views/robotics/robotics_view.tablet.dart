import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'robotics_viewmodel.dart';

class RoboticsViewTablet extends ViewModelWidget<RoboticsViewModel> {
  const RoboticsViewTablet({super.key});

  @override
  Widget build(BuildContext context, RoboticsViewModel viewModel) {
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
