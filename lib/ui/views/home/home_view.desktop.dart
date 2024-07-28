import 'package:aicuzaro/app/app.router.dart';
import 'package:aicuzaro/ui/common/app_colors.dart';
import 'package:aicuzaro/ui/common/app_constants.dart';
import 'package:aicuzaro/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked_services/stacked_services.dart';
import 'home_viewmodel.dart';
import 'home_view.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:animate_do/animate_do.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});
  final Color buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
        // Outside Row
        //{}
        backgroundColor: kcBackgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: kdDesktopMaxContentWidth,
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Left side of screen
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: FadeInUp(
                            duration: Duration(milliseconds: 500),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'lib/assets/design.png',
                                width: kdDesktopMaxContentWidth * 0.02,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('lib/assets/design.png'),
                                      fit: BoxFit.fill)),
                            ),
                            Row(
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
                                    viewModel.navigateToInfoView();
                                  },
                                  child: Text(
                                    'Creează-ți propriul CUZA',
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

                            // Space
                            const Spacer(flex: 2),

                            // Title
                            FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: GradientText(
                                'DESCOPERA\nROBOTICA',
                                style: ktsTitleText,
                                colors: const [
                                  Color.fromARGB(255, 255, 183, 0),
                                  Color.fromARGB(255, 223, 2, 43)
                                ],
                              ),
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1500),
                              child: Text(
                                'CU CUZA',
                                style: ktsTitleText,
                              ),
                            ),
                            
                            // Subtitle
                            FadeInRight(
                              child: Row(
                                children: [
                                  Text(
                                    'Alăturați-vă astăzi.',
                                    style: ktsBodyLarge.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GradientText(
                                    ' Dați click pentru a începe',
                                    style: ktsBodyLarge.copyWith(
                                        fontWeight: FontWeight.w600),
                                    colors: const [
                                      Color.fromARGB(255, 250, 179, 0),
                                      Color.fromARGB(255, 224, 2, 61)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            
                            verticalSpaceMedium,
                            
                            // Arrow
                            
                            verticalSpaceSmall,
                            
                            Row(
                              children: [
                                // Input Field
                                Container(
                                  child: const TextField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Introduceți Adresa de Email',
                                      hintStyle: TextStyle(
                                        color: Color(0xff989898),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF232323),
                                    ),
                                  ),
                                  width: kdDesktopMaxContentWidth * 0.3,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF232323),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                            
                                horizontalSpaceSmall,
                            
                                // Notify Button
                                InkWell(
                                  onTap: () {
                                    viewModel.navigateToLoginView();
                                  },
                                  child: Container(
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
                                            Color.fromARGB(255, 207, 29, 1),
                                            Color.fromARGB(255, 211, 14, 67)
                                          ]),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            
                            const Spacer(flex: 10)
                          ],
                        ),
                        // Right side of screen
                        FadeInLeft(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'lib/assets/start.png',
                                width: kdDesktopMaxContentWidth * 0.4,
                                height: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  
                  decoration: BoxDecoration(
                    color: Color.fromARGB(19, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SizedBox(
                    width: kdDesktopMaxContentWidth,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Left side of screen
                          FadeInLeft(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fappr.png?alt=media&token=f0bdb512-f646-4a72-9df2-73bbf1cf8cf9',
                                  width: kdDesktopMaxContentWidth * 0.4,
                                  height: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Spacer(flex: 2,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('lib/assets/design.png'),
                                        fit: BoxFit.fill)),
                              ),
                            
                  
                              // Space
                              const Spacer(flex: 2),
                  
                              // Title
                              FadeInUp(
                                duration: Duration(milliseconds: 1000),
                                child: GradientText(
                                  'ROBO\nSTREAM',
                                  style: ktsTitleText,
                                  colors: const [
                                    Color.fromARGB(255, 226, 0, 72),
                                    Color.fromARGB(255, 223, 2, 43)
                                  ],
                                ),
                              ),
                              FadeInUp(
                                duration: Duration(milliseconds: 1500),
                                child: Text(
                                  'SOCIAL',
                                  style: ktsTitleText,
                                ),
                              ),
                              Container(
                                width: 580,
                                child: Text(
                                        'Descoperă noi idei. Cere ajutor. Oferă Răspunsuri. Împărtășește noi idei de robotică!',
                                        style: ktsBodyLarge.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                              // Subtitle
                              FadeInRight(
                                child: Row(
                                  children: [
                                    Text(
                                      'Alăturați-vă astăzi.',
                                      style: ktsBodyLarge.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GradientText(
                                      ' Dați click pentru a începe',
                                      style: ktsBodyLarge.copyWith(
                                          fontWeight: FontWeight.w600),
                                      colors: const [
                                        Color.fromARGB(255, 226, 0, 72),
                                    Color.fromARGB(255, 223, 2, 43)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              
                              verticalSpaceMedium,
                              
                              // Arrow
                              
                              verticalSpaceSmall,
                              
                              Row(
                                children: [
                                  // Input Field
                                  Container(
                                    child: const TextField(
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Introduceți Adresa de Email',
                                        hintStyle: TextStyle(
                                          color: Color(0xff989898),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF232323),
                                      ),
                                    ),
                                    width: kdDesktopMaxContentWidth * 0.3,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF232323),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                              
                                  horizontalSpaceSmall,
                              
                                  // Notify Button
                                  InkWell(
                                    onTap: () {
                                      viewModel.navigateToLoginView();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            colors: [
                                              Color.fromARGB(255, 226, 0, 72),
                                    Color.fromARGB(255, 223, 2, 43)
                                            ]),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              
                              const Spacer(flex: 10)
                            ],
                          ),
                          // Right side of screen
                         
                        ],
                      ),
                    ),
                  ),
                ),
                 SizedBox(
                  width: kdDesktopMaxContentWidth,
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Left side of screen
                        FadeInLeft(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'lib/assets/start.png',
                                width: kdDesktopMaxContentWidth * 0.4,
                                height: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 2,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('lib/assets/design.png'),
                                      fit: BoxFit.fill)),
                            ),
                          

                            // Space
                            const Spacer(flex: 2),

                            // Title
                            FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: GradientText(
                                'ROBOSTREAM',
                                style: ktsTitleText,
                                colors: const [
                                  Color.fromARGB(255, 255, 183, 0),
                                  Color.fromARGB(255, 223, 2, 43)
                                ],
                              ),
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1500),
                              child: Text(
                                'CU CUZA',
                                style: ktsTitleText,
                              ),
                            ),
                            
                            // Subtitle
                            FadeInRight(
                              child: Row(
                                children: [
                                  Text(
                                    'Alăturați-vă astăzi.',
                                    style: ktsBodyLarge.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GradientText(
                                    ' Dați click pentru a începe',
                                    style: ktsBodyLarge.copyWith(
                                        fontWeight: FontWeight.w600),
                                    colors: const [
                                      Color.fromARGB(255, 250, 179, 0),
                                      Color.fromARGB(255, 224, 2, 61)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            
                            verticalSpaceMedium,
                            
                            // Arrow
                            
                            verticalSpaceSmall,
                            
                            Row(
                              children: [
                                // Input Field
                                Container(
                                  child: const TextField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Introduceți Adresa de Email',
                                      hintStyle: TextStyle(
                                        color: Color(0xff989898),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF232323),
                                    ),
                                  ),
                                  width: kdDesktopMaxContentWidth * 0.3,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF232323),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                            
                                horizontalSpaceSmall,
                            
                                // Notify Button
                                InkWell(
                                  onTap: () {
                                    viewModel.navigateToLoginView();
                                  },
                                  child: Container(
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
                                            Color.fromARGB(255, 207, 29, 1),
                                            Color.fromARGB(255, 211, 14, 67)
                                          ]),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            
                            const Spacer(flex: 10)
                          ],
                        ),
                        // Right side of screen
                       
                      ],
                    ),
                  ),
                ),
                 SizedBox(
                  width: kdDesktopMaxContentWidth,
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Left side of screen
                        FadeInLeft(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fappr.png?alt=media&token=f0bdb512-f646-4a72-9df2-73bbf1cf8cf9',
                                width: kdDesktopMaxContentWidth * 0.4,
                                height: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 2,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('lib/assets/design.png'),
                                      fit: BoxFit.fill)),
                            ),
                          

                            // Space
                            const Spacer(flex: 2),

                            // Title
                            FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: GradientText(
                                'ROBOSTREAM',
                                style: ktsTitleText,
                                colors: const [
                                  Color.fromARGB(255, 255, 183, 0),
                                  Color.fromARGB(255, 223, 2, 43)
                                ],
                              ),
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1500),
                              child: Text(
                                'CU CUZA',
                                style: ktsTitleText,
                              ),
                            ),
                            
                            // Subtitle
                            FadeInRight(
                              child: Row(
                                children: [
                                  Text(
                                    'Alăturați-vă astăzi.',
                                    style: ktsBodyLarge.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GradientText(
                                    ' Dați click pentru a începe',
                                    style: ktsBodyLarge.copyWith(
                                        fontWeight: FontWeight.w600),
                                    colors: const [
                                      Color.fromARGB(255, 250, 179, 0),
                                      Color.fromARGB(255, 224, 2, 61)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            
                            verticalSpaceMedium,
                            
                            // Arrow
                            
                            verticalSpaceSmall,
                            
                            Row(
                              children: [
                                // Input Field
                                Container(
                                  child: const TextField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Introduceți Adresa de Email',
                                      hintStyle: TextStyle(
                                        color: Color(0xff989898),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF232323),
                                    ),
                                  ),
                                  width: kdDesktopMaxContentWidth * 0.3,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF232323),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                            
                                horizontalSpaceSmall,
                            
                                // Notify Button
                                InkWell(
                                  onTap: () {
                                    viewModel.navigateToLoginView();
                                  },
                                  child: Container(
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
                                            Color.fromARGB(255, 207, 29, 1),
                                            Color.fromARGB(255, 211, 14, 67)
                                          ]),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            
                            const Spacer(flex: 10)
                          ],
                        ),
                        // Right side of screen
                       
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 300,
                  child: Image.asset(
                    'lib/assets/footer.png',
                    width: kdDesktopMaxContentWidth * 0.4,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                
              ],
            ),
          ),
        ));
  }
}
