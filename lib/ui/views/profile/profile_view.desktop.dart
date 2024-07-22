import 'package:aicuzaro/ui/views/postspage/wall_post.dart';
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
import 'profile_viewmodel.dart';

class ProfileViewDesktop extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewDesktop({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;

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
                Color.fromARGB(255, 89, 6, 205),
                Color.fromARGB(255, 92, 6, 205),
                Color.fromARGB(255, 69, 6, 205),
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
                                        return Text(
                                            'Error: ${snapshot.error}');
                                      }

                                      var fieldValue1 =
                                          snapshot.data!['image'];

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
                                                image: NetworkImage(
                                                    fieldValue1),
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
                                        return Text(
                                            'Error: ${snapshot.error}');
                                      }

                                      var fieldValue =
                                          snapshot.data!['name'];

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
                                      _buildHoverContainer(
                                          viewModel, 5, 'P R O F I L U L   M E U',
                                          () {
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
                          child: Container(
                            height: 1500,
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
                                      color: Color.fromARGB(255, 217, 63, 83),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                     /* image: DecorationImage(
                                        image: NetworkImage(
                                            'https://your-banner-photo-url.com'),
                                        fit: BoxFit.cover,
                                      ),*/
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 220, // Adjust the position as needed
                                  left: 20, // Adjust the position as needed
                                  child: StreamBuilder(
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
                                        return Text(
                                            'Error: ${snapshot.error}');
                                      }

                                      var fieldValue1 =
                                          snapshot.data!['image'];

                                      return Container(
                                        height: 250,
                                        width: 250,
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
                                                image: NetworkImage(
                                                    fieldValue1),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 380, // Adjust the position as needed
                                  left: 290, // Adjust the position as needed
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                        return Text(
                                            'Error: ${snapshot.error}');
                                      }

                                      var fieldValue =
                                          snapshot.data!['name'];

                                      return Text(
                                        '$fieldValue',
                                        style: TextStyle(fontSize: 30),
                                      );
                                    },
                                  ),
                                      Text(
                                        'Short Bio or Description',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(133, 255, 255, 255),
                                        ),
                                      ),

                                      
                                    ],
                                  ),
                                ),
                                Positioned(
                                   top: 500, // Adjust the position as needed
                                  left: 0,
                                  child: Container(
                                    height: 950,
                                    width: 550,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 77, 77, 146),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(360.0),
                                  bottomRight: Radius.circular(360.0),
                                  
                                  
                                ),
                              ),
                              // Add your child widget here
                              //child: /* Your child widget */,
                            )
                                
                                ),
                                Positioned(
                                   top: 500, // Adjust the position as needed
                                  left: 0,
                                  child: Container(
                                    height: 950,
                                    width: 550,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 77, 77, 146),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(360.0),
                                  bottomRight: Radius.circular(360.0),
                                  
                                  
                                ),
                              ),
                              // Add your child widget here
                              //child: /* Your child widget */,
                            )
                                
                                ),
                                Positioned(
                                  top: 200,
                                  left: 500,
                                  child: Container(height: 650, width: 700, decoration: BoxDecoration(
                                    color: Color.fromARGB(120, 242, 69, 17),
                                     borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                 topLeft: Radius.circular(40.0),
                                  
                                  
                                ),
                                  ) ,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                      child: FadeInUp(
                                          delay: Duration(milliseconds: 2000),
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('posts')
                                                .where('name', isEqualTo: user.email)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                               
                                              return ListView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  final post =
                                                      snapshot.data!.docs[index];
                                  
                                                  Color buttonColor;
                                                  if (index % 5 == 0) {
                                                    buttonColor = Color.fromARGB(255, 218, 38, 71);
                                                  } else if (index % 5 == 1) {
                                                    buttonColor = Color.fromARGB(255, 211, 32, 0);
                                                  } else if (index % 5 == 2) {
                                                    buttonColor = Color.fromARGB(
                                                        255, 212, 64, 48);
                                                  } else if (index % 5 == 3) {
                                                    buttonColor = Color.fromARGB(
                                                        255, 218, 66, 81);
                                                  } else {
                                                    buttonColor = Color.fromARGB(
                                                        255, 201, 52, 38);
                                                  }
                                  
                                                  return FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection('usernames')
                                                        .doc(post[
                                                            'name']) // assuming 'name' is the email address
                                                        .get(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                DocumentSnapshot>
                                                            userSnapshot) {
                                                      if (!userSnapshot.hasData) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }
                                  
                                                      final userDoc =
                                                          userSnapshot.data!;
                                                      final userName =
                                                          userDoc['name'] ??
                                                              post['name'];
                                                      final profilepic =
                                                          userDoc['image'] ??
                                                              post['name'];
                                                      final photo = post['image'];
                                  
                                                      return FutureBuilder(
                                                        future: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'following')
                                                            .doc(userDoc['email'])
                                                            .get(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    DocumentSnapshot>
                                                                follSnapshot) {
                                                          if (!follSnapshot
                                                              .hasData) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                  
                                                          final follDoc =
                                                              follSnapshot.data!;
                                                          List<String>
                                                              followers2 =
                                                              List<String>.from(
                                                                  follDoc['followers'] ??
                                                                      []);
                                  
                                                          
                                                          return WallPPost(
                                                            message: post[
                                                                'description'],
                                                            user: userName,
                                                            time: post['date'],
                                                            profile: profilepic,
                                                            postId: post.id,
                                                            likes: List<
                                                                    String>.from(
                                                                post['Likes'] ??
                                                                    []),
                                                            bColor: buttonColor,
                                                            email:
                                                                userDoc['email'],
                                                            followers: followers2,
                                                            image: photo,
                                                           /* saves: List<
                                                                    String>.from(
                                                                post['saved'] ??
                                                                    []),*/
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          )),
                                    ),
                                      ],
                                      ),
                                  ),
                                  ))
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
      ProfileViewModel viewModel, int index2, String text, VoidCallback onTap) {
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
