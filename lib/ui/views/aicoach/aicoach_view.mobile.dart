import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'aicoach_viewmodel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
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

class AicoachViewMobile extends ViewModelWidget<AicoachViewModel> {
  const AicoachViewMobile({super.key});

  @override
  Widget build(BuildContext context, AicoachViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;
    final ChatUser _currentUser =
        ChatUser(id: '1', firstName: 'Robo', lastName: 'User');
    final ChatUser _gptCurrentUser =
        ChatUser(id: '2', firstName: 'Robo', lastName: 'Coach');

    return Scaffold(
      backgroundColor: Color.fromARGB(222, 40, 39, 39),
      
      body: 
        SingleChildScrollView(
          child: Column(
                children: [
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Row(
                                   children: [
                                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                          ],
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
                             
                            ],
                          ),
                        ),
                      ],
                                     ),]),
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
                      color: const Color.fromARGB( 255, 60, 81, 92),
                      height: 70,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                                                              "@robotics_coach_",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                      ),),
                  
                  Container(
                    height: 800,
                    width: double.infinity,
                    child: DashChat(
                      currentUser: _currentUser,
                      messageOptions: const MessageOptions(
                        currentUserContainerColor:
                            Color.fromARGB(192, 202, 63, 3),
                        containerColor: Color.fromRGBO(216, 3, 46, 0.75),
                        textColor: Colors.white,
                        maxWidth: 400,
                      ),
                      onSend: (ChatMessage m) {
                        viewModel.getChatResponse(m);
                      },
                      messages: viewModel.messages,
                      inputOptions: InputOptions(
                        inputDecoration: InputDecoration(
                          hintText: 'Întreabă-mă orice',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 91, 105, 112),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ),
          
        
              
    );
  }
}
