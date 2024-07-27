import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'robotics_viewmodel.dart';

class RoboticsViewMobile extends ViewModelWidget<RoboticsViewModel> {
  const RoboticsViewMobile({super.key});

  @override
  Widget build(BuildContext context, RoboticsViewModel viewModel) {
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
