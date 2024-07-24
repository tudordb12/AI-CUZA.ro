import 'package:aicuzaro/ui/views/profile/profile_viewmodel.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileViewMobile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(120, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "IDEI SALVATE",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(188, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: FadeInUp(
                          delay: Duration(milliseconds: 2000),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .where('saved', arrayContains: user.email)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final post = snapshot.data!.docs[index];

                                  Color buttonColor;
                                  switch (index % 5) {
                                    case 0:
                                      buttonColor =
                                          Color.fromARGB(255, 218, 38, 71);
                                      break;
                                    case 1:
                                      buttonColor =
                                          Color.fromARGB(255, 211, 32, 0);
                                      break;
                                    case 2:
                                      buttonColor =
                                          Color.fromARGB(255, 212, 64, 48);
                                      break;
                                    case 3:
                                      buttonColor =
                                          Color.fromARGB(255, 218, 66, 81);
                                      break;
                                    default:
                                      buttonColor =
                                          Color.fromARGB(255, 201, 52, 38);
                                  }

                                  return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('usernames')
                                        .doc(post['name'])
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            userSnapshot) {
                                      if (!userSnapshot.hasData) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      final userDoc = userSnapshot.data!;
                                      final userName =
                                          userDoc['name'] ?? post['name'];
                                      final profilepic =
                                          userDoc['image'] ?? post['name'];
                                      final photo = post['image'];

                                      return FutureBuilder(
                                        future: FirebaseFirestore.instance
                                            .collection('following')
                                            .doc(userDoc['email'])
                                            .get(),
                                        builder: (context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                follSnapshot) {
                                          if (!follSnapshot.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          final follDoc = follSnapshot.data!;
                                          List<String> followers2 =
                                              List<String>.from(
                                                  follDoc['followers'] ?? []);

                                          return WallPost(
                                            message: post['description'],
                                            user: userName,
                                            time: post['date'],
                                            profile: profilepic,
                                            postId: post.id,
                                            likes: List<String>.from(
                                                post['Likes'] ?? []),
                                            bColor: buttonColor,
                                            email: userDoc['email'],
                                            followers: followers2,
                                            image: photo,
                                            saves: List<String>.from(
                                                post['saved'] ?? []),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
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

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  final String time;
  final String profile;
  final String postId;
  final List<String> likes;
  final Color bColor;
  final String email;
  final List<String> followers;
  final String image;
  final List<String> saves;

  WallPost({
    required this.message,
    required this.user,
    required this.time,
    required this.profile,
    required this.postId,
    required this.likes,
    required this.bColor,
    required this.email,
    required this.followers,
    required this.image,
    required this.saves,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profile),
                radius: 20,
              ),
              SizedBox(width: 10),
              Text(
                user,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          if (image != null && image.isNotEmpty) Image.network(image),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.thumb_up, color: bColor),
              SizedBox(width: 5),
              Text('${likes.length} likes'),
              Spacer(),
              Icon(Icons.save, color: bColor),
              SizedBox(width: 5),
              Text('${saves.length} saves'),
            ],
          ),
        ],
      ),
    );
  }
}
