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
import 'learn_viewmodel.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'register_web_webview_stub.dart' if (dart.library.html) 'register_web_webview.dart';


class LearnViewDesktop extends ViewModelWidget<LearnViewModel> {
  const LearnViewDesktop({super.key});

  @override
  Widget build(BuildContext context, LearnViewModel viewModel) {
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
                Color.fromARGB(255, 51, 13, 105),
                Color.fromARGB(255, 51, 21, 91),
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
                      FadeInLeftBig(
                        child: Container(
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
                                        viewModel.navigateToHome();
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
                                          viewModel, 3, 'Î N T R E B Ă R I',
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
                      ),
                      Expanded(
                        child: FadeInRightBig(
                          child: SingleChildScrollView(
                            child: Container(
                              height: 3000,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(199, 52, 51, 51),
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
                                    left: 250,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => viewModel.scrollToSection(section1Key),
                                                  child: Container(
                                                        height: 250,
                                                        width: 250,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(360),
                                                            color: Color.fromARGB(86, 255, 255, 255)),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(360),
                                                             
                                                              ),
                                                               child: Icon(
                                                                 Icons.design_services_outlined,
                                                                size: 150,
                                                                color: Color.fromARGB(255, 255, 196, 0)
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                    SizedBox(height: 20,),
                                                    Text('D E S I G N', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),)
                                              ],
                                            ),
                                                SizedBox(width: 20,),
                                            Column(
                                              children: [
                                                Container(
                                                      height: 250,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(360),
                                                          color: Color.fromARGB(86, 255, 255, 255)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(15.0),
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(360),
                                                           
                                                            ),
                                                             child: Icon(
                                                               Icons.computer,
                                                              size: 150,
                                                              color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Text('P R O G R A M A R E', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),)
                                            
                                              ],
                                            ),
                                                SizedBox(width: 20,),
                                            Column(
                                              children: [
                                                Container(
                                                      height: 250,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(360),
                                                          color: Color.fromARGB(86, 255, 255, 255)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(15.0),
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(360),
                                                           
                                                            ),
                                                             child: Icon(
                                                               Icons.settings_input_composite_outlined,
                                                              size: 150,
                                                              color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Text('R O B O T I C Ă', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),)
                                            
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 50,),
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
                                         SizedBox(height: 20,),
                                        ClipRRect(
                                          key: section1Key,
                                          borderRadius: BorderRadius.circular(40.0),
                                          child: SizedBox(
                                            width: 900,
                                            height: 700,
                                            child:  WebView(
                                              initialUrl: 'https://pixlr.com/ro/',
                                              javascriptMode: JavascriptMode.unrestricted,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                         /*ClipRRect(
                                           borderRadius: BorderRadius.circular(40.0),
                                          child: SizedBox(
                                            width: 900,
                                            height: 700,
                                            
                                            child:  WebView(
                                              
                                              initialUrl: 'https://www.programiz.com/python-programming/online-compiler/',
                                              javascriptMode: JavascriptMode.unrestricted,
                                            ),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                 
                                  
                                ],
                              ),
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
      LearnViewModel viewModel, int index2, String text, VoidCallback onTap) {
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
