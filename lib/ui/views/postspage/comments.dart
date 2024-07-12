import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aicuzaro/ui/views/postspage/comment_del_btn.dart';

class Comment extends StatefulWidget {
  final String text;
  final String user;
  final String time;
  final String email;
  final String postId;
  final String commentId;
  final VoidCallback onDelete;

  Comment({
    required this.text,
    required this.user,
    required this.time,
    required this.email,
    required this.postId,
    required this.commentId,
    required this.onDelete,
  });

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  void deleteComment() async {
    DocumentReference comRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(widget.commentId);

    try {
      await comRef.delete();
      widget.onDelete(); // Call the onDelete callback
    } catch (error) {
      print("Failed to delete comment: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(61, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                size: 30,
                Icons.comment_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.user,
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Color.fromARGB(148, 255, 255, 255),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Color.fromARGB(148, 255, 255, 255),
                          ),
                        ),
                        Spacer(flex: 1),
                        if (widget.email == currentUser.email)
                          commentDeleteBtn(onTap: deleteComment)
                      ],
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
