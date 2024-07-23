import 'package:aicuzaro/ui/views/postspage/wall_post.dart';
import 'package:aicuzaro/ui/views/profile/wall_ppost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/ui/common/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_constants.dart';
import 'package:aicuzaro/ui/common/ui_helpers.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'profile_viewmodel.dart';

class ProfileViewDesktop extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewDesktop({super.key});



  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final user = FirebaseAuth.instance.currentUser!;

    final String currentUserEmail = user.email!; // Replace with the actual current user email

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
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: double.infinity - 100,
            height: 950,
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
                  child: Row(
                    children: [
                      FadeInLeftBig(
                        child: Container(
                          height: 950,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 59, 56, 75),
                          ),
                          child: Align(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(flex: 2),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('usernames')
                                        .doc(user.email!)
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
                                                    fieldValue1),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Salut, ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('usernames')
                                        .doc(user.email!)
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
                                  Expanded(
                                    child: Divider(
                                      color: Color.fromARGB(255, 171, 167, 200),
                                      height: 5,
                                      thickness: 1,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(flex: 2),
                                      Icon(
                                        Icons.home,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5),
                                      _buildHoverContainer(
                                          viewModel, 1, '     A C A S Ă     ',
                                          () {
                                        viewModel.navigateToHome();
                                      }),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Spacer(flex: 2),
                                      Icon(
                                        Icons.batch_prediction_rounded,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5),
                                      _buildHoverContainer(
                                          viewModel, 2, 'P O S T Ă R I', () {
                                        // Action for TEST1 container
                                      }),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Spacer(flex: 2),
                                      Icon(
                                        Icons.question_mark,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5),
                                      _buildHoverContainer(
                                          viewModel, 3, 'Î N T R E B Ă R I',
                                          () {
                                        // Action for TEST1 container
                                      }),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Spacer(flex: 2),
                                      Icon(
                                        Icons.alternate_email_sharp,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5),
                                      _buildHoverContainer(
                                          viewModel, 4, 'A I  C O A C H', () {
                                        viewModel.navigateToAICOACH();
                                      }),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Spacer(flex: 2),
                                      Icon(
                                        Icons.person_pin_rounded,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5),
                                      _buildHoverContainer(
                                          viewModel, 5, 'P R O F I L U L   M E U',
                                          () {
                                        viewModel.navigateToProfileView();
                                      }),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(flex: 2),
                                      Icon(
                                        Icons.exit_to_app_rounded,
                                        color: Colors.white70,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5),
                                      _buildHoverContainer(
                                          viewModel, 6, 'I E Ș I R E', () {
                                        viewModel.signUserOut();
                                      }),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                  const Spacer(flex: 2),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FadeInRightBig(
                          child: SingleChildScrollView(
                            child: Container(
                              height: 1500,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(199, 52, 51, 51),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Container(
                                      height: 300,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 217, 63, 83),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/banner.jpg?alt=media&token=9ecb9034-6742-4a7e-9bd6-264f99df927b'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 220, // Adjust the position as needed
                                    left: 20, // Adjust the position as needed
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('usernames')
                                          .doc(user.email!)
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
                                          height: 250,
                                          width: 250,
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
                                                      fieldValue1),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 380, // Adjust the position as needed
                                    left: 290, // Adjust the position as needed
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('usernames')
                                          .doc(user.email!)
                                          
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
                                          style: TextStyle(fontSize: 30),
                                        );
                                      },
                                    ),
                                    
                                      ],
                                    ),
                                  ),
                                  Positioned(
  top: 400,
  left: 250,
  child: Padding(
    padding: const EdgeInsets.all(30.0),
    child: Row(
      children: [
        Column(
          children: [
            FadeInUp(
              delay: Duration(milliseconds: 2000),
              child: FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'following')
                                                        .doc(user.email)
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
                              
                                                      return Text(followers2.length.toString() + ' Urmăritori  | ', style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(133, 255, 255, 255),
                                          ),);
                                                      
                                                    },
                                                  ),
                
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            FadeInUp(
                                              delay: Duration(milliseconds: 2000),
                                              child: FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'following')
                                                        .doc(user.email)
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
                                                          following2 =
                                                          List<String>.from(
                                                              follDoc['following'] ??
                                                                  []);
                              
                                                      return Text(following2.length.toString() + ' Urmărești ',style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(133, 255, 255, 255),
                                          ),);
                                                      
                                                    },
                                                  ),
                
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                  Positioned(
                                     top: 500, // Adjust the position as needed
                                    left: 0,
                                    child: Container(
                                      
                                      height: 500,
                                      width: 450,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 77, 77, 146),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(720.0),
                                    bottomRight: Radius.circular(720.0),
                                    
                                    
                                  ),
                                ),
                                
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       
                                        SizedBox(height: 10,),
                                        Text("Urmăririle tale", style: TextStyle(fontSize: 20, color: const Color.fromARGB(134, 255, 255, 255)),),
                                        SizedBox(height: 10,),
                                        Container(
                                          height: 350,
                                          width: 300,
                                         child: FutureBuilder<List<Map<String, dynamic>>>(
                                              future: fetchFollowingUsers(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Center( );
                                                } else if (snapshot.hasError) {
                                                  return Center(child: Text('Error: ${snapshot.error}'));
                                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                                  return Center(child: Text('No users found'));
                                                } else {
                                                  return ListView.builder(
                                                    itemCount: snapshot.data!.length,
                                                    itemBuilder: (context, index) {
                                                      var user = snapshot.data![index];
                                                      return Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                  height: 75,
                                                                  width: 75,
                                                                  decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(70),
                                                                  image: DecorationImage(
                                                                                                        image: NetworkImage(
                                                                                                            user['image']),
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                  ),
                                                                
                                                                ),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                                                                  ),
                                                                  SizedBox(height: 10,),
                                                                  Container(
                                                                     child: Text(user['email'], style: TextStyle(fontWeight: FontWeight.w100, color:Color.fromARGB(113, 255, 255, 255)),)
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                      
                                                      return ListTile(
                                                        leading: Image.network(user['image']),
                                                        title: Text(user['name']),
                                                        subtitle: Text(user['email']),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 50,)
                                      ],
                                    ),
                                  ),
                                ),
                                 ),
                              ),
                                  
                                  
                                  Positioned(
                                    top: 200,
                                    left: 500,
                                    child: Container(height: 1000, width: 700, decoration: BoxDecoration(
                                      color: Color.fromARGB(120, 242, 69, 17),
                                       borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                   topLeft: Radius.circular(40.0),
                                   bottomLeft: Radius.circular(40.0),
                                   bottomRight: Radius.circular(40.0),
                                   
                                    
                                    
                                  ),
                                    ) ,
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                        child: FadeInUp(
                                            delay: Duration(milliseconds: 2000),
                                            child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('posts')
                                                  .where('name', isEqualTo: user.email)
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
                                                      buttonColor = Color.fromARGB(255, 218, 38, 71);
                                                    } else if (index % 5 == 1) {
                                                      buttonColor = Color.fromARGB(255, 211, 32, 0);
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
                                    
                                                            
                                                            return WallPPost(
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
                                                             /* saves: List<
                                                                      String>.from(
                                                                  post['saved'] ??
                                                                      []),*/
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
                                    )),
                                    Positioned(
                                      top: 1200,
                                      left: 0,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          height: 800,
                                          width: 1500,
                                          decoration: BoxDecoration(
                                            color: Colors.amber[700],

                                          ),
                                          child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Row(
                                        children: [
                                          FadeInUp(
                                              delay: Duration(milliseconds: 2000),
                                              child: StreamBuilder(
                                                stream: FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .where('saved', arrayContains: user.email)
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
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount:
                                                        snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {
                                                      final post =
                                                          snapshot.data!.docs[index];
                                    
                                                      Color buttonColor;
                                                      if (index % 5 == 0) {
                                                        buttonColor = Color.fromARGB(255, 218, 38, 71);
                                                      } else if (index % 5 == 1) {
                                                        buttonColor = Color.fromARGB(255, 211, 32, 0);
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
                                    
                                                              
                                                              return WallPPost(
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
                                                               /* saves: List<
                                                                        String>.from(
                                                                    post['saved'] ??
                                                                        []),*/
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              )),
                                        ],
                                        ),
                                    ),
                                        ),
                                      ),
                                    
                                    )
                                ],
                              ),
                            ),
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
