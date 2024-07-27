import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'code_viewmodel.dart';

class CodeViewTablet extends ViewModelWidget<CodeViewModel> {
  const CodeViewTablet({super.key});

  @override
  Widget build(BuildContext context, CodeViewModel viewModel) {
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
