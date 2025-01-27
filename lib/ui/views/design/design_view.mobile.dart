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
import 'design_viewmodel.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'register_web_webview_stub.dart'
    if (dart.library.html) 'register_web_webview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'design_viewmodel.dart';

class DesignViewMobile extends ViewModelWidget<DesignViewModel> {
  const DesignViewMobile({super.key});

  @override
  Widget build(BuildContext context, DesignViewModel viewModel) {
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
                                onPressed: () {
                                  viewModel.navigateToPostsView();
                                },
                                icon: Icon(
                                  Icons.batch_prediction_rounded,
                                  color: Colors.white70,
                                  size: 30.0,
                                ))),
                        Container(
                            child: IconButton(
                                onPressed: () {
                                   viewModel.navigateToLearnView();
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
                                      onTap: () {
                                        viewModel.navigateToDesignView();
                                      },
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
                                                size: 150, color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  196,
                                                                  0),),
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
                                GestureDetector(
                                  onTap: () {
                                        viewModel.navigateToCodeView();
                                      },
                                  child: Column(
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
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                        viewModel.navigateToRoboticsView();
                                      },
                                  child: Column(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                       Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          //height: 1800,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(212, 105, 27, 221)
                                          ),
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
                                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%202%2Flogos.png?alt=media&token=7ae8ed21-b9a6-46c0-9a14-4d5fdcfc7432',
                                                          )),
                                                        )),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                        
                                                          Text(
                                                            'LOGO DESIGN   ',
                                                            style: ktsTitleText,
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              color: Color.fromARGB(68, 255, 255, 255)),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(20.0),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: 450,
                                                                      child: Text(
                                                                        'Logo-urile sunt importante pentru proiectele de informatică și aplicații deoarece ajută utilizatorii să recunoască și să-și amintească creația ta. Ele fac aplicația să pară mai profesionistă și de încredere, ceea ce poate atrage și păstra mai mulți utilizatori.',
                                                                        style: ktsBodyLarge
                                                                            .copyWith(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w600,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start, // Aligns text to the start (left).
                                                                        softWrap:
                                                                            true, // Enables soft wrapping.
                                                                        overflow:
                                                                            TextOverflow
                                                                                .visible, // Makes overflow text visible (default behavior).
                                                                        maxLines:
                                                                            null, // Allows text to use as many lines as necessary.
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        // Input Field
                                                                        
                                                                      
                                                                        
                                                                      
                                                                        // Notify Button
                                                                        Column(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                // viewModel.navigateToLoginView();
                                                                              },
                                                                              child:
                                                                                  Container(
                                                                                padding:
                                                                                    const EdgeInsets
                                                                                        .symmetric(
                                                                                  horizontal:
                                                                                      20,
                                                                                  vertical:
                                                                                      16,
                                                                                ),
                                                                                alignment:
                                                                                    Alignment
                                                                                        .center,
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                  gradient: LinearGradient(
                                                                                      begin:
                                                                                          Alignment.topCenter,
                                                                                      colors: [
                                                                                        Color.fromARGB(255, 224, 60, 5),
                                                                                        Color.fromARGB(255, 207, 29, 1),
                                                                                        Color.fromARGB(255, 211, 14, 67)
                                                                                      ]),
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(8),
                                                                                ),
                                                                                child:
                                                                                    Container(
                                                                                      width: 360,
                                                                                      child: const Text(
                                                                                                                                                                    'Un Logo sau un App Icon poate fi creeat prin diverse moduri, cu instrumente manuale (Canva, Photopea, Illustrator, etc.) și cu Instrumente AI (Adobe Firefly, Pixlr, Craiyon, etc.)',
                                                                                                                                                                    style: TextStyle(
                                                                                        color:
                                                                                            Colors.white,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontSize: 15),
                                                                                                                                                                  ),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                   
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 770,
                                                      child: Text('Instrumente pentru începători', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                    const url =
                                                        'https://www.canva.com';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages-1.jpg?alt=media&token=00f5a5c8-8fb4-4d27-9229-d3be8f64ead1',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'C A N V A', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 199, 5, 63),
                                                                  Color.fromARGB(255, 230, 13, 71),
                                                                  Color.fromARGB(255, 254, 13, 105),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('9+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                         onTap: () async {
                                                    const url =
                                                        'https://pixlr.com';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Funnamed.jpg?alt=media&token=20c1d97c-6cc0-47b5-8027-d09e17361dcc',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'P I X L R', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 199, 31, 5),
                                                                  Color.fromARGB(255, 230, 67, 13),
                                                                  Color.fromARGB(255, 254, 165, 13),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('11+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                         onTap: () async {
                                                    const url =
                                                        'https://www.craiyon.com';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Flogo-Craiyon%20copy.jpg?alt=media&token=ab6898e0-eb2f-4f41-826d-9ed5af78d09c',
                                                                      
                                                                    ),
                                                                    fit: BoxFit.cover
                                                                    
                                                                    ),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'C R A I Y O N', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 199, 31, 5),
                                                                  Color.fromARGB(255, 230, 67, 13),
                                                                  Color.fromARGB(255, 254, 165, 13),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('11+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                         onTap: () async {
                                                    const url =
                                                        'https://www.adobe.com/products/firefly.html';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2FAdobe_Firefly_Logo.svg.png?alt=media&token=7004ef15-46b3-4f2b-a8b0-2f5873fafcff',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                                                                                       'F I R E F L Y ', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                                                                                     ),
                                                          SizedBox(height: 10,),
                                                          Column(
                                                            children: [
                                                              
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                      Color.fromARGB(255, 5, 125, 199),
                                                                      Color.fromARGB(255, 34, 41, 186),
                                                                      Color.fromARGB(255, 125, 13, 254),
                                                                    ]),
                                                                      borderRadius: BorderRadius.circular(360),
                                                                    ),
                                                                    child: Center(child: Text('12+', style: TextStyle(fontSize: 20),)),
                                                                  ),
                                                                  SizedBox(width: 10,),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                         
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                    const url =
                                                        'https://www.photopea.com';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fphotopea-logo.webp?alt=media&token=f73881ac-9f37-467d-8859-c9eece73d81c',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'P H O T O P E A', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 5, 125, 199),
                                                                  Color.fromARGB(255, 34, 41, 186),
                                                                  Color.fromARGB(255, 125, 13, 254),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('12+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          ),
                                                         
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                 SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                   child: Row(children: [
                                                           SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                             child: Container(
                                                              width: 800,
                                                              height: 300 ,
                                                              decoration: BoxDecoration(
                                                                color: const Color.fromARGB(129, 0, 0, 0),
                                                                borderRadius: BorderRadius.circular(300)
                                                              ),
                                                               child: SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                 child: Row(
                                                                   children: [
                                                                     ClipRRect(
                                                                                                             //key: section1Key ,
                                                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                                                             child: SizedBox(
                                                                                                               width: 400,
                                                                                                               height: 240,
                                                                                                               
                                                                                                               child:  WebView(
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a5618f24609a84bcd3f7d9--classy-sprite-9c8b46.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                                                           SizedBox(width: 20,),
                                                                                                          ClipRRect(
                                                                                                             //key: section1Key ,
                                                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                                                             child: SizedBox(
                                                                                                               width: 400,
                                                                                                               height: 240,
                                                                                                               
                                                                                                               child:  WebView(
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a57ce19bd45997bb255d01--timely-piroshki-b45b90.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                                                            SizedBox(width: 20,),
                                                                                                          ClipRRect(
                                                                                                             //key: section1Key ,
                                                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                                                             child: SizedBox(
                                                                                                               width: 400,
                                                                                                               height: 240,
                                                                                                               
                                                                                                               child:  WebView(
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a57d60b95c2e8fbbc985dd--idyllic-marzipan-de0d36.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                        ],),
                                                 ),
                                                 SizedBox(height: 40,),
                                                  
                                                
                                              ],
                                            ),
                                          ),
                                          

                                        ),
                                      ),
                                      SizedBox(height: 30,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          //height: 1800,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(211, 228, 1, 54)
                                          ),
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
                                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Foutput-onlinepngtools.png?alt=media&token=7e9915ca-0757-4c95-8d25-26022492a0e2',
                                                          )),
                                                        )),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                        
                                                          Text(
                                                            'MODELARE 3D   ',
                                                            style: ktsTitleText,
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              color: Color.fromARGB(68, 255, 255, 255)),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(20.0),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: 450,
                                                                      child: Text(
                                                                        'Modelarea 3D ajută proiectele STEM și de robotică prin crearea aspectului și a componentelor robotului înainte de construcție. Aceasta permite vizualizarea designului, optimizarea structurilor și testarea componentelor virtual, asigurând o integrare perfectă. Astfel, proiectele devin mai precise, eficiente și inovatoare.',
                                                                        style: ktsBodyLarge
                                                                            .copyWith(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w600,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start, // Aligns text to the start (left).
                                                                        softWrap:
                                                                            true, // Enables soft wrapping.
                                                                        overflow:
                                                                            TextOverflow
                                                                                .visible, // Makes overflow text visible (default behavior).
                                                                        maxLines:
                                                                            null, // Allows text to use as many lines as necessary.
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        // Input Field
                                                                        
                                                                      
                                                                        
                                                                      
                                                                        // Notify Button
                                                                        Column(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                // viewModel.navigateToLoginView();
                                                                              },
                                                                              child:
                                                                                  Container(
                                                                                padding:
                                                                                    const EdgeInsets
                                                                                        .symmetric(
                                                                                  horizontal:
                                                                                      20,
                                                                                  vertical:
                                                                                      16,
                                                                                ),
                                                                                alignment:
                                                                                    Alignment
                                                                                        .center,
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                  gradient: LinearGradient(
                                                                                      begin:
                                                                                          Alignment.topCenter,
                                                                                      colors: [
                                                                                        Color.fromARGB(255, 224, 60, 5),
                                                                                        Color.fromARGB(255, 207, 29, 1),
                                                                                        Color.fromARGB(255, 211, 14, 67)
                                                                                      ]),
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(8),
                                                                                ),
                                                                                child:
                                                                                    Container(
                                                                                      width: 360,
                                                                                      child: const Text(
                                                                                                                                                                    'Orice 3D Model poate fi creeat ori cu instrumente Online (Tinkercad, Vectary, Sketch Up, etc.) și cu Instrumente Desktop (Blender, Autodesk 3DS MAX)',
                                                                                                                                                                    style: TextStyle(
                                                                                        color:
                                                                                            Colors.white,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontSize: 15),
                                                                                                                                                                  ),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                   
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 770,
                                                      child: Text('Instrumente pentru începători', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: [
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
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages.jpg?alt=media&token=88aeae2e-6e8f-4f68-ae1d-592ba27c4810',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'T I N K E R C A D', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 199, 5, 63),
                                                                  Color.fromARGB(255, 230, 13, 71),
                                                                  Color.fromARGB(255, 254, 13, 105),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('6+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                         onTap: () async {
                                                    const url =
                                                        'https://www.blender.org';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2F1dbRCWDq_400x400.jpg?alt=media&token=b880f055-df0e-4862-9976-0bf5fa875365',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'B L E N D E R', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 199, 31, 5),
                                                                  Color.fromARGB(255, 230, 67, 13),
                                                                  Color.fromARGB(255, 254, 165, 13),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('12+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                         onTap: () async {
                                                    const url =
                                                        'https://www.vectary.com';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2F636cc9840038711844a59a7d_vectary_logo_article_OG.jpg?alt=media&token=bc1f4cf5-e09c-4c6b-aa9d-6226e8c3b891',
                                                                      
                                                                    ),
                                                                    fit: BoxFit.cover
                                                                    
                                                                    ),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            'V E C T A R Y', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 199, 31, 5),
                                                                  Color.fromARGB(255, 230, 67, 13),
                                                                  Color.fromARGB(255, 254, 165, 13),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('11+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                         onTap: () async {
                                                    const url =
                                                        'https://www.sketchup.com/en/plans-and-pricing/sketchup-free';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Flarge_thumbnail.webp?alt=media&token=1fad81ee-eecd-4c4f-9f63-906e28b4721f',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                                                                                       'S K E T C H  U P ', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                                                                                     ),
                                                          SizedBox(height: 10,),
                                                          Column(
                                                            children: [
                                                              
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                      Color.fromARGB(255, 5, 125, 199),
                                                                      Color.fromARGB(255, 34, 41, 186),
                                                                      Color.fromARGB(255, 125, 13, 254),
                                                                    ]),
                                                                      borderRadius: BorderRadius.circular(360),
                                                                    ),
                                                                    child: Center(child: Text('14+', style: TextStyle(fontSize: 20),)),
                                                                  ),
                                                                  SizedBox(width: 10,),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                         
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                    const url =
                                                        'https://www.autodesk.com/products/3ds-max/overview?term=1-YEAR&tab=subscription';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                        child: Container(
                                                        
                                                           height: 200,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                          child: Column(
                                                        
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(360),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages.png?alt=media&token=0baf847d-b25f-4a4d-a3af-e7eefc87ff46',
                                                                    )),
                                                                  )),
                                                                  SizedBox(height: 5,),
                                                               Text(
                                                            '3 D S  M A X', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                                                                  Color.fromARGB(255, 5, 125, 199),
                                                                  Color.fromARGB(255, 34, 41, 186),
                                                                  Color.fromARGB(255, 125, 13, 254),
                                                                ]),
                                                                  borderRadius: BorderRadius.circular(360),
                                                                ),
                                                                child: Center(child: Text('14+', style: TextStyle(fontSize: 20),)),
                                                              ),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          ),
                                                         
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                 SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                   child: Row(children: [
                                                           SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                             child: Container(
                                                              width: 800,
                                                              height: 300 ,
                                                              decoration: BoxDecoration(
                                                                color: const Color.fromARGB(129, 0, 0, 0),
                                                                borderRadius: BorderRadius.circular(300)
                                                              ),
                                                               child: SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                 child: Row(
                                                                   children: [
                                                                     ClipRRect(
                                                                                                            
                                                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                                                             child: SizedBox(
                                                                                                               width: 400,
                                                                                                               height: 240,
                                                                                                               
                                                                                                               child:  WebView(
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a61a6b76df8d14a95a25e2--inquisitive-selkie-3d8920.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                                                           SizedBox(width: 20,),
                                                                                                          ClipRRect(
                                                                                                             //key: section1Key ,
                                                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                                                             child: SizedBox(
                                                                                                               width: 400,
                                                                                                               height: 240,
                                                                                                               
                                                                                                               child:  WebView(
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a61bc9744d330bd36aacac--chipper-truffle-4234c8.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                                                            SizedBox(width: 20,),
                                                                                                          ClipRRect(
                                                                                                             //key: section1Key ,
                                                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                                                             child: SizedBox(
                                                                                                               width: 400,
                                                                                                               height: 240,
                                                                                                               
                                                                                                               child:  WebView(
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a61c791fc25e0f10b34fe2--gleaming-semifreddo-e7038c.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                        ],),
                                                 ),
                                                 SizedBox(height: 40,),
                                                
                                                  
                                              ],
                                            ),
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

