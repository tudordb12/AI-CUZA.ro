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

class RoboticsViewDesktop extends ViewModelWidget<RoboticsViewModel> {
  const RoboticsViewDesktop({super.key});

  @override
  Widget build(BuildContext context, RoboticsViewModel viewModel) {
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
                            height: 1800,
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
                                      color: Color.fromARGB(255, 148, 68, 22),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://images.pexels.com/photos/2599244/pexels-photo-2599244.jpeg?cs=srgb&dl=pexels-agk42-2599244.jpg&fm=jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 200,
                                  left: 130,
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
                                                              Colors.white),
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
                                                        color: Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  196,
                                                                  0)),
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
                                          //height: 1800,
                                          
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(219, 234, 0, 43)
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
                                                          
                                                        ),
                                                                            child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image.asset(
                                                    'lib/assets/start.png',
                                                  
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                                        ),
                                                        
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                        
                                                          Text(
                                                            'ROBOTICĂ',
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
                                                                        'Robotica este un domeniu fascinant al ingineriei care combină electronică, informatică și mecanică pentru a crea mașini inteligente capabile să efectueze diverse sarcini. Aceste "roboți" pot varia de la brațe industriale precise la drone zburătoare sau roboți umanoizi care imită mișcările umane. Prin dezvoltarea robotilor, se explorează noi metode de automatizare și eficientizare a proceselor în diverse industrii, inclusiv medicină, explorare spațială și agricultură. Robotica nu doar că îmbunătățește viețile oamenilor, dar deschide și calea către inovații tehnologice surprinzătoare.',
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
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                        Color.fromARGB(255, 255, 170, 0),
                                                                                        Color.fromARGB(255, 255, 170, 0),
                                                                                        Color.fromARGB(255, 255, 140, 0)
                                                                                      ]),
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(8),
                                                                                ),
                                                                                child:
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                          Icons.warning,
                                                                          color: Colors.white,
                                                                          size: 40,
                                                                        ),
                                                                        SizedBox(width: 10,),
                                                                                        Container(
                                                                                          width: 400,
                                                                                          child: const Text(
                                                                                                                                                                        'Robotica este interconectată cu designul și programarea prin crearea de structuri funcționale și eficiente, implementarea de algoritmi pentru control și interacțiune, și optimizarea performanței. Designul se ocupă de aspectul fizic și ergonomic al robotului, asigurându-se că acesta poate efectua sarcini specifice. Programarea dezvoltă software-ul necesar pentru ca robotul să execute mișcări precise și să răspundă la stimuli din mediu, integrând senzori și actuatori pentru funcționalitate completă.',
                                                                                                                                                                        style: TextStyle(
                                                                                            color:
                                                                                                Colors.white,
                                                                                            fontWeight: FontWeight.w700,
                                                                                            fontSize: 15),
                                                                                                                                                                      ),
                                                                                        ),
                                                                                      ],
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
                                                      child: Text('Instrumente Digitale De Robotică', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                  const url =
                                                      'https://www.arduino.cc/en/software';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Farduino-logo-1.png?alt=media&token=1109bb8f-5941-47f5-ac6b-2124081fcd4d',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'A R D U I N O  I D E', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://www.microsoft.com/en-us/makecode';
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
                                                                    'https://blog.generationrobots.com/wp-content/uploads/2020/04/carte-microbit.jpg',
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'M A K E C O D E', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                    InkWell(
                                                       onTap: () async {
                                                  const url =
                                                      'https://www.tinkercad.com/circuits';
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
                                                                    
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'C I R C U I T S', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                                  child: Center(child: Text('11+', style: TextStyle(fontSize: 20),)),
                                                                ),
                                                            SizedBox(width: 10,),
                                                          ],
                                                        )
                                                          ],
                                                        ),
                                                      ),
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
                                                      child: Text('Câteva Tipuri De Roboți', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                  
                                                 
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/images%2F1716562039604.jpg?alt=media&token=7c175442-5e33-4a64-9562-a95c0d070e53',
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'O T T O', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                              child: Center(child: Text('7+', style: TextStyle(fontSize: 20),)),
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
                                                                    'https://www.hiwonder.com/cdn/shop/products/TonyPi2.jpg?v=1630308476',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'T O N I  P I', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                                    'https://sphero.com/cdn/shop/products/microbitProductDetail_ActivityObstacles_800x.jpg?v=1627579359',
                                                                    
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'M I C R O B I T', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                                    'https://ro.farnell.com/productimages/large/en_GB/3051885-40.jpg',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                                                                                     'R A S P B E R R Y  P I', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                                    'https://ro.mouser.com/images/arduino/lrg/A000066_t.jpg',
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'A R D U I N O', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                              child: Center(child: Text('13+', style: TextStyle(fontSize: 20),)),
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
                                                SizedBox(height: 20,),
                                                 
                                              ],
                                            ),
                                          ),
                                          

                                        ),
                                      ),
                                      SizedBox(height: 30,),
                                      
                                      
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
      RoboticsViewModel viewModel, int index2, String text, VoidCallback onTap) {
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
