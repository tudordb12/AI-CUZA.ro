import 'package:aicuzaro/ui/common/app_colors.dart';
import 'package:aicuzaro/ui/common/ui_helpers.dart';
import 'package:aicuzaro/ui/common/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'home_viewmodel.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:animate_do/animate_do.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 50,
        ),
        children: [
          // AcademyIcon(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    child: Text(
                      'AI.CUZA',
                      style: ktsBodyLarge.copyWith(fontWeight: FontWeight.bold),
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
          verticalSpaceLarge,
          // HomeTitle(),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: GradientText(
                          'DESCOPERA',
                          style: ktsTitleText.copyWith(fontSize: 60),
                          colors: const [
                            Color.fromARGB(255, 255, 183, 0),
                            Color.fromARGB(255, 223, 2, 43)
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Center(
                      child: GradientText(
                        'ROBOTICA',
                        style: ktsTitleText.copyWith(fontSize: 60),
                        colors: const [
                          Color.fromARGB(255, 255, 183, 0),
                          Color.fromARGB(255, 223, 2, 43)
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Center(
                        child: Text(
                          'CU CUZA',
                          style: ktsTitleText.copyWith(fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              
              // HomeSubtitle(),
              FadeInRight(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Alăturați-vă astăzi.',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      GradientText(
                        ' Dați click pentru a începe',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                        colors: const [
                          Color.fromARGB(255, 250, 179, 0),
                          Color.fromARGB(255, 224, 2, 61)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              verticalSpaceLarge,
              //  InputField(),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              verticalSpaceMedium,
              //  HomeNotifyButton(),
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
                    gradient: LinearGradient(begin: Alignment.topCenter, colors: [
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
              ),
              verticalSpaceSmall,
              // HomeImage(),
              FadeInLeft(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'lib/assets/start.png',
                      width: kdDesktopMaxContentWidth * 0.4,
                      height: 450,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
           Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: GradientText(
                          '       ROBO       ',
                          style: ktsTitleText.copyWith(fontSize: 60),
                          colors: const [
                            Color.fromARGB(255, 226, 0, 72),
                                    Color.fromARGB(255, 223, 2, 43)
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      width: 500,
                      child: Center(
                        child: GradientText(
                          'STREAM',
                          style: ktsTitleText.copyWith(fontSize: 60),
                          colors: const [
                            Color.fromARGB(255, 226, 0, 72),
                                      Color.fromARGB(255, 223, 2, 43)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Center(
                        child: Text(
                          'SOCIAL',
                          style: ktsTitleText.copyWith(fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              
              // HomeSubtitle(),
              FadeInRight(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Alăturați-vă astăzi.',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      GradientText(
                        ' Dați click pentru a începe',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                        colors: const [
                          Color.fromARGB(255, 226, 0, 72),
                                      Color.fromARGB(255, 223, 2, 43)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              verticalSpaceLarge,
              //  InputField(),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              verticalSpaceMedium,
              //  HomeNotifyButton(),
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
                    gradient: LinearGradient(begin: Alignment.topCenter, colors: [
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
              ),
              verticalSpaceSmall,
              // HomeImage(),
              FadeInLeft(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/design%2Fappr.png?alt=media&token=f0bdb512-f646-4a72-9df2-73bbf1cf8cf9',
                      width: kdDesktopMaxContentWidth * 0.4,
                      height: 450,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
           Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: GradientText(
                          'TOATE                           ',
                          style: ktsTitleText.copyWith(fontSize: 60),
                          colors: const [
                            Color.fromARGB(255, 86, 26, 191),
                                    Color.fromARGB(255, 2, 76, 223)
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Center(
                      child: GradientText(
                        'INSTRUMENTELE',
                        style: ktsTitleText.copyWith(fontSize: 60),
                        colors: const [
                          Color.fromARGB(255, 86, 26, 191),
                                    Color.fromARGB(255, 2, 76, 223)
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Center(
                        child: Text(
                          'LA UN LOC',
                          style: ktsTitleText.copyWith(fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              
              // HomeSubtitle(),
              FadeInRight(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Alăturați-vă astăzi.',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      GradientText(
                        ' Dați click pentru a începe',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                        colors: const [
                          Color.fromARGB(255, 86, 26, 191),
                                    Color.fromARGB(255, 2, 76, 223)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              verticalSpaceLarge,
              //  InputField(),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              verticalSpaceMedium,
              //  HomeNotifyButton(),
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
                    gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                      Color.fromARGB(255, 86, 26, 191),
                                    Color.fromARGB(255, 2, 76, 223)
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
              ),
              verticalSpaceSmall,
              // HomeImage(),
              FadeInLeft(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/ai-cuza-12bf2.appspot.com/o/f9a6e49278945f27668bf243584ffde4.png?alt=media&token=222f0d65-36a7-42a4-a373-78bcf998514d',
                      width: kdDesktopMaxContentWidth * 0.4,
                      height: 450,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
           Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: GradientText(
                          'ÎNCEPUTURILE',
                          style: ktsTitleText.copyWith(fontSize: 60),
                          colors: const [
                            Color.fromARGB(255, 255, 183, 0),
                            Color.fromARGB(255, 223, 2, 43)
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Center(
                      child: GradientText(
                        'NOASTRE',
                        style: ktsTitleText.copyWith(fontSize: 60),
                        colors: const [
                          Color.fromARGB(255, 255, 119, 0),
                                    Color.fromARGB(255, 255, 57, 2)
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Center(
                        child: Text(
                          'CU CUZA',
                          style: ktsTitleText.copyWith(fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              
              // HomeSubtitle(),
              FadeInRight(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Alăturați-vă astăzi.',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      GradientText(
                        ' Dați click pentru a începe',
                        style: ktsBodyLarge.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                        colors: const [
                          Color.fromARGB(255, 255, 119, 0),
                                    Color.fromARGB(255, 255, 57, 2)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              verticalSpaceLarge,
              //  InputField(),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              verticalSpaceMedium,
              //  HomeNotifyButton(),
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
                    gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                      Color.fromARGB(255, 255, 119, 0),
                                    Color.fromARGB(255, 255, 57, 2)
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
              ),
              verticalSpaceSmall,
              // HomeImage(),
              FadeInLeft(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'lib/assets/2.jpg',
                                  width: 400,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
            ],
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
    );
  }
}
