import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'signup_viewmodel.dart';
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
import 'signup_view.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aicuzaro/firebase_options.dart';

import 'signup_viewmodel.dart';

class SignupViewMobile extends ViewModelWidget<SignupViewModel> {
  const SignupViewMobile({super.key});

  @override
  Widget build(BuildContext context, SignupViewModel viewModel) {
    return Scaffold(
        backgroundColor: kcBackgroundColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 50,
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    InkWell(
                      child: Text(
                        'AI.CUZA',
                        style:
                            ktsBodyLarge.copyWith(fontWeight: FontWeight.bold),
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
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: kdDesktopMaxContentWidth,
                  height: kdDesktopMaxContentHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientText(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                        colors: const [
                          Color.fromARGB(255, 224, 5, 34),
                          Color.fromARGB(255, 223, 1, 60),
                        ],
                      ),
                      verticalSpaceLarge,
                      FadeInUp(
                        child: Container(
                          height: 550,
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
                                  Color.fromARGB(255, 224, 5, 34),
                                  Color.fromARGB(255, 223, 1, 34),
                                  Color.fromARGB(255, 195, 0, 49)
                                ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: TextField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Numele Complet',
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
                                //verticalSpaceMedium,
                                SizedBox(
                                  height: 10,
                                ),
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
                                //verticalSpaceMedium,
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: TextField(
                                    obscureText: true,
                                    controller: viewModel.passwordController,
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
                                // verticalSpaceMedium,
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: TextField(
                                    obscureText: true,
                                    controller:
                                        viewModel.confirmPasswordController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Verificare Parolă',
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

                                FadeInUp(
                                    duration: Duration(milliseconds: 1600),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 0, 80, 0),
                                      child: MaterialButton(
                                        onPressed: () {
                                          viewModel.signUserUp();
                                        },
                                        height: 50,

                                        // margin: EdgeInsets.symmetric(horizontal: 50),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        // decoration: BoxDecoration(
                                        // ),
                                        child: Center(
                                          child: Text(
                                            "Sign Up",
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
                                  duration: Duration(milliseconds: 1700),
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.navigateToLoginView();
                                    },
                                    child: Text(
                                      "Aveți deja un cont?",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 213, 213, 213),
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // ViewModel.message2,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
