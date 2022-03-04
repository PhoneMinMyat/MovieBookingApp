import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/long_button.dart';

class FloatingLongButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final bool isNeedTransparentSpace;
  const FloatingLongButton(this.onTap,
      {required this.buttonText, this.isNeedTransparentSpace = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TransparentViewOfFloatingButton(
          height: MARGIN_MEDIUM_3x,
          isNeedTransparent: isNeedTransparentSpace,
        ),
        FloatingButtonSectionView(
          () {
            onTap();
          },
          buttonText: buttonText,
        ),
        TransparentViewOfFloatingButton(
          height: MARGIN_XLARGE,
          isNeedTransparent: isNeedTransparentSpace,
        )
      ],
    );
  }
}

class TransparentViewOfFloatingButton extends StatelessWidget {
  final double height;
  final bool isNeedTransparent;

  const TransparentViewOfFloatingButton({
    required this.height,
    required this.isNeedTransparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (isNeedTransparent) ? height : null,
      width: double.infinity,
      color: Colors.white70,
    );
  }
}

class FloatingButtonSectionView extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  const FloatingButtonSectionView(
    this.onTap, {
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongButton(() {
      onTap();
    }, buttonText: buttonText);
  }
}
