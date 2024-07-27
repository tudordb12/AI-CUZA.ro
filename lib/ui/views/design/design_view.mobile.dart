import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'design_viewmodel.dart';

class DesignViewMobile extends ViewModelWidget<DesignViewModel> {
  const DesignViewMobile({super.key});

  @override
  Widget build(BuildContext context, DesignViewModel viewModel) {
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
