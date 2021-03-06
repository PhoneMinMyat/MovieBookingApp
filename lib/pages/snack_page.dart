import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_booking_app/bloc/snack_bloc.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';

import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/viewitems/combo_set_view.dart';
import 'package:movie_booking_app/viewitems/simple_appbar_view.dart';
import 'package:movie_booking_app/widget_keys.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/normal_text.dart';
import 'package:movie_booking_app/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class SnackPage extends StatefulWidget {
  final String selectdSeatName;
  final double seatPrice;
  final String bookingDate;
  final int cinemaDayTimeslotId;
  final String row;
  final int movieId;
  final int cinemaId;

  const SnackPage({
    Key? key,
    required this.selectdSeatName,
    required this.seatPrice,
    required this.bookingDate,
    required this.cinemaDayTimeslotId,
    required this.row,
    required this.movieId,
    required this.cinemaId,
  }) : super(key: key);

  @override
  State<SnackPage> createState() => _SnackPageState();
}

class _SnackPageState extends State<SnackPage> {
  SnackBloc snackBloc = SnackBloc();

  @override
  void dispose() {
    snackBloc.makeDispose();
    super.dispose();
  }

  void navigateToPaymentPage(
      {required BuildContext context,
      required double totalSnackPrice,
      required List<SnackVO> selectedSnackList}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentPage(
                  selectdSeatName: widget.selectdSeatName,
                  bookingDate: widget.bookingDate,
                  cinemaDayTimeslotId: widget.cinemaDayTimeslotId,
                  row: widget.row,
                  movieId: widget.movieId,
                  cinemaId: widget.cinemaId,
                  subTotal: widget.seatPrice + totalSnackPrice,
                  selectedSnackList: selectedSnackList,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => snackBloc,
      child: Selector<SnackBloc, double>(
          selector: (context, bloc) => bloc.totalPrice,
          builder: (context, totalPrice, child) {
            SnackBloc bloc = Provider.of<SnackBloc>(context, listen: false);
            return Scaffold(
              appBar: const SimpleAppBarView(),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Selector<SnackBloc, List<SnackVO>?>(
                        selector: (context, bloc) => bloc.snackList,
                        builder: (context, snackList, child) =>
                            ComboSectionView(
                          (snackId) {
                            SnackBloc bloc =
                                Provider.of<SnackBloc>(context, listen: false);
                            bloc.decreaseCounter(snackId);
                          },
                          (snackId) {
                            SnackBloc bloc =
                                Provider.of<SnackBloc>(context, listen: false);
                            bloc.increaseCounter(snackId);
                          },
                          snackList: snackList ?? [],
                        ),
                      ),
                      const PromoCodeSectionView(),
                      const SizedBox(height: MARGIN_MEDIUM_2x),
                      SubTotalText(
                        totalAmount: widget.seatPrice + totalPrice,
                      ),
                      const SizedBox(height: MARGIN_MEDIUM_2x),
                      Selector<SnackBloc, List<PaymentMethodVO>?>(
                        selector: (context, bloc) => bloc.paymentMethodList,
                        builder: (context, paymentMethodList, child) =>
                            PaymentMethodSectionView(
                          paymentMethodList: paymentMethodList ?? [],
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_MEDIUM_2x,
                      ),
                      FloatingLongButton(
                        () {
                          navigateToPaymentPage(
                              context: context,
                              selectedSnackList: bloc.getSelectedSnackList(),
                              totalSnackPrice: totalPrice);
                        },
                        buttonText: CONFIRM,
                        key: const Key(KEY_SNACK_CONFIRM),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class PaymentMethodSectionView extends StatelessWidget {
  final List<PaymentMethodVO> paymentMethodList;
  const PaymentMethodSectionView({
    required this.paymentMethodList,
    Key? key,
  }) : super(key: key);

  IconData getIconData(int id) {
    if (id == 1) {
      return MdiIcons.creditCardChip;
    }
    if (id == 2) {
      return MdiIcons.creditCardOutline;
    } else {
      return MdiIcons.wallet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleText(
          SUBPAGE_PAYMENT_METHOD,
          isBold: true,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2x,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PayMentMethodCardView(
                  iconData: getIconData(paymentMethodList[index].id ?? 1),
                  cardType: paymentMethodList[index].name ?? '',
                  description: paymentMethodList[index].description ?? '');
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: MARGIN_MEDIUM_2x,
                ),
            itemCount: paymentMethodList.length)
      ],
    );
  }
}

class PayMentMethodCardView extends StatelessWidget {
  final IconData iconData;
  final String cardType;
  final String description;
  const PayMentMethodCardView({
    required this.iconData,
    required this.cardType,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: SECONDARY_TEXT_COLOR,
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2x,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SubTitleText(cardType), NormalText(description)],
        )
      ],
    );
  }
}

class PromoCodeSectionView extends StatelessWidget {
  const PromoCodeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PromoCodeTextFieldView(),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        GetPromoCodeView(),
      ],
    );
  }
}

class SubTotalText extends StatelessWidget {
  final double totalAmount;
  const SubTotalText({
    required this.totalAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$SUBPAGE_SUB_TOTAL ${totalAmount.toString()}\$',
      style: const TextStyle(
          color: SUB_TOTAL_TEXT_COLOR,
          fontSize: TEXT_REGULAR_2x,
          fontWeight: FontWeight.w600),
    );
  }
}

class GetPromoCodeView extends StatelessWidget {
  const GetPromoCodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        NormalText(
          SUBPAGE_DONT_HAVE_PROMO_CODE,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(SUBPAGE_GET_IT_NOW)
      ],
    );
  }
}

class PromoCodeTextFieldView extends StatelessWidget {
  const PromoCodeTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
          hintText: SUBPAGE_ENTER_PROMO_CODE,
          hintStyle: TextStyle(
              color: SECONDARY_TEXT_COLOR, fontStyle: FontStyle.italic)),
    );
  }
}

class ComboSectionView extends StatelessWidget {
  final List<SnackVO> snackList;
  final Function(int) decreaseCounter;
  final Function(int) increaseCounter;
  const ComboSectionView(
    this.decreaseCounter,
    this.increaseCounter, {
    required this.snackList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: snackList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ComboSetView(
            (snackId) {
              decreaseCounter(snackId);
            },
            (snackId) {
              increaseCounter(snackId);
            },
            snack: snackList[index],
          );
        });
  }
}
