import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class BackButtonView extends StatelessWidget {
  final Function onTapBackButton;
  final bool isWhite;
  final bool isCrossIcon;
  const BackButtonView(
    this.onTapBackButton, {
    this.isWhite = false,
    this.isCrossIcon = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBackButton();
      },
      child: Icon(
       (isCrossIcon)? Icons.close :Icons.chevron_left,
        color: (isWhite) ? Colors.white : Colors.black,
        size:(isCrossIcon)? CLOSE_BUTTON_ICON_SIZE :BACK_BUTTON_SIZE,
      ),
    );
  }
}
