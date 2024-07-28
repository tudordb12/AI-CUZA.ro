import 'package:aicuzaro/ui/views/postspage/mobile_menu.dart';
import 'package:aicuzaro/ui/views/postspage/wall_post_mobile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/ui/common/app_colors.dart';
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
import 'learn_viewmodel.dart';

class LearnViewMobile extends ViewModelWidget<LearnViewModel> {
  const LearnViewMobile({super.key});

  @override
  Widget build(BuildContext context, LearnViewModel viewModel) {
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
                                              size: 150, color: Colors.white),
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
                                              color: Colors.white),
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
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      height: 400,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/f9a6e49278945f27668bf243584ffde4.png?alt=media&token=222f0d65-36a7-42a4-a373-78bcf998514d',
                                        )),
                                      )),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FadeInUp(
                                              duration: Duration(milliseconds: 1000),
                                              child: Container(
                                                width: 360,
                                                child: GradientText(
                                                  '  DESIGN',
                                                  style: ktsTitleText2,
                                                  colors: const [
                                                    Color.fromARGB(255, 98, 0, 255),
                                                    Color.fromARGB(255, 2, 194, 223)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FadeInUp(
                                              duration: Duration(milliseconds: 1500),
                                              child: Text(
                                                'CU CUZA',
                                                style: ktsTitleText,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(20.0),
                                                    child: Container(
                                                      width: 450,
                                                      child: Text(
                                                        'Designul joacă un rol crucial în informatică și robotică, transformând ideile tehnice în realități accesibile și eficiente. Imaginați-vă un robot care nu doar că funcționează impecabil, dar este și intuitiv de utilizat și plăcut vizual! Un software bine proiectat nu doar rezolvă probleme, ci oferă o experiență fluidă și satisfăcătoare utilizatorilor.',
                                                        style: ktsBodyLarge.copyWith(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 15,
                                                        ),
                                                        textAlign: TextAlign
                                                            .start, // Aligns text to the start (left).
                                                        softWrap:
                                                            true, // Enables soft wrapping.
                                                        overflow: TextOverflow
                                                            .visible, // Makes overflow text visible (default behavior).
                                                        maxLines:
                                                            null, // Allows text to use as many lines as necessary.
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(10.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        // Input Field
                        
                                                        horizontalSpaceSmall,
                        
                                                        // Notify Button
                                                        InkWell(
                                                          onTap: () {
                                                            // viewModel.navigateToLoginView();
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20,
                                                              vertical: 16,
                                                            ),
                                                            alignment:
                                                                Alignment.center,
                                                            decoration: BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      colors: [
                                                                    Color.fromARGB(
                                                                        255,
                                                                        224,
                                                                        60,
                                                                        5),
                                                                    Color.fromARGB(
                                                                        255,
                                                                        207,
                                                                        29,
                                                                        1),
                                                                    Color.fromARGB(
                                                                        255,
                                                                        211,
                                                                        14,
                                                                        67)
                                                                  ]),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(8),
                                                            ),
                                                            child: const Text(
                                                              'Mai Multe',
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                      FontWeight.w700,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages-1.jpg?alt=media&token=00f5a5c8-8fb4-4d27-9229-d3be8f64ead1',
                                          )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages.jpg?alt=media&token=88aeae2e-6e8f-4f68-ae1d-592ba27c4810',
                                          )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages.png?alt=media&token=0baf847d-b25f-4a4d-a3af-e7eefc87ff46',
                                          )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(360),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Flogo-Craiyon%20copy.jpg?alt=media&token=ab6898e0-eb2f-4f41-826d-9ed5af78d09c',
                                          )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2F1dbRCWDq_400x400.jpg?alt=media&token=b880f055-df0e-4862-9976-0bf5fa875365',
                                          )),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(64, 0, 0, 0),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Container(
                                    height: 400,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fcoding-svg-clipart-xl.png?alt=media&token=21244ae0-57f7-4289-a2b0-3dd3d426daaa',
                                      )),
                                    )),
                        
                                ///SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FadeInUp(
                                              duration: Duration(milliseconds: 1000),
                                              child: Container(
                                                width: 600,
                                                child: GradientText(
                                                  '       CODARE ',
                                                  style: ktsTitleText,
                                                  colors: const [
                                                    Color.fromARGB(255, 255, 188, 3),
                                                    Color.fromARGB(255, 223, 90, 2)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FadeInUp(
                                              duration: Duration(milliseconds: 1500),
                                              child: Text(
                                                '  CU CUZA',
                                                style: ktsTitleText,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 450,
                                                    child: Text(
                                                      'Programarea îți permite să creezi site-uri web interactive, jocuri captivante și aplicații mobile utile. Este o abilitate esențială pentru a dezvolta tehnologii inovatoare, automatiza sarcini repetitive și analiza date complexe. Prin programare, poți transforma idei abstracte în soluții practice și impactante în viața de zi cu zi.',
                                                      style: ktsBodyLarge.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign: TextAlign
                                                          .start, // Aligns text to the start (left).
                                                      softWrap:
                                                          true, // Enables soft wrapping.
                                                      overflow: TextOverflow
                                                          .visible, // Makes overflow text visible (default behavior).
                                                      maxLines:
                                                          null, // Allows text to use as many lines as necessary.
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      // Input Field
                        
                                                      horizontalSpaceSmall,
                        
                                                      // Notify Button
                                                      InkWell(
                                                        onTap: () {
                                                          // viewModel.navigateToLoginView();
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20,
                                                            vertical: 16,
                                                          ),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                colors: [
                                                                  Color.fromARGB(255,
                                                                      224, 60, 5),
                                                                  Color.fromARGB(255,
                                                                      207, 29, 1),
                                                                  Color.fromARGB(255,
                                                                      211, 14, 67)
                                                                ]),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                          ),
                                                          child: const Text(
                                                            'Mai Multe',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.w700,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    360),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2FJavaScript.jpg?alt=media&token=e2fcf53d-5fbb-4b04-8990-970ca50f5a3a',
                                                            )),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    360),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fchatgpt-logo-chat-gpt-icon-on-black-background-free-vector.jpg?alt=media&token=a152f875-6121-418c-bb6a-7ae4e8e15a90',
                                                            )),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    360),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2FHTML5_logo_and_wordmark.svg.png?alt=media&token=62765f71-2ebf-4959-8bfc-0cef46d356a0',
                                                            )),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    360),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fpython-programming-language.webp?alt=media&token=2c51b760-14a3-4996-9e4a-b406179c2602',
                                                            )),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    360),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2FC_Sharp_Logo_2023.svg.png?alt=media&token=df541fc9-f8da-4721-b7d2-5b628886a5cc',
                                                            )),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    360),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages-2.png?alt=media&token=2671a1d1-91ac-4215-a1c6-3cf6bfdf2008',
                                                            )),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                        
                                //SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        height: 400,
                                        width: 400,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimage.png?alt=media&token=f3afad3a-6b85-4ef2-9eaf-41e06c8617a6',
                                          )),
                                        )),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          FadeInUp(
                                            duration: Duration(milliseconds: 1000),
                                            child: Container(
                                              width: 600,
                                              child: GradientText(
                                                '      ROBOTICA',
                                                style: ktsTitleText2,
                                                colors: const [
                                                  Color.fromARGB(255, 98, 0, 255),
                                                  Color.fromARGB(255, 2, 194, 223)
                                                ],
                                              ),
                                            ),
                                          ),
                                          FadeInUp(
                                            duration: Duration(milliseconds: 1500),
                                            child: Text(
                                              'CU CUZA',
                                              style: ktsTitleText,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 450,
                                                  child: Text(
                                                    'Robotica combină designul creativ și programarea avansată pentru a construi soluții tehnologice remarcabile. Designul se concentrează pe aspectele fizice și estetice ale roboților, iar programarea se ocupă de funcționalitatea și inteligența acestora. Această fuziune permite realizarea unor proiecte complexe și inovatoare, cum ar fi umanoidul CUZA, care demonstrează abilități avansate de interacțiune și performanță în diverse domenii.',
                                                    style: ktsBodyLarge.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign
                                                        .start, // Aligns text to the start (left).
                                                    softWrap:
                                                        true, // Enables soft wrapping.
                                                    overflow: TextOverflow
                                                        .visible, // Makes overflow text visible (default behavior).
                                                    maxLines:
                                                        null, // Allows text to use as many lines as necessary.
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      // Input Field
                        
                                                      horizontalSpaceSmall,
                        
                                                      // Notify Button
                                                      InkWell(
                                                        onTap: () {
                                                          // viewModel.navigateToLoginView();
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20,
                                                            vertical: 16,
                                                          ),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                colors: [
                                                                  Color.fromARGB(255,
                                                                      224, 60, 5),
                                                                  Color.fromARGB(255,
                                                                      207, 29, 1),
                                                                  Color.fromARGB(255,
                                                                      211, 14, 67)
                                                                ]),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                          ),
                                                          child: const Text(
                                                            'Mai Multe',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight.w700,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/robot%2Fapps.12858.14445162896371762.45441340-1f2e-485b-a59c-8b88b4bceb1e.png?alt=media&token=feb6ae26-39d2-42d3-a873-49b7bfda9fdb',
                                            )),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/robot%2Fpng-transparent-arduino-hd-logo-thumbnail.png?alt=media&token=3bdd1aa0-0403-4fe0-857c-496f853f681c',
                                            )),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages-2.png?alt=media&token=2671a1d1-91ac-4215-a1c6-3cf6bfdf2008',
                                            )),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(360),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/robot%2Fraspberry-pi-icon-2048x2048-p0y4r07x.png?alt=media&token=1d8754f0-255d-4b63-91e0-37d0bdcdcb8b',
                                            )),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/robot%2Fimages-4.png?alt=media&token=d4eac269-d32d-43a1-b602-118cdf7ffe5f',
                                            )),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/robot%2Fimages-5.png?alt=media&token=ec4a8630-60dd-4c0d-87ea-07b5d0f1bde1',
                                            )),
                                          )),
                                    ],
                                  ),
                                )
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
