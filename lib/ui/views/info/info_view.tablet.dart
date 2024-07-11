import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'info_viewmodel.dart';

class InfoViewTablet extends ViewModelWidget<InfoViewModel> {
  const InfoViewTablet({super.key});

  @override
  Widget build(BuildContext context, InfoViewModel viewModel) {
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
