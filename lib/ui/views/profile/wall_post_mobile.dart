import 'package:aicuzaro/ui/views/postspage/comments.dart';
import 'package:aicuzaro/ui/views/postspage/comments_button.dart';
import 'package:aicuzaro/ui/views/postspage/follow_button.dart';
import 'package:aicuzaro/ui/views/postspage/like_button.dart';
import 'package:aicuzaro/ui/views/postspage/like_button_mobile.dart';
import 'package:aicuzaro/ui/views/postspage/save_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class WallMPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String profile;
  final String postId;
  final Color bColor;
  final List<String> likes;
  final String email;
  final List<String> followers;
  final String image;
  final List<String> saves;

  const WallMPost({
    super.key,
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
  State<WallMPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallMPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool isSaved = false;
  bool isFollowed = false;
  String followers = '';
  final TextEditingController commentText = TextEditingController();
  List<DocumentSnapshot> comments = [];

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    isSaved = widget.saves.contains(currentUser.email);
    checkIfFollowed();
    checkFollowersLabel();
    fetchComments();
  }

  void fetchComments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .get();
    setState(() {
      comments = querySnapshot.docs;
    });
  }

  void deleteComment(String commentId) {
    DocumentReference comRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(commentId);

    comRef.delete().then((_) {
      print("Comment deleted successfully!");
      fetchComments(); // Refresh comments after deletion
    }).catchError((error) {
      print("Failed to delete comment: $error");
    });
  }

  void addComment(String comment) async {
    if (commentText.text != '') {
      try {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('MMM d yyyy').format(now);
        DocumentReference postRef =
            FirebaseFirestore.instance.collection('posts').doc(widget.postId);

        await FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.postId)
            .collection("comments")
            .add({
          "CommentText": comment,
          "CommentedBy": currentUser.email!,
          "CommentTime": formattedDate,
        });
        print("Comment added successfully");
        print(widget.postId);
        commentText.clear();
        fetchComments();
      } catch (e) {
        print("Failed to add comment: $e");
      }
    }
  }

  void checkIfFollowed() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('following')
        .doc(currentUser.email)
        .get();
    if (doc.exists) {
      List<dynamic> following = doc['following'] ?? [];
      setState(() {
        isFollowed = following.contains(widget.email);
      });
    }
  }

  void checkFollowersLabel() {
    setState(() {
      followers = widget.followers.length > 1 ? 'Followers' : 'Follower';
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email!])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email!])
      });
    }
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
    DocumentReference saveRef = FirebaseFirestore.instance
        .collection('following')
        .doc(currentUser.email);
    DocumentReference savRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);
    if (isSaved) {
      saveRef.set({
        'saved': FieldValue.arrayUnion([widget.postId])
      }, SetOptions(merge: true));
      savRef.set({
        'saved': FieldValue.arrayUnion([currentUser.email])
      }, SetOptions(merge: true));
    } else {
      saveRef.update({
        'saved': FieldValue.arrayRemove([widget.postId])
      });
      savRef.update({
        'saved': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void toggleFollow() async {
    DocumentReference folRef = FirebaseFirestore.instance
        .collection('following')
        .doc(currentUser.email);
    DocumentReference follRef =
        FirebaseFirestore.instance.collection('following').doc(widget.email);

    setState(() {
      isFollowed = !isFollowed;
    });

    if (isFollowed) {
      folRef.set({
        'following': FieldValue.arrayUnion([widget.email])
      }, SetOptions(merge: true));
      follRef.set({
        'followers': FieldValue.arrayUnion([currentUser.email])
      }, SetOptions(merge: true));
    } else {
      folRef.update({
        'following': FieldValue.arrayRemove([widget.email])
      });
      follRef.update({
        'followers': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.bColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: const Color.fromARGB(178, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        image: DecorationImage(
                          image: NetworkImage(widget.profile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.followers.length.toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(171, 255, 255, 255),
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(followers),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.email != currentUser.email)
                  FollowButton(
                    isFollowed: isFollowed,
                    onTap: toggleFollow,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            if (widget.image.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              widget.message,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.time,
              style: const TextStyle(color: Color.fromARGB(167, 255, 255, 255)),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.likes.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          LikeButtonMobile(
                            isLiked: isLiked,
                            onTap: toggleLike,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      CommentButton(
                        onPressed: () {
                          print("Comment text: ${commentText.text}");
                          addComment(commentText.text);
                        },
                      ),
                      const SizedBox(width: 10),
                      SaveButton(
                        isSaved: isSaved,
                        onTap: toggleSave,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Color.fromARGB(255, 60, 60, 60)),
              controller: commentText,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Comentează',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 60, 60, 60),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 229, 222, 235),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final commentData =
                    comments[index].data() as Map<String, dynamic>;
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('usernames')
                      .doc(commentData['CommentedBy'])
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return const Text('');
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    var fieldValue = snapshot.data!['name'];
                    return Comment(
                      text: commentData['CommentText'],
                      time: commentData['CommentTime'],
                      user: '$fieldValue',
                      email: commentData['CommentedBy'],
                      postId: widget.postId,
                      commentId: comments[index].id, // Pass comment ID
                      onDelete: () =>
                          deleteComment(comments[index].id), // Handle delete
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
