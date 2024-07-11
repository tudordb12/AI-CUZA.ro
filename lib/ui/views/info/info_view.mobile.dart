import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_colors.dart';
import 'package:aicuzaro/ui/common/app_constants.dart';
import 'package:aicuzaro/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'info_viewmodel.dart';

import 'info_viewmodel.dart';

class InfoViewMobile extends ViewModelWidget<InfoViewModel> {
  const InfoViewMobile({super.key});

  @override
  Widget build(BuildContext context, InfoViewModel viewModel) {
    return Scaffold(
        backgroundColor: kcBackgroundColor,
        body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 50,
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Text(
                          'AI.CUZA',
                          style: ktsBodyLarge.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            viewModel.navigateToHomeView();
                          },
                          child: Text(
                            'Acasă',
                            style: ktsBodyRegular.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.navigateToInfoView();
                          },
                          child: Text(
                            'Creează-ți propriul CUZA',
                            style: ktsBodyRegular.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.navigateToDownloadsView();
                          },
                          child: Text(
                            'Descărcări',
                            style: ktsBodyRegular.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.navigateToAuthView();
                          },
                          child: Text(
                            'Contul Meu',
                            style: ktsBodyRegular.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            //viewModel.signUserOut();
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(
                            child: GradientText(
                              'CREEAZA',
                              style: ktsTitleText.copyWith(fontSize: 60),
                              colors: const [
                                Color.fromARGB(255, 218, 7, 66),
                                Color.fromARGB(255, 21, 204, 250)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Center(
                            child: GradientText(
                              'PROPRIUL',
                              style: ktsTitleText.copyWith(fontSize: 50),
                              colors: const [
                                Color.fromARGB(255, 255, 183, 0),
                                Color.fromARGB(255, 223, 2, 43)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Center(
                            child: Text(
                              'TAU CUZA',
                              style: ktsTitleText.copyWith(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  Center(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  )),
                ],
              ),
            ]));
  }
}
