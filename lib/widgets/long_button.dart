import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class LongButton extends StatelessWidget {
  final String buttonText;
  final bool isGhostButton;
  final Function onTap;
  const LongButton(
    this.onTap, {
    Key? key,
    required this.buttonText,
    this.isGhostButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: LONG_BUTTON_HEIGHT,
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(MARGIN_MEDIUM_2x),
        decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            border: (isGhostButton)
                ? Border.all(color: Colors.white, width: 1)
                : null,
            borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS)),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: TEXT_REGULAR_2x),
          ),
        ),
      ),
    );
  }
}
