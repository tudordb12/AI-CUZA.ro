import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/ui/views/postspage/wall_post.dart';
import 'package:aicuzaro/ui/views/profile/profile_pic_btn.dart';
import 'package:aicuzaro/ui/views/profile/wall_ppost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/ui/common/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_constants.dart';
import 'package:aicuzaro/ui/common/ui_helpers.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'register_web_webview_stub.dart'
    if (dart.library.html) 'register_web_webview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'robotics_viewmodel.dart';

class RoboticsViewMobile extends ViewModelWidget<RoboticsViewModel> {
  const RoboticsViewMobile({super.key});

   @override
  Widget build(BuildContext context, RoboticsViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                    width: 30,
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
                            //viewModel.navigateToInfoView();
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
                            //  viewModel.navigateToDownloadsView();
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color.fromARGB(255, 89, 6, 205),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('usernames')
                              .doc(user.email!)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (!snapshot.hasData) {
                              return const Text('');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            var fieldValue1 = snapshot.data!['image'];
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                image: DecorationImage(
                                  image: NetworkImage(fieldValue1),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('usernames')
                              .doc(user.email!)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (!snapshot.hasData) {
                              return const Text('');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            var fieldValue = snapshot.data!['name'];
                            return Text(
                              'Salut, $fieldValue',
                              style: const TextStyle(fontSize: 20),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 59, 56, 75),
                    width: double.infinity,
                    height: 80,
                    child: Center(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Container(
                            child: IconButton(
                                onPressed: () {
                                  viewModel.navigateToHomeView();
                                },
                                icon: Icon(
                                  Icons.home,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Container(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.batch_prediction_rounded,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Container(
                            child: IconButton(
                                onPressed: () {
                                  // viewModel.navigateToLearnView();
                                },
                                icon: Icon(
                                  Icons.question_mark,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Container(
                            child: IconButton(
                                onPressed: () {
                                  viewModel.navigateToAICOACH();
                                },
                                icon: Icon(
                                  Icons.alternate_email_sharp,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Container(
                            child: IconButton(
                                onPressed: () {
                                  viewModel.navigateToProfileView();
                                },
                                icon: Icon(
                                  Icons.person_pin_rounded,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Container(
                            child: IconButton(
                                onPressed: () {
                                  viewModel.signUserOut();
                                },
                                icon: Icon(
                                  Icons.exit_to_app_rounded,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    )),
                  ),
                  Container(
                    width: double.infinity,
                     decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 21, 20, 23),
                Color.fromARGB(255, 35, 33, 37),
                Color.fromARGB(255, 45, 41, 55),
              ])),
                    child: Column(
                      children: [
                        Container(
                         
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            color: Color.fromARGB(86, 255, 255, 255)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(360),
                                            ),
                                            child: Icon(Icons.design_services_outlined,
                                                size: 150, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'D E S I G N',
                                      style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.w100),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          color: Color.fromARGB(86, 255, 255, 255)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                          ),
                                          child: Icon(Icons.computer,
                                              size: 150, color:  Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'P R O G R A M A R E',
                                      style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.w100),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          color: Color.fromARGB(86, 255, 255, 255)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                          ),
                                          child: Icon(
                                              Icons.settings_input_composite_outlined,
                                              size: 150,
                                              color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  196,
                                                                  0),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'R O B O T I C Ă',
                                      style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.w100),
                                    )
                                  ],
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
          ],
        ),
      ),
    );
  }
}
