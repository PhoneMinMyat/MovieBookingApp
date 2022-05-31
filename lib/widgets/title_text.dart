import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class TitleText extends StatelessWidget {
  final String text;
  final bool isSeatPage;
  const TitleText(this.text, {this.isSeatPage = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: (isSeatPage) ? TextAlign.center : null,
      style:
          const TextStyle(fontWeight: FontWeight.w600, fontSize: TEXT_HEADING),
    );
  }
}
