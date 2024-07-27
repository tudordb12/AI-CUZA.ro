import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'design_viewmodel.dart';

class DesignViewTablet extends ViewModelWidget<DesignViewModel> {
  const DesignViewTablet({super.key});

  @override
  Widget build(BuildContext context, DesignViewModel viewModel) {
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
