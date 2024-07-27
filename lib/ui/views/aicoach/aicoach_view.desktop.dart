import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
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
import 'aicoach_viewmodel.dart';

class AicoachViewDesktop extends ViewModelWidget<AicoachViewModel> {
  const AicoachViewDesktop({super.key});

  @override
  Widget build(BuildContext context, AicoachViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;
    final ChatUser _currentUser =
        ChatUser(id: '1', firstName: 'Robo', lastName: 'User');
    final ChatUser _gptCurrentUser =
        ChatUser(id: '2', firstName: 'Robo', lastName: 'Coach');

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: double.infinity - 100,
            height: 950,
            color: Color.fromARGB(255, 21, 127, 165),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 850,
                            width: 300,
                            color: Color.fromARGB(255, 59, 56, 75),
                            child: Align(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(360),
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
                                    /*Container(
                                      height: 200,
                                      width: 200,
                                     /* child: Icon(
                                        Icons.person,
                                        color: Colors.white70,
                                        size: 100.0,
                                      ),*/
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(360),
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ),*/
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

                                        var fieldValue = snapshot.data!['name'];

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
                                        _buildHoverContainer(
                                            viewModel, 1, '     A C A S Ă     ',
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
                                          Icons.batch_prediction_rounded,
                                          color: Colors.white70,
                                          size: 25.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        _buildHoverContainer(
                                            viewModel, 2, 'P O S T Ă R I', () {
                                          // viewModel.navigateToPostsView();
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
                                            viewModel, 3, 'Î N T R E B Ă R I',
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
                                          Icons.alternate_email_sharp,
                                          color: Colors.white70,
                                          size: 25.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        _buildHoverContainer(
                                            viewModel, 4, 'A I  C O A C H', () {
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
                                          Icons.person_pin_rounded,
                                          color: Colors.white70,
                                          size: 25.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        _buildHoverContainer(viewModel, 5,
                                            'P R O F I L U L   M E U', () {
                                          // Action for TEST1 container
                                        }),
                                        Spacer(
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                    Spacer(
                                      flex: 2,
                                    ),
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
                          Container(
                            width: 1150,
                            height: 850,
                            color: Color.fromARGB(255, 21, 127, 165),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  height: 850,
                                  width: 850,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GradientText(
                                            'ROBO COACH',
                                            style: ktsTitleText2,
                                            colors: const [
                                              Color.fromARGB(
                                                  255, 232, 231, 230),
                                              Color.fromARGB(255, 199, 198, 197)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              color: Color.fromARGB(207, 24, 24, 24),
                                            ),
                                            height: 500,
                                            width: 1000,
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(60),
                                                            topRight:
                                                                Radius.circular(
                                                                    60)),
                                                    color: const Color.fromARGB(
                                                        255, 60, 81, 92),
                                                  ),
                                                  height: 60,
                                                  width: 1000,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        60.0, 0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "@robotics_coach_",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                     height: 440,
                                                    width: 1000,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: DashChat(
                                                        currentUser:
                                                            _currentUser,
                                                        messageOptions:
                                                            const MessageOptions(
                                                          currentUserContainerColor:
                                                              Color.fromARGB(192, 202, 63, 3),
                                                          containerColor:
                                                              Color.fromRGBO(216, 3, 46, 0.75),
                                                          textColor:
                                                              Colors.white,
                                                          maxWidth: 400,
                                                        ),
                                                        onSend:
                                                            (ChatMessage m) {
                                                          viewModel
                                                              .getChatResponse(
                                                                  m);
                                                        },
                                                        messages:
                                                            viewModel.messages,
                                                        inputOptions:
                                                            InputOptions(
                                                          inputDecoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Întreabă-mă orice',
                                                            hintStyle:
                                                                TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    91,
                                                                    105,
                                                                    112),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            8),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          )
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

  Widget _buildHoverContainer(
      AicoachViewModel viewModel, int index, String text, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => viewModel.setHovering(index, true),
      onExit: (_) => viewModel.setHovering(index, false),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: viewModel.isHovering(index)
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
