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
import 'postspage_viewmodel.dart';
import 'wall_post.dart';

class PostspageViewDesktop extends ViewModelWidget<PostspageViewModel> {
  const PostspageViewDesktop({super.key});

  @override
  Widget build(BuildContext context, PostspageViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: double.infinity - 100,
            height: 950,
            // color: Color.fromARGB(255, 89, 6, 205),
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
                                   viewModel.navigateToHomeView();
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
                                   viewModel.navigateToDownloadsView();
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
                                   viewModel.navigateToAuthView();
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FadeInLeftBig(
                            child: Container(
                              height: 850,
                              width: 300,
                              //color: Color.fromARGB(255, 59, 56, 75),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 59, 56, 75),
                                  borderRadius: BorderRadius.only()),
                              child: Align(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Spacer(
                                        flex: 2,
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection(
                                                'usernames') // Replace with your collection name
                                            .doc(user
                                                .email!) // Replace with your document ID
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
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        fieldValue1), // Replace with your image URL
                                                    fit: BoxFit
                                                        .cover, // Choose the fit as per your need
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Salut, ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w100),
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection(
                                                'usernames') // Replace with your collection name
                                            .doc(user
                                                .email!) // Replace with your document ID
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
                                      /* Text(
                                        user.email!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w100),
                                      ),*/
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color: Color.fromARGB(255, 171, 167,
                                            200), //color of divider
                                        height: 5, //height spacing of divider
                                        thickness: 1,
                                      )),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Icon(
                                            Icons.home,
                                            color: Colors.white70,
                                            size: 25.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildHoverContainer(viewModel, 1,
                                              '     A C A S Ă     ', () {
                                            viewModel.navigateToHome();
                                          }),
                                          Spacer(
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Icon(
                                            Icons.batch_prediction_rounded,
                                            color: Colors.white70,
                                            size: 25.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildHoverContainer(
                                              viewModel, 2, 'P O S T Ă R I',
                                              () {
                                            // Action for TEST1 container
                                          }),
                                          Spacer(
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Icon(
                                            Icons.question_mark,
                                            color: Colors.white70,
                                            size: 25.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildHoverContainer(
                                              viewModel, 3, 'D E S C O P E R Ă',
                                              () {
                                            viewModel.navigateToLearnView();
                                          }),
                                          Spacer(
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Icon(
                                            Icons.alternate_email_sharp,
                                            color: Colors.white70,
                                            size: 25.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildHoverContainer(
                                              viewModel, 4, 'A I  C O A C H',
                                              () {
                                            viewModel.navigateToAICOACH();
                                          }),
                                          Spacer(
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Icon(
                                            Icons.person_pin_rounded,
                                            color: Colors.white70,
                                            size: 25.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildHoverContainer(viewModel, 5,
                                              'P R O F I L U L   M E U', () {
                                            viewModel.navigateToProfileView();
                                          }),
                                          Spacer(
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      /* Spacer(
                                        flex: 2,
                                      ),*/
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Icon(
                                            Icons.exit_to_app_rounded,
                                            color: Colors.white70,
                                            size: 25.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildHoverContainer(
                                              viewModel, 6, 'I E Ș I R E', () {
                                            viewModel.signUserOut();
                                          }),
                                          Spacer(
                                            flex: 2,
                                          )
                                        ],
                                      ),
                                      const Spacer(
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeInLeftBig(
                            duration: Duration(milliseconds: 1500),
                            child: Container(
                              width: 750,
                              height: 850,
                              color: /*Color.fromARGB(255, 232, 39, 0),*/
                                  Color.fromARGB(184, 159, 24, 0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        color:
                                            Color.fromARGB(255, 220, 177, 171),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            // textfield
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 0, 0.0, 0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10.0, 0, 10.0, 0),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: IntrinsicHeight(
                                                          child: Center(
                                                            child: TextField(
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          60,
                                                                          60,
                                                                          60)),
                                                              controller: viewModel
                                                                  .textController,
                                                              maxLines: null,
                                                              decoration:
                                                                  InputDecoration
                                                                      .collapsed(
                                                                hintText:
                                                                    'Ce idei noi ai?',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          60,
                                                                          60,
                                                                          60),
                                                                ),
                                                                filled: true,
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        229,
                                                                        222,
                                                                        235),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    width: 250,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 229, 222, 235),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  ),
                                                ),
                                              ), // MyTextField
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FadeIn(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Color.fromARGB(
                                                      255, 234, 229, 229),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    // Call postOnline asynchronously
                                                    if (viewModel.textController
                                                        .text.isNotEmpty) {
                                                      viewModel.postOnline();
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.arrow_circle_up),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Color.fromARGB(
                                                    255, 234, 229, 229),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  // Call postOnline asynchronously
                                                  if (viewModel.textController
                                                      .text.isNotEmpty) {
                                                    viewModel.postAttach();
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.add_a_photo),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ), // Row
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: FadeInUp(
                                        delay: Duration(milliseconds: 2000),
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('posts')
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
                                                  buttonColor = Color.fromARGB(255, 212, 37, 69);
                                                } else if (index % 5 == 1) {
                                                  buttonColor = Color.fromARGB(
                                                      255, 221, 77, 106);
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

                                                        return WallPost(
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
                          Container(
                            height: 850,
                            width: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GradientText(
                                    'ROBO\nSTREAM',
                                    style: ktsTitleText,
                                    colors: const [
                                      Color.fromARGB(255, 232, 231, 230),
                                      Color.fromARGB(255, 199, 198, 197)
                                    ],
                                  ),
                                ),
                                Align(
                                    child: Text(
                                  " O altfel de rețea socială ",
                                  style: TextStyle(),
                                )),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('lib/assets/appr.png'),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('lib/assets/social.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
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

  Widget _buildHoverContainer(PostspageViewModel viewModel, int index2,
      String text, VoidCallback onTap) {
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
