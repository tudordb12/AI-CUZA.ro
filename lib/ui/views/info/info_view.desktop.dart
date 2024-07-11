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

import 'package:url_launcher/url_launcher.dart';

class InfoViewDesktop extends ViewModelWidget<InfoViewModel> {
  const InfoViewDesktop({super.key});

  @override
  Widget build(BuildContext context, InfoViewModel viewModel) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
        SizedBox(
            width: kdDesktopMaxContentWidth,
            height: kdDesktopMaxContentHeight,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            InkWell(
                              child: Text(
                                'AI.CUZA',
                                style: ktsBodyLarge.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
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
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: GradientText(
                          'CREEAZA\nPROPRIUL',
                          style: ktsTitleText,
                          colors: const [
                            Color.fromARGB(255, 197, 79, 1),
                            Color.fromARGB(255, 211, 7, 7)
                          ],
                        ),
                      ),
                      Align(
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Text(
                            'TAU CUZA',
                            style: ktsTitleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Descoperă diverse unelte perfecte pentru începători pentru a da startul proiectelor! ;)',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                FadeInUp(
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        verticalSpaceLarge,
                                        Container(
                                          height: 600,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 117, 27, 0),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 250,
                                                  width: 500,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 119, 30, 3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Image.asset(
                                                    'lib/assets/8.png',
                                                    width:
                                                        kdDesktopMaxContentWidth *
                                                            0.4,
                                                    height: 450,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'TINKERCAD',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  const url =
                                                      'https://www.tinkercad.com';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Color.fromARGB(
                                                              255, 206, 0, 76),
                                                          Color.fromRGBO(
                                                              223, 8, 94, 1),
                                                          Color.fromARGB(
                                                              255, 219, 23, 124)
                                                        ]),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Descoperă mai multe',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 600,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 221, 76, 9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 250,
                                                  width: 500,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 119, 30, 3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Image.asset(
                                                    'lib/assets/9.png',
                                                    width:
                                                        kdDesktopMaxContentWidth *
                                                            0.4,
                                                    height: 450,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'MICROSOFT MakeCode',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  const url =
                                                      'https://www.microsoft.com/en-us/makecode';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Color.fromARGB(
                                                              255, 206, 0, 76),
                                                          Color.fromRGBO(
                                                              223, 8, 94, 1),
                                                          Color.fromARGB(
                                                              255, 219, 23, 124)
                                                        ]),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Descoperă mai multe',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 600,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 237, 137, 5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 250,
                                                  width: 500,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 194, 45, 0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Image.asset(
                                                    'lib/assets/7.png',
                                                    width:
                                                        kdDesktopMaxContentWidth *
                                                            0.4,
                                                    height: 450,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'TINKERCAD LEARN CIRCUITS',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  const url =
                                                      'https://www.tinkercad.com/learn/circuits';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Color.fromARGB(
                                                              255, 206, 0, 76),
                                                          Color.fromRGBO(
                                                              223, 8, 94, 1),
                                                          Color.fromARGB(
                                                              255, 219, 23, 124)
                                                        ]),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Descoperă mai multe',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 600,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 187, 0, 65),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 250,
                                                  width: 500,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 119, 30, 3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Image.asset(
                                                    'lib/assets/3.png',
                                                    width:
                                                        kdDesktopMaxContentWidth *
                                                            0.4,
                                                    height: 450,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'ARDUINO IDE',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  const url =
                                                      'https://www.arduino.cc/';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Color.fromARGB(
                                                              255, 206, 0, 76),
                                                          Color.fromRGBO(
                                                              223, 8, 94, 1),
                                                          Color.fromARGB(
                                                              255, 219, 23, 124)
                                                        ]),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Descoperă mai multe',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(width: 40),
                                Container(
                                  height: 150,
                                  width: 300,
                                  child: Image.asset(
                                    'lib/assets/footer.png',
                                    width: kdDesktopMaxContentWidth * 0.4,
                                    height: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])))
      ]))),
    );
  }
}
