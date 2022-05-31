import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';

class CreditCardItem extends StatelessWidget {
  final CardVO card;
  final bool isRuby;
  const CreditCardItem({
    required this.card,
    this.isRuby = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: (isRuby)
            ? (card.isSelected ?? false)
                ? const BorderSide(color: Colors.yellow, width: 5)
                : BorderSide.none
            : BorderSide.none,
        borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(
            vertical: MARGIN_MEDIUM_2x, horizontal: MARGIN_MEDIUM_3x),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS),
          // border: Border.all(color: Colors.yellow, width: 5),
          gradient: LinearGradient(
              colors: [PRIMARY_COLOR, PRIMARY_COLOR.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CardLogoView(
                logo: card.cardType ?? '',
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: EditIconView(),
            ),
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: CardNumberView(cardNumber: card.cardNumber.toString()),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: CardHolderSectionView(
                cardHolder: card.cardHolder ?? '',
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ExpiresSectionView(
                expireDate: card.expirationDate ?? '',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExpiresSectionView extends StatelessWidget {
  final String expireDate;
  const ExpiresSectionView({
    required this.expireDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          CREDIT_CARD_EXPIRES,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          expireDate,
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_3x,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class CardHolderSectionView extends StatelessWidget {
  final String cardHolder;
  const CardHolderSectionView({
    required this.cardHolder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          CREDIT_CARD_CARD_HOLDER,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        FittedBox(
            fit: BoxFit.fill,
            child: Text(
              cardHolder,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_3x,
                  fontWeight: FontWeight.w700),
            ))
      ],
    );
  }
}

class CardNumberView extends StatelessWidget {
  final String cardNumber;
  const CardNumberView({
    required this.cardNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          '∗∗∗∗ ∗∗∗∗ ∗∗∗∗ ${cardNumber.substring(cardNumber.length - 4)}',
          style: const TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            wordSpacing: 3,
          ),
        ),
      ),
    );
  }
}

class EditIconView extends StatelessWidget {
  const EditIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      MdiIcons.dotsHorizontal,
      color: Colors.white,
      size: 35,
    );
  }
}

class CardLogoView extends StatelessWidget {
  final String logo;
  const CardLogoView({
    required this.logo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 25,
        width: 40,
        child: Text(
          logo,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
