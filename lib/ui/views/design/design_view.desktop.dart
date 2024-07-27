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

class DesignViewDesktop extends ViewModelWidget<DesignViewModel> {
  const DesignViewDesktop({super.key});

  @override
  Widget build(BuildContext context, DesignViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;

    final String currentUserEmail =
        user.email!; // Replace with the actual current user email

    final GlobalKey section1Key = GlobalKey();

    Future<List<Map<String, dynamic>>> fetchFollowingUsers() async {
      List<Map<String, dynamic>> followingUsers = [];

      // Fetch the current user's following list
      DocumentSnapshot followingDoc = await FirebaseFirestore.instance
          .collection('following')
          .doc(currentUserEmail)
          .get();

      if (followingDoc.exists) {
        List<dynamic> followingEmails = followingDoc['following'];

        // Fetch the corresponding user details from the usernames collection
        for (String email in followingEmails) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('usernames')
              .doc(email)
              .get();

          if (userDoc.exists) {
            final userData = userDoc.data();
            if (userData != null && userData is Map<String, dynamic>) {
              followingUsers.add(userData);
            }
          }
        }
      }

      return followingUsers;
    }

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: double.infinity - 100,
            height: 950,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 21, 20, 23),
                Color.fromARGB(255, 35, 33, 37),
                Color.fromARGB(255, 45, 41, 55),
              ]),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                              SizedBox(width: 30),
                              InkWell(
                                onTap: () {
                                  // viewModel.navigateToHomeView();
                                },
                                child: Text(
                                  'Acasă',
                                  style: ktsBodyRegular.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 30),
                              InkWell(
                                onTap: () {
                                  // viewModel.navigateToInfoView();
                                },
                                child: Text(
                                  'Creează-ți propriul CUZA',
                                  style: ktsBodyRegular.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 30),
                              InkWell(
                                onTap: () {
                                  // viewModel.navigateToDownloadsView();
                                },
                                child: Text(
                                  'Descărcări',
                                  style: ktsBodyRegular.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 30),
                              InkWell(
                                onTap: () {
                                  // viewModel.navigateToAuthView();
                                },
                                child: Text(
                                  'Contul Meu',
                                  style: ktsBodyRegular.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 30),
                              InkWell(
                                onTap: () {
                                  // viewModel.signUserOut();
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
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 850,
                  child: Row(
                    children: [
                      Container(
                        height: 950,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 59, 56, 75),
                        ),
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(flex: 2),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('usernames')
                                      .doc(user.email!)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {}
                      
                                    if (!snapshot.hasData) {
                                      return Text('');
                                    }
                      
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                      
                                    var fieldValue1 = snapshot.data!['image'];
                      
                                    return Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          color: Color.fromARGB(
                                              178, 255, 255, 255)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(fieldValue1),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Salut, ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100),
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('usernames')
                                      .doc(user.email!)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {}
                      
                                    if (!snapshot.hasData) {
                                      return Text('');
                                    }
                      
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                      
                                    var fieldValue = snapshot.data!['name'];
                      
                                    return Text(
                                      '$fieldValue',
                                      style: TextStyle(fontSize: 20),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color.fromARGB(255, 171, 167, 200),
                                    height: 5,
                                    thickness: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Spacer(flex: 2),
                                    Icon(
                                      Icons.home,
                                      color: Colors.white70,
                                      size: 25.0,
                                    ),
                                    SizedBox(width: 5),
                                    _buildHoverContainer(
                                        viewModel, 1, '     A C A S Ă     ',
                                        () {
                                      viewModel.navigateToHomeView();
                                    }),
                                    Spacer(flex: 2),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Spacer(flex: 2),
                                    Icon(
                                      Icons.batch_prediction_rounded,
                                      color: Colors.white70,
                                      size: 25.0,
                                    ),
                                    SizedBox(width: 5),
                                    _buildHoverContainer(
                                        viewModel, 2, 'P O S T Ă R I', () {
                                      // Action for TEST1 container
                                    }),
                                    Spacer(flex: 2),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Spacer(flex: 2),
                                    Icon(
                                      Icons.question_mark,
                                      color: Colors.white70,
                                      size: 25.0,
                                    ),
                                    SizedBox(width: 5),
                                    _buildHoverContainer(
                                        viewModel, 3, 'D E S C O P E R Ă',
                                        () {
                                      // Action for TEST1 container
                                    }),
                                    Spacer(flex: 2),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Spacer(flex: 2),
                                    Icon(
                                      Icons.alternate_email_sharp,
                                      color: Colors.white70,
                                      size: 25.0,
                                    ),
                                    SizedBox(width: 5),
                                    _buildHoverContainer(
                                        viewModel, 4, 'A I  C O A C H', () {
                                      viewModel.navigateToAICOACH();
                                    }),
                                    Spacer(flex: 2),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Spacer(flex: 2),
                                    Icon(
                                      Icons.person_pin_rounded,
                                      color: Colors.white70,
                                      size: 25.0,
                                    ),
                                    SizedBox(width: 5),
                                    _buildHoverContainer(viewModel, 5,
                                        'P R O F I L U L   M E U', () {
                                      viewModel.navigateToProfileView();
                                    }),
                                    Spacer(flex: 2),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Spacer(flex: 2),
                                    Icon(
                                      Icons.exit_to_app_rounded,
                                      color: Colors.white70,
                                      size: 25.0,
                                    ),
                                    SizedBox(width: 5),
                                    _buildHoverContainer(
                                        viewModel, 6, 'I E Ș I R E', () {
                                      viewModel.signUserOut();
                                    }),
                                    Spacer(flex: 2),
                                  ],
                                ),
                                const Spacer(flex: 2),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            height: 2700,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(84, 52, 51, 51),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 98, 22, 148),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/depositphotos_219003960-stock-photo-portrait-focused-woman-headphones-taking.webp?alt=media&token=1c4536c0-6846-482b-915f-26d4b6ae6fa2'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 200,
                                  left: 70,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    viewModel.scrollToSection(
                                                        section1Key),
                                                child: Container(
                                                  height: 250,
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(360),
                                                      color: Color.fromARGB(
                                                          86, 255, 255, 255)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    360),
                                                      ),
                                                      child: Icon(
                                                          Icons
                                                              .design_services_outlined,
                                                          size: 150,
                                                          color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  196,
                                                                  0)),
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
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 250,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            360),
                                                    color: Color.fromARGB(
                                                        86, 255, 255, 255)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(360),
                                                    ),
                                                    child: Icon(
                                                        Icons.computer,
                                                        size: 150,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'P R O G R A M A R E',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 250,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            360),
                                                    color: Color.fromARGB(
                                                        86, 255, 255, 255)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(360),
                                                    ),
                                                    child: Icon(
                                                        Icons
                                                            .settings_input_composite_outlined,
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
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 1800,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(255, 104, 27, 221)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Row(
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
                                                          Center(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: 450,
                                                                  child: Text(
                                                                    'Logo-urile sunt importante pentru proiectele de informatică și aplicații deoarece ajută utilizatorii să recunoască și să-și amintească produsul tău. Ele fac aplicația să pară mai profesionistă și de încredere, ceea ce poate atrage și păstra mai mulți utilizatori.',
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
                                                                                  width: 400,
                                                                                  child: const Text(
                                                                                                                                                                'Un Logo sau un App Icon poate fi creeat prin diverse moduri, cu instrumente manuale (Canva, Photopea, Illustrator, etc.) și cu Instrumente AI (Adobe Firefly, Pixlr, Craryion, etc.)',
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
                                                        ]),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                   
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Row(
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
                                                                Color.fromARGB(255, 199, 31, 5),
                                                                Color.fromARGB(255, 230, 67, 13),
                                                                Color.fromARGB(255, 254, 165, 13),
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
                                                    Container(

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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(

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
                                                        'C R A Y I O N', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(

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
                                                              Color.fromARGB(255, 199, 31, 5),
                                                              Color.fromARGB(255, 230, 67, 13),
                                                              Color.fromARGB(255, 254, 165, 13),
                                                            ]),
                                                              borderRadius: BorderRadius.circular(360),
                                                            ),
                                                            child: Center(child: Text('9+', style: TextStyle(fontSize: 20),)),
                                                          ),
                                                          SizedBox(width: 10,),
                                                        ],
                                                      ),
                                                     
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(

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
                                                              Color.fromARGB(255, 199, 31, 5),
                                                              Color.fromARGB(255, 230, 67, 13),
                                                              Color.fromARGB(255, 254, 165, 13),
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
                                                  ],
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
                                                  ClipRRect(
                                        //key: section1Key ,
                                         borderRadius: BorderRadius.circular(40.0),
                                        child: SizedBox(
                                          width: 900,
                                          height: 700,
                                          
                                          child:  WebView(
                                            
                                            initialUrl: 'https://www.photopea.com',
                                            javascriptMode: JavascriptMode.unrestricted,
                                          ),
                                        ),
                                      ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoverContainer(
      DesignViewModel viewModel, int index2, String text, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => viewModel.setHovering(index2, true),
      onExit: (_) => viewModel.setHovering(index2, false),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: viewModel.isHovering(index2)
              ? Color.fromARGB(255, 227, 30, 0)
              : Color.fromARGB(255, 59, 56, 75),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
