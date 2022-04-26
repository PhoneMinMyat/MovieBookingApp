import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewitems/counter_item.dart';
import 'package:movie_booking_app/widgets/normal_text.dart';
import 'package:movie_booking_app/widgets/subtitle_text.dart';

class ComboSetView extends StatelessWidget {
  final SnackVO snack;
  final Function(int) decreaseCounter;
  final Function(int) increaseCounter;
  const ComboSetView(
    this.decreaseCounter,
    this.increaseCounter, {
    required this.snack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: ComboSetInfoSectionView(
              comboTitle: snack.name ?? '',
              descriptionText: snack.description ?? '',
            ),
          ),
          ComboSetPriceAndQtySectionView(() {
            decreaseCounter(snack.id ?? 0);
          }, () {
            increaseCounter(snack.id ?? 0);
          }, count: snack.quantity ?? 0, price: snack.price.toString(),snackName: snack.name?? '',),
        ],
      ),
      const SizedBox(
        height: MARGIN_MEDIUM_2x,
      )
    ]);
  }
}

class ComboSetPriceAndQtySectionView extends StatelessWidget {
  final int count;
  final String price;
  final Function decreaseCounter;
  final Function increaseCounter;
  final String snackName;
  const ComboSetPriceAndQtySectionView(
    this.decreaseCounter,
    this.increaseCounter, {
    required this.count,
    required this.price,required this.snackName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SubTitleText('$price\$'),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Counter(() {
          decreaseCounter();
        }, () {
          increaseCounter();
        }, count: count, snackName: snackName,)
      ],
    );
  }
}

class ComboSetInfoSectionView extends StatelessWidget {
  final String comboTitle;
  final String descriptionText;
  const ComboSetInfoSectionView({
    required this.comboTitle,
    required this.descriptionText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(comboTitle),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        NormalText(
          descriptionText,
        )
      ],
    );
  }
}
