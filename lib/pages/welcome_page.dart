import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/widgets/long_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  void navigateToLogInPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return  LogInPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Center(
              child: WelcomeImageSectionView(),
            ),
            const SizedBox(height: MARGIN_XXLARGE + MARGIN_XXLARGE),
            const Text(
              WELCOME_PAGE_TITLE,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_BIG,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_2x,
            ),
            const Text(
              WELCOME_PAGE_SUBTITLE,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2x,
                  fontWeight: FontWeight.w400
                  ),
            ),
            const SizedBox(
              height: MARGIN_XXLARGE + MARGIN_XXLARGE,
            ),
            LongButton(
              () {
                navigateToLogInPage(context);
              },
              buttonText: WELCOME_PAGE_BUTTON_TEXT,
              isGhostButton: true,
            ),
            const SizedBox(
              height: MARGIN_XXLARGE,
            )
          ],
        ),
      ),
    );
  }
}

class WelcomeImageSectionView extends StatelessWidget {
  const WelcomeImageSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/welcome_image.png',
      height: WELCOMEPAGE_IMAGE_HEIGHT,
    );
  }
}
