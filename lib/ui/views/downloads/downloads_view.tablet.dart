import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'downloads_viewmodel.dart';

class DownloadsViewTablet extends ViewModelWidget<DownloadsViewModel> {
  const DownloadsViewTablet({super.key});

  @override
  Widget build(BuildContext context, DownloadsViewModel viewModel) {
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
