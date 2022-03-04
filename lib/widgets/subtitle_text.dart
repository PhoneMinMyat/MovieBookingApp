import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  final bool isBold;
  const SubTitleText(this.text, {this.isBold = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: TEXT_REGULAR_2x,
          fontWeight: (isBold) ? FontWeight.bold : null),
    );
  }
}
