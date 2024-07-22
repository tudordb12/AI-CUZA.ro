import 'package:aicuzaro/ui/views/postspage/wall_post_mobile.dart';
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
        title: const Text(
          'AI.CUZA',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Acasă':
                  // Handle navigation to home
                  break;
                case 'Creează-ți propriul CUZA':
                  // Handle navigation to create CUZA
                  break;
                case 'Descărcări':
                  // Handle navigation to downloads
                  break;
                case 'Contul Meu':
                  // Handle navigation to my account
                  break;
                case 'Logout':
                  // Handle user logout
                  break;
              }
            },
            itemBuilder: (context) => const [
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 60, 60, 60)),
                        controller: viewModel.textController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Ce idei noi ai?',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 60, 60, 60)),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 229, 222, 235),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.arrow_circle_up),
                      onPressed: () {
                        if (viewModel.textController.text.isNotEmpty) {
                          viewModel.postOnline();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        if (viewModel.textController.text.isNotEmpty) {
                          viewModel.postAttach();
                        }
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      Color buttonColor;
                      switch (index % 5) {
                        case 0:
                          buttonColor = const Color.fromARGB(255, 212, 37, 69);
                          break;
                        case 1:
                          buttonColor = const Color.fromARGB(255, 210, 50, 82);
                          break;
                        case 2:
                          buttonColor = const Color.fromARGB(255, 212, 64, 48);
                          break;
                        case 3:
                          buttonColor = const Color.fromARGB(255, 193, 42, 90);
                          break;
                        default:
                          buttonColor = const Color.fromARGB(255, 201, 52, 38);
                          break;
                      }

                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('usernames')
                            .doc(post['name'])
                            .get(),
                        builder: (context, userSnapshot) {
                          if (!userSnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final userDoc = userSnapshot.data!;
                          final userName = userDoc['name'] ?? post['name'];
                          final profilepic = userDoc['image'] ?? post['name'];
                          final photo = post['image'];

                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('following')
                                .doc(userDoc['email'])
                                .get(),
                            builder: (context, follSnapshot) {
                              if (!follSnapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              final follDoc = follSnapshot.data!;
                              List<String> followers2 =
                                  List<String>.from(follDoc['followers'] ?? []);

                              return WallMPost(
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
                                saves: List<String>.from(post['saved'] ?? []),
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
