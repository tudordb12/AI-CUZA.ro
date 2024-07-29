import 'package:flutter/material.dart';
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
import 'login_viewmodel.dart';
import 'login_view.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'login_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aicuzaro/firebase_options.dart';

class LoginViewDesktop extends ViewModelWidget<LoginViewModel> {
  LoginViewDesktop({super.key});

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: kdDesktopMaxContentWidth,
                height: kdDesktopMaxContentHeight,
                child: Column(
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
                          SizedBox(
                            width: 30,
                          ),
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
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          colors: const [
                            Color.fromARGB(255, 224, 60, 5),
                            Color.fromARGB(255, 223, 31, 1),
                          ],
                        ),
                        verticalSpaceLarge,
                        FadeInUp(
                          child: Container(
                            height: 530,
                            width: 470,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color.fromARGB(255, 224, 60, 5),
                                    Color.fromARGB(255, 223, 31, 1),
                                    Color.fromARGB(255, 195, 39, 0)
                                  ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20,),
                                   Container(
                                                      height: 130,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                          'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%202%2F8792047.png?alt=media&token=e552350c-a59e-44fd-90e3-004383485329',
                                                        )),
                                                      )),
                                  SizedBox(height: 10,),
                                  Container(
                                    child: TextField(
                                      controller: viewModel.emailController,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Adresa de Email',
                                        hintStyle: TextStyle(
                                          color: Color(0xff989898),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF232323),
                                      ),
                                    ),
                                    width: 350,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF232323),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  Container(
                                    child: TextField(
                                      controller: viewModel.passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Parola',
                                        hintStyle: TextStyle(
                                          color: Color(0xff989898),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF232323),
                                      ),
                                    ),
                                    width: 350,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF232323),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeInUp(
                                      duration: Duration(milliseconds: 1800),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            80, 0, 80, 0),
                                        child: MaterialButton(
                                          onPressed: () {
                                            viewModel.signUserIn();
                                          },
                                          height: 50,

                                          // margin: EdgeInsets.symmetric(horizontal: 50),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          // decoration: BoxDecoration(
                                          // ),
                                          child: Center(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 51, 0),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(height: 25),
                                  FadeInUp(
                                    duration: Duration(milliseconds: 1800),
                                    child: GestureDetector(
                                      onTap: () {
                                        viewModel.navigateToSignUpView();
                                      },
                                      child: Text(
                                        "Nu aveți un cont?",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        viewModel.message,
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
