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
import 'code_viewmodel.dart';

class CodeViewDesktop extends ViewModelWidget<CodeViewModel> {
  const CodeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, CodeViewModel viewModel) {
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
                            height: 3500,
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
                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fdepositphotos_243120806-stock-photo-programmer-working-software-development-coding.webp?alt=media&token=a29b66c3-5a41-415e-9163-241ec7004549'),
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
                                          //height: 1800,
                                          
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(219, 255, 89, 0)
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
                                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/code%2Fimage.png?alt=media&token=af68a0af-c564-4c8a-abe9-686f14fcb3ac',
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
                                                            'APLICAȚII',
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
                                                                        'Programarea unei interfețe și a caracteristicilor funcționale este esențială pentru proiectele informatice, transformând ideile în experiențe utilizabile și captivante. De exemplu, în aplicațiile mobile, interfața intuitivă facilitează navigarea, în timp ce funcții precum recunoașterea vocală, analiza datelor în timp real și controlul prin gesturi aduc inovație și eficiență. Alte exemple includ aplicațiile de prezență care folosesc scanarea QR pentru acces rapid, platformele de social media care integrează chatbots pentru asistență instantanee și jocurile care oferă realitate augmentată pentru o experiență imersivă. Aceste elemente fac proiectele nu doar funcționale, ci și atrăgătoare și utile pentru utilizatori.',
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
                                                                                        Color.fromARGB(255, 224, 60, 5),
                                                                                        Color.fromARGB(255, 207, 29, 1),
                                                                                        Color.fromARGB(255, 211, 14, 67)
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
                                                                                                                                                                        'Cel mai important însă, e faptul că Robotica depinde de programare, nu doar pentru conectarea acesteia la anumite interfațe, dar și funcțiile robotului ce sunt pot fi de asemenea prezente în proiecte software.',
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
                                                      child: Text('Instrumente pentru Design De Interfață', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                  const url =
                                                      'https://www.thunkable.com';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/code%2Fimages.png?alt=media&token=6ec9b1c1-81b0-401e-a9a1-61949adfb83c',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'T H U N K A B L E', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://flutterflow.io';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/code%2Fflutterflow_logo.jpg?alt=media&token=9c1b2c9b-ca9e-4078-801d-6ea48c7785d8',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'F L U T T E R F L O W', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://www.figma.com';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/code%2F1578556490672.jpg?alt=media&token=4a1e0afc-5011-4903-9698-bc5076b30ce4',
                                                                    
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'F I G M A', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                        )
                                                          ],
                                                        ),
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
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a6781efa72055c62655412--zippy-buttercream-8831c7.netlify.app',
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
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a6790a744d335b796aac02--gorgeous-palmier-8fbc59.netlify.app',
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
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a679df9f41aa5f392496f2--fanciful-speculoos-9e1fef.netlify.app',
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
                                                
                                                SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 770,
                                                      child: Text('Limbaje de Programare', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                  const url =
                                                      'https://scratch.mit.edu';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fscratch_placeholder.webp?alt=media&token=7dcd1a4d-a20c-48ad-adac-16ac736d991d',
                                                                  ),
                                                                  fit: BoxFit.cover),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'S C R A T C H', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                  const url =
                                                      'https://visualstudio.microsoft.com';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2FC_Sharp_Logo_2023.svg.png?alt=media&token=df541fc9-f8da-4721-b7d2-5b628886a5cc',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'C  S H A R P', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://www.w3schools.com/html/';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2FHTML5_logo_and_wordmark.svg.png?alt=media&token=62765f71-2ebf-4959-8bfc-0cef46d356a0',
                                                                    
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'H T M L', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://www.python.org';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fpython-programming-language.webp?alt=media&token=2c51b760-14a3-4996-9e4a-b406179c2602',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                                                                                     'P Y T H O N', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://flutter.dev';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fflutter5786-1.jpg?alt=media&token=7162cfab-0e48-47c8-a923-050ce8ee1103',
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'F L U T T E R', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          //height: 1800,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(210, 69, 56, 207)
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
                                                            'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimage123.png?alt=media&token=09a0d4cc-95aa-4c48-be90-54dab5f270ae',
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
                                                            'MACHINE\n LEARNING',
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
                                                                        'Machine Learning (ML) permite computerelor să învețe din date și să ia decizii automate. Regresia liniară prezice valori numerice bazate pe relații între variabile. Clasificarea împarte datele în categorii, cum ar fi filtrarea spam-ului. Învățarea neasistată, prin clustering, grupează date similare fără etichete predefinite. Rețelele neuronale imită creierul uman pentru a recunoaște modele complexe.',
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
                                                                                                                                                                    'Machine Learning îmbunătățește un proiect de robotică prin calibrarea senzorilor cu regresia liniară pentru estimări precise și prin utilizarea clasificării pentru recunoașterea obiectelor. Învățarea neasistată (clustering) ajută la segmentarea mediului pentru o navigare autonomă eficientă. Rețelele neuronale avansate permit recunoașterea vocală și vizuală, sporind percepția și controlul robotului.',
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
                                                      child: Text('Instrumente de Machine Learning', style: TextStyle(fontSize: 25),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                  const url =
                                                      'https://chatgpt.com';
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fchatgpt-logo-chat-gpt-icon-on-black-background-free-vector.jpg?alt=media&token=a152f875-6121-418c-bb6a-7ae4e8e15a90',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'O P E N  A I', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                      'https://teachablemachine.withgoogle.com';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                      child: Container(
                                                      
                                                         height: 250,
                                                                width: 160,
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages-3.png?alt=media&token=2c441f9d-8276-4b8f-b0a3-956504f05af0',
                                                                  )),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Container(
                                                              width: 110,
                                                               child: Text(
                                                                                                                         'T E A C H A B L E\n M A C H I N E', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63), ),
                                                                                                                       ),
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
                                                      'https://machinelearningforkids.co.uk';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                      child: Container(
                                                      
                                                         height: 250,
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
                                                                    'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fimages-2.png?alt=media&token=2671a1d1-91ac-4215-a1c6-3cf6bfdf2008',
                                                                    
                                                                  ),
                                                                  fit: BoxFit.cover
                                                                  
                                                                  ),
                                                                )),
                                                                SizedBox(height: 5,),
                                                             Text(
                                                          'M A C H I N E\n L E A R N I N G\n FOR KIDS', style: TextStyle(color: const Color.fromARGB(255, 63, 63, 63)),
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
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a67ced9788dc5cd91963ea--fascinating-cannoli-7714f4.netlify.app',
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
                                                                                                                 
                                                                                                                 initialUrl: 'https://66a67e9b9788dc5f6c1962ce--tranquil-lamington-efc1cf.netlify.app',
                                                                                                                 javascriptMode: JavascriptMode.unrestricted,
                                                                                                               ),
                                                                                                             ),
                                                                                                           ),
                                                                                                            SizedBox(width: 20,),
                                                                                                         
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
      CodeViewModel viewModel, int index2, String text, VoidCallback onTap) {
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
