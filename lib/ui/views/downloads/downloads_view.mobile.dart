import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:aicuzaro/ui/common/app_colors.dart';
import 'package:aicuzaro/ui/common/ui_helpers.dart';
import 'package:aicuzaro/ui/common/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:aicuzaro/ui/common/shared_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:animate_do/animate_do.dart';
import 'downloads_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadsViewMobile extends ViewModelWidget<DownloadsViewModel> {
  const DownloadsViewMobile({super.key});

  @override
  Widget build(BuildContext context, DownloadsViewModel viewModel) {
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
            verticalSpaceLarge,
         
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: GradientText(
                        'DESCARCARI',
                        style: ktsTitleText.copyWith(fontSize: 50),
                        colors: const [
                          Color.fromARGB(255, 255, 183, 0),
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
                        'AI.CUZA',
                        style: ktsTitleText.copyWith(fontSize: 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,

            // HomeSubtitle(),

            verticalSpaceLarge,
            //  InputField(),
            SizedBox(
              height: 20,
            ),
            Text(
              ' Download for Android',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                const url =
                    'https://www.dropbox.com/scl/fi/syogbyyftu5hatig7pepp/CuzzApp.apk?rlkey=og39pz2wbts2auz3n3hv56mmg&st=d41eelun&dl=1';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Color.fromARGB(255, 206, 0, 76),
                    Color.fromRGBO(223, 8, 94, 1),
                    Color.fromARGB(255, 219, 23, 124)
                  ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Download CUZZApp',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 300,
                child: Text(
                  'O aplicație educativă STEM din cadrul aceluiași Startup',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
                )),

            verticalSpaceSmall,
            // HomeImage(),
            FadeInLeft(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'lib/assets/startup.png',
                    width: kdDesktopMaxContentWidth * 0.4,
                    height: 450,
                    fit: BoxFit.contain,
                  ),
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
          ]),
    );
  }
}
