import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'aicoach_viewmodel.dart';

class AicoachViewMobile extends ViewModelWidget<AicoachViewModel> {
  const AicoachViewMobile({super.key});

  @override
  Widget build(BuildContext context, AicoachViewModel viewModel) {
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
