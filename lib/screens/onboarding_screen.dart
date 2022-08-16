import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../const/theme.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      done: Text(
        "Home",
        style: titleStyle.copyWith(fontSize: 16),
      ),
      pages: [
        PageViewModel(
          title: "One who plan ahead live a thousand lives",
          body: "The man who never plan lives only once",
          decoration: getPageDecoration(),
          image: buildImage(imageUrl: "assets/images/onboarding_image_2.png"),
        ),
        PageViewModel(
          title: "Plan ahead",
          body: "Available right at your fingertip",
          decoration: getPageDecoration(),
          image: buildImage(imageUrl: "assets/images/onboarding_image_3.png"),
        ),
        PageViewModel(
          title: "Never miss out on scheduled activities",
          body: "You ve got the right Todo App",
          decoration: getPageDecoration(),
          footer: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => bluishColor,
              ),
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(15),
              ),
            ),
            onPressed: () {
              Get.to(() => const MyHomePage());
            },
            child: Text(
              "Get started",
              style: titleStyle.copyWith(color: Colors.white),
            ),
          ),
          image: buildImage(imageUrl: "assets/images/onboarding_image_4.png"),
        ),
      ],
      next: Icon(Icons.arrow_forward_ios),
      skip: Text(
        "Skip",
        style: titleStyle.copyWith(fontSize: 16),
      ),
      onSkip: () {
        Get.to(() => const MyHomePage());
      },
      onDone: () {
        Get.to(() => const MyHomePage());
      },
      showSkipButton: true,
      dotsDecorator: getDotDecoration(),
      animationDuration: 1000,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      activeSize: const Size(22, 10),
    );
  }

  Center buildImage({required String imageUrl}) {
    return Center(
      child: Image.asset(
        imageUrl,
        width: 350,
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
      titleTextStyle: headingStyle.copyWith(fontSize: 28),
      bodyTextStyle: titleStyle,
      bodyPadding: const EdgeInsets.all(12).copyWith(bottom: 0),
      imagePadding: const EdgeInsets.all(24),
    );
  }
}
