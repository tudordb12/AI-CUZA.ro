import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'aicoach_viewmodel.dart';

class AicoachViewTablet extends ViewModelWidget<AicoachViewModel> {
  const AicoachViewTablet({super.key});

  @override
  Widget build(BuildContext context, AicoachViewModel viewModel) {
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
