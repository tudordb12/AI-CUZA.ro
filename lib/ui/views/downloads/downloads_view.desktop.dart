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
import 'downloads_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadsViewDesktop extends ViewModelWidget<DownloadsViewModel> {
  const DownloadsViewDesktop({super.key});

  @override
  Widget build(BuildContext context, DownloadsViewModel viewModel) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                            flex: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      SizedBox(
                        child: Center(
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  FadeInUp(
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    child: GradientText(
                                                      'DESCARCARI',
                                                      style: ktsTitleText,
                                                      colors: const [
                                                        Color.fromARGB(
                                                            255, 255, 183, 0),
                                                        Color.fromARGB(
                                                            255, 223, 2, 43)
                                                      ],
                                                    ),
                                                  ),
                                                  FadeInUp(
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    child: Text(
                                                      'AI.CUZA',
                                                      style: ktsTitleText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                          FadeInLeft(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  'lib/assets/arrow2.png',
                                                  width: 200,
                                                  height: 100,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'for Android',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              const url =
                                                  'https://www.dropbox.com/scl/fi/syogbyyftu5hatig7pepp/CuzzApp.apk?rlkey=og39pz2wbts2auz3n3hv56mmg&st=d41eelun&dl=1';
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
                                                    BorderRadius.circular(60),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
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
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Download CUZZApp',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: 300,
                                              child: Text(
                                                'O aplicație educativă STEM din cadrul aceluiași Startup',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: SizedBox(
                                          width: kdDesktopMaxContentWidth,
                                          height: kdDesktopMaxContentHeight,
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FadeInLeft(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.asset(
                                                        'lib/assets/startup.png',
                                                        width:
                                                            kdDesktopMaxContentWidth *
                                                                0.4,
                                                        height: 500,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    ]))),
          ]))),
    );
  }
}
