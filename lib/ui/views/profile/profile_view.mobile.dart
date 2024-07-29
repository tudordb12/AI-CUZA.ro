import 'package:aicuzaro/ui/views/postspage/mobile_menu.dart';
import 'package:aicuzaro/ui/views/postspage/wall_post_mobile.dart';
import 'package:aicuzaro/ui/views/profile/wall_ppost.dart';
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
import 'profile_viewmodel.dart';

class ProfileViewMobile extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
     final user = FirebaseAuth.instance.currentUser!;

    final String currentUserEmail =
        user.email!; // Replace with the actual current user email

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
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Text(
                            'AI.CUZA',
                            style: ktsBodyLarge.copyWith(fontWeight: FontWeight.bold),
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
                              //viewModel.navigateToDownloadsView();
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
                         
                        ],
                      ),
                    ),
                                ],
                              ),
                  ],
                ),
              ),
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
                              viewModel.navigateToHome();
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
                color: Color.fromARGB(255, 59, 52, 100),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                                            height: 500,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 77, 77, 146),
                                              borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Urmăririle tale",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: const Color.fromARGB(
                                                              134, 255, 255, 255)),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 350,
                                                      width: 300,
                                                      child: FutureBuilder<
                                                          List<Map<String, dynamic>>>(
                                                        future: fetchFollowingUsers(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Center();
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'));
                                                          } else if (!snapshot
                                                                  .hasData ||
                                                              snapshot
                                                                  .data!.isEmpty) {
                                                            return Center(
                                                                child: Text(
                                                                    'No users found'));
                                                          } else {
                                                            return ListView.builder(
                                                              itemCount: snapshot
                                                                  .data!.length,
                                                              itemBuilder:
                                                                  (context, index) {
                                                                var user = snapshot
                                                                    .data![index];
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(2.0),
                                                                  child: Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets
                                                                                  .all(
                                                                                  8.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                75,
                                                                            width: 75,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors
                                                                                  .white70,
                                                                              borderRadius:
                                                                                  BorderRadius.circular(70),
                                                                              image:
                                                                                  DecorationImage(
                                                                                image:
                                                                                    NetworkImage(user['image']),
                                                                                fit: BoxFit
                                                                                    .cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            Container(
                                                                                child:
                                                                                    Text(
                                                                              user[
                                                                                  'name'],
                                                                              style: TextStyle(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  fontSize: 20),
                                                                            )),
                                                                            SizedBox(
                                                                              height:
                                                                                  10,
                                                                            ),
                                                                            Container(
                                                                                child:
                                                                                    Text(
                                                                              user[
                                                                                  'email'],
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .w100,
                                                                                  color: Color.fromARGB(
                                                                                      113,
                                                                                      255,
                                                                                      255,
                                                                                      255)),
                                                                            ))
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                                                height: 1000,
                                                width: 700,
                                                decoration: BoxDecoration(
                                                  color:
                                                      Color.fromARGB(120, 242, 69, 17),
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(40.0),
                                                    topLeft: Radius.circular(40.0),
                                                    bottomLeft: Radius.circular(40.0),
                                                    bottomRight: Radius.circular(40.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 20,),
                                                          Text(
                                                            "P O S T Ă R I L E  M E L E",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Color.fromARGB(
                                                                    188,
                                                                    255,
                                                                    255,
                                                                    255)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Expanded(
                                                        child: FadeInUp(
                                                            delay: Duration(
                                                                milliseconds: 2000),
                                                            child: StreamBuilder(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection('posts')
                                                                  .where('name',
                                                                      isEqualTo:
                                                                          user.email)
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  AsyncSnapshot<
                                                                          QuerySnapshot>
                                                                      snapshot) {
                                                                if (!snapshot.hasData) {
                                                                  return Center(
                                                                      child:
                                                                          CircularProgressIndicator());
                                                                }
                      
                                                                return ListView.builder(
                                                                  itemCount: snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context, index) {
                                                                    final post =
                                                                        snapshot.data!
                                                                                .docs[
                                                                            index];
                      
                                                                    Color buttonColor;
                                                                    if (index % 5 ==
                                                                        0) {
                                                                      buttonColor =
                                                                          Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  218,
                                                                                  38,
                                                                                  71);
                                                                    } else if (index %
                                                                            5 ==
                                                                        1) {
                                                                      buttonColor =
                                                                          Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  211,
                                                                                  32,
                                                                                  0);
                                                                    } else if (index %
                                                                            5 ==
                                                                        2) {
                                                                      buttonColor =
                                                                          Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  212,
                                                                                  64,
                                                                                  48);
                                                                    } else if (index %
                                                                            5 ==
                                                                        3) {
                                                                      buttonColor =
                                                                          Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  218,
                                                                                  66,
                                                                                  81);
                                                                    } else {
                                                                      buttonColor =
                                                                          Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  201,
                                                                                  52,
                                                                                  38);
                                                                    }
                      
                                                                    return FutureBuilder(
                                                                      future: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'usernames')
                                                                          .doc(post[
                                                                              'name']) // assuming 'name' is the email address
                                                                          .get(),
                                                                      builder: (context,
                                                                          AsyncSnapshot<
                                                                                  DocumentSnapshot>
                                                                              userSnapshot) {
                                                                        if (!userSnapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                              child:
                                                                                  CircularProgressIndicator());
                                                                        }
                      
                                                                        final userDoc =
                                                                            userSnapshot
                                                                                .data!;
                                                                        final userName =
                                                                            userDoc['name'] ??
                                                                                post[
                                                                                    'name'];
                                                                        final profilepic =
                                                                            userDoc['image'] ??
                                                                                post[
                                                                                    'name'];
                                                                        final photo =
                                                                            post[
                                                                                'image'];
                      
                                                                        return FutureBuilder(
                                                                          future: FirebaseFirestore
                                                                              .instance
                                                                              .collection(
                                                                                  'following')
                                                                              .doc(userDoc[
                                                                                  'email'])
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
                                                                                follSnapshot
                                                                                    .data!;
                                                                            List<String>
                                                                                followers2 =
                                                                                List<
                                                                                    String>.from(follDoc[
                                                                                        'followers'] ??
                                                                                    []);
                      
                                                                            return WallMPost(
                                                                              message: post[
                                                                                  'description'],
                                                                              user:
                                                                                  userName,
                                                                              time: post[
                                                                                  'date'],
                                                                              profile:
                                                                                  profilepic,
                                                                              postId:
                                                                                  post.id,
                                                                              likes: List<
                                                                                  String>.from(post[
                                                                                      'Likes'] ??
                                                                                  []),
                                                                              bColor:
                                                                                  buttonColor,
                                                                              email: userDoc[
                                                                                  'email'],
                                                                              followers:
                                                                                  followers2,
                                                                              image:
                                                                                  photo,
                                                                               saves: List<
                                                                              String>.from(
                                                                          post['saved'] ??
                                                                              []),
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
                                              ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                                              height: 1000,
                                              width: 800,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(120, 0, 0, 0),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40.0),
                                                  topLeft: Radius.circular(40.0),
                                                  bottomLeft: Radius.circular(40.0),
                                                  bottomRight: Radius.circular(40.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(30.0),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "IDEI SALVATE",
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color: Color.fromARGB(
                                                                  188,
                                                                  255,
                                                                  255,
                                                                  255)),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Expanded(
                                                      child: FadeInUp(
                                                          delay: Duration(
                                                              milliseconds: 2000),
                                                          child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection('posts')
                                                                .where('saved',
                                                                    arrayContains:
                                                                        user.email)
                                                                .snapshots(),
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                              if (!snapshot.hasData) {
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              }
                    
                                                              return ListView.builder(
                                                                itemCount: snapshot
                                                                    .data!
                                                                    .docs
                                                                    .length,
                                                                itemBuilder:
                                                                    (context, index) {
                                                                  final post =
                                                                      snapshot.data!
                                                                              .docs[
                                                                          index];
                    
                                                                  Color buttonColor;
                                                                  if (index % 5 ==
                                                                      0) {
                                                                    buttonColor =
                                                                        Color
                                                                            .fromARGB(
                                                                                255,
                                                                                218,
                                                                                38,
                                                                                71);
                                                                  } else if (index %
                                                                          5 ==
                                                                      1) {
                                                                    buttonColor =
                                                                        Color
                                                                            .fromARGB(
                                                                                255,
                                                                                211,
                                                                                32,
                                                                                0);
                                                                  } else if (index %
                                                                          5 ==
                                                                      2) {
                                                                    buttonColor =
                                                                        Color
                                                                            .fromARGB(
                                                                                255,
                                                                                212,
                                                                                64,
                                                                                48);
                                                                  } else if (index %
                                                                          5 ==
                                                                      3) {
                                                                    buttonColor =
                                                                        Color
                                                                            .fromARGB(
                                                                                255,
                                                                                218,
                                                                                66,
                                                                                81);
                                                                  } else {
                                                                    buttonColor =
                                                                        Color
                                                                            .fromARGB(
                                                                                255,
                                                                                201,
                                                                                52,
                                                                                38);
                                                                  }
                    
                                                                  return FutureBuilder(
                                                                    future: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'usernames')
                                                                        .doc(post[
                                                                            'name']) // assuming 'name' is the email address
                                                                        .get(),
                                                                    builder: (context,
                                                                        AsyncSnapshot<
                                                                                DocumentSnapshot>
                                                                            userSnapshot) {
                                                                      if (!userSnapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                            child:
                                                                                CircularProgressIndicator());
                                                                      }
                    
                                                                      final userDoc =
                                                                          userSnapshot
                                                                              .data!;
                                                                      final userName =
                                                                          userDoc['name'] ??
                                                                              post[
                                                                                  'name'];
                                                                      final profilepic =
                                                                          userDoc['image'] ??
                                                                              post[
                                                                                  'name'];
                                                                      final photo =
                                                                          post[
                                                                              'image'];
                    
                                                                      return FutureBuilder(
                                                                        future: FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'following')
                                                                            .doc(userDoc[
                                                                                'email'])
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
                                                                              follSnapshot
                                                                                  .data!;
                                                                          List<String>
                                                                              followers2 =
                                                                              List<
                                                                                  String>.from(follDoc[
                                                                                      'followers'] ??
                                                                                  []);
                    
                                                                          return WallMPost(
                                                                            message: post[
                                                                                'description'],
                                                                            user:
                                                                                userName,
                                                                            time: post[
                                                                                'date'],
                                                                            profile:
                                                                                profilepic,
                                                                            postId:
                                                                                post.id,
                                                                            likes: List<
                                                                                String>.from(post[
                                                                                    'Likes'] ??
                                                                                []),
                                                                            bColor:
                                                                                buttonColor,
                                                                            email: userDoc[
                                                                                'email'],
                                                                            followers:
                                                                                followers2,
                                                                            image:
                                                                                photo,
                                                                            saves: List<
                                                                                String>.from(post[
                                                                                    'saved'] ??
                                                                                []),
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
                                            ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
