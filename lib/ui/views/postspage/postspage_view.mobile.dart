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
import 'postspage_viewmodel.dart';
import 'wall_post.dart';
import 'postspage_viewmodel.dart';

class PostspageViewMobile extends ViewModelWidget<PostspageViewModel> {
  const PostspageViewMobile({super.key});

  @override
  Widget build(BuildContext context, PostspageViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        title: Text(
          'AI.CUZA',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Acasă':
                  // viewModel.navigateToHomeView();
                  break;
                case 'Creează-ți propriul CUZA':
                  // viewModel.navigateToInfoView();
                  break;
                case 'Descărcări':
                  // viewModel.navigateToDownloadsView();
                  break;
                case 'Contul Meu':
                  // viewModel.navigateToAuthView();
                  break;
                case 'Logout':
                  // viewModel.signUserOut();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Acasă',
                child: Text('Acasă'),
              ),
              PopupMenuItem(
                value: 'Creează-ți propriul CUZA',
                child: Text('Creează-ți propriul CUZA'),
              ),
              PopupMenuItem(
                value: 'Descărcări',
                child: Text('Descărcări'),
              ),
              PopupMenuItem(
                value: 'Contul Meu',
                child: Text('Contul Meu'),
              ),
              PopupMenuItem(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: kcBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Color.fromARGB(255, 89, 6, 205),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('usernames')
                          .doc(user.email!)
                          .snapshots(),
                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (!snapshot.hasData) {
                          return Text('');
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
                    SizedBox(height: 10),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('usernames')
                          .doc(user.email!)
                          .snapshots(),
                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (!snapshot.hasData) {
                          return Text('');
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        var fieldValue = snapshot.data!['name'];

                        return Text(
                          'Salut, $fieldValue',
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Color.fromARGB(255, 60, 60, 60)),
                        controller: viewModel.textController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Ce idei noi ai?',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 60, 60, 60),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 229, 222, 235),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.arrow_circle_up),
                      onPressed: () {
                        if (viewModel.textController.text.isNotEmpty) {
                          viewModel.postOnline();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () {
                        if (viewModel.textController.text.isNotEmpty) {
                          viewModel.postAttach();
                        }
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      Color buttonColor;
                      if (index % 5 == 0) {
                        buttonColor = Color.fromARGB(255, 236, 86, 48);
                      } else if (index % 5 == 1) {
                        buttonColor = Color.fromARGB(255, 193, 1, 49);
                      } else if (index % 5 == 2) {
                        buttonColor = Color.fromARGB(255, 210, 24, 3);
                      } else if (index % 5 == 3) {
                        buttonColor = Color.fromARGB(255, 214, 4, 70);
                      } else {
                        buttonColor = Color.fromARGB(255, 234, 51, 0);
                      }

                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('usernames')
                            .doc(post['name'])
                            .get(),
                        builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                          if (!userSnapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          final userDoc = userSnapshot.data!;
                          final userName = userDoc['name'] ?? post['name'];
                          final profilepic = userDoc['image'] ?? post['name'];
                          final photo = post['image'];

                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('following')
                                .doc(userDoc['email'])
                                .get(),
                            builder: (context, AsyncSnapshot<DocumentSnapshot> follSnapshot) {
                              if (!follSnapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              final follDoc = follSnapshot.data!;
                              List<String> followers2 = List<String>.from(follDoc['followers'] ?? []);

                              return WallPost(
                                message: post['description'],
                                user: userName,
                                time: post['date'],
                                profile: profilepic,
                                postId: post.id,
                                likes: List<String>.from(post['Likes'] ?? []),
                                bColor: buttonColor,
                                email: userDoc['email'],
                                followers: followers2,
                                image: photo,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}