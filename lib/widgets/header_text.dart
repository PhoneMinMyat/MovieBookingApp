import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText(this.text,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text, style: const TextStyle(fontSize: TEXT_HEADING_2X, fontWeight: FontWeight.bold),
    );
  }
}