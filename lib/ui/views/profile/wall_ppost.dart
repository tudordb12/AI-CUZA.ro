import 'package:aicuzaro/ui/views/postspage/comments.dart';
import 'package:aicuzaro/ui/views/postspage/comments_button.dart';
import 'package:aicuzaro/ui/views/postspage/follow_button.dart';
import 'package:aicuzaro/ui/views/postspage/like_button.dart';
import 'package:aicuzaro/ui/views/postspage/save_button.dart';
import 'package:aicuzaro/ui/views/profile/post_del_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class WallPPost extends StatefulWidget {
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
  //final List<String> saves;

  const WallPPost({
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
    //required this.saves,
  });

  @override
  State<WallPPost> createState() => _WallPPostState();
}

class _WallPPostState extends State<WallPPost> {
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
    //isSaved = widget.saves.contains(currentUser.email);
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

  void deletePost() async {
    final commentDocs = await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("comments")
        .get();

    for (var doc in commentDocs.docs) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postId)
          .collection("comments")
          .doc(doc.id)
          .delete();
    }

    // then delete the post
    FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .delete()
        .then((value) => print("post deleted"))
        .catchError((error) => print("failed to delete post: $error"));
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
      followers = widget.followers.length > 1 ? 'Urmăritori' : 'Urmăritor';
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
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.bColor,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: EdgeInsets.all(25),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360),
                                    color: Color.fromARGB(178, 255, 255, 255),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        image: DecorationImage(
                                          image: NetworkImage(widget.profile),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.user,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget.followers.length.toString(),
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  171, 255, 255, 255),
                                              fontWeight: FontWeight.w100,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(width: 10),
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
                                if (widget.email == currentUser.email)
                                  postDeleteBtn(onTap: deletePost)
                              ],
                            ),
                            SizedBox(height: 10),
                            if (widget.image.isNotEmpty)
                              Container(
                                height: isMobile ? 250 : 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            SizedBox(height: 10),
                            Text(
                              widget.message,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              widget.time,
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(167, 255, 255, 255)),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(360),
                                        ),
                                        child: Align(
                                          child: Row(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 20),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        8.0, 0, 8.0, 0),
                                                    child: Text(
                                                      widget.likes.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  LikeButton(
                                                    isLiked: isLiked,
                                                    onTap: toggleLike,
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      CommentButton(
                                        onPressed: () {
                                          print(
                                              "Comment text: ${commentText.text}");
                                          addComment(commentText.text);
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      /* SaveButton(
                                        isSaved: isSaved,
                                        onTap: toggleSave,
                                      )*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 60, 60, 60)),
                                    controller: commentText,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: 'Comentează',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 60, 60, 60),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 229, 222, 235),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final commentData = comments[index].data()
                                    as Map<String, dynamic>;
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('usernames')
                                      .doc(commentData['CommentedBy'])
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      //return Center(child: CircularProgressIndicator());
                                    }
                                    if (!snapshot.hasData) {
                                      return Text('');
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
                                      commentId:
                                          comments[index].id, // Pass comment ID
                                      onDelete: () => deleteComment(
                                          comments[index].id), // Handle delete
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
