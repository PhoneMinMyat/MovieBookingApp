import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/color.dart';

class NormalText extends StatelessWidget {
  final String text;
  const NormalText(this.text,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style:const TextStyle(color: SECONDARY_TEXT_COLOR),
        );
  }
}