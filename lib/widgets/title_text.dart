import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText(this.text,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: TEXT_HEADING),
            );
  }
}