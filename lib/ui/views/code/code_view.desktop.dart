import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'code_viewmodel.dart';

class CodeViewDesktop extends ViewModelWidget<CodeViewModel> {
  const CodeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, CodeViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Hello, DESKTOP UI!',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}