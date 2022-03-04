import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/widgets/back_button.dart';

class SimpleAppBarView extends StatelessWidget implements PreferredSizeWidget {
  final bool isCrossIcon;
  final bool isTicketPage;
  const SimpleAppBarView({
    this.isCrossIcon = false,
    this.isTicketPage = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButtonView(
          () {
            (isTicketPage)
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (Route<dynamic> route) => false)
                : Navigator.of(context).pop();
          },
          isCrossIcon: isCrossIcon,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
