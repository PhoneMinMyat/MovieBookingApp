import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_booking_app/bloc/payment_bloc.dart';
import 'package:movie_booking_app/data/models/requests/checkout_request.dart';
import 'package:movie_booking_app/data/models/requests/snack_request.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';

import 'package:movie_booking_app/pages/add_new_card_page.dart';
import 'package:movie_booking_app/pages/ticket_page.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/viewitems/credit_card_item.dart';
import 'package:movie_booking_app/viewitems/simple_appbar_view.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/header_text.dart';
import 'package:movie_booking_app/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final String selectdSeatName;
  final double subTotal;
  final String bookingDate;
  final int cinemaDayTimeslotId;
  final String row;
  final int movieId;
  final int cinemaId;
  final List<SnackVO> selectedSnackList;

  const PaymentPage({
    Key? key,
    required this.selectdSeatName,
    required this.subTotal,
    required this.bookingDate,
    required this.cinemaDayTimeslotId,
    required this.row,
    required this.movieId,
    required this.cinemaId,
    required this.selectedSnackList,
  }) : super(key: key);

  void navigationToAddNewCardPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewCardPage(),
      ),
    );
  }

  void navigateToTicketPage(BuildContext context, PaymentBloc bloc) {
    bloc.checkout().then((checkoutInfoRes) {
      print('CheckoutRes ===> ${checkoutInfoRes?.bookingDate}');
      if (checkoutInfoRes?.bookingNo != null) {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketPage(
              checkout: checkoutInfoRes ?? CheckoutVO(),
            ),
          ),
        );
      }
     
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    CheckOutRequest checkOutRequest = CheckOutRequest(
      cinemaDayTimeslotId: cinemaDayTimeslotId,
      row: row,
      seatNumber: selectdSeatName,
      bookingDate: bookingDate,
      totalPrice: subTotal,
      movieId: movieId,
      cinemaId: cinemaId,
      snacks: selectedSnackList
          .map((snack) => SnackRequest(id: snack.id, quantity: snack.quantity))
          .toList(),
    );

    return ChangeNotifierProvider(
      create: (context) => PaymentBloc(checkOutRequest),
      child: Selector<PaymentBloc, ProfileVO?>(
        selector: (context, bloc) => bloc.profile,
        builder: (context, profile, child) {
          PaymentBloc bloc = Provider.of<PaymentBloc>(context, listen: false);
          return Scaffold(
            appBar: const SimpleAppBarView(),
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
                  child: PaymentAmountSectionView(
                    paymentAmount: subTotal,
                  ),
                ),
                const SizedBox(height: MARGIN_MEDIUM_2x),
                CreditCardList(
                  (index) {
                    bloc.changeCard(index);
                  },
                  cardList: profile?.cards ?? [],
                ),
                const SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
                  child: AddNewCardView(() {
                    navigationToAddNewCardPage(context);
                  }),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(MARGIN_MEDIUM_2x),
                  child: FloatingLongButton(
                    () {
                      navigateToTicketPage(context, bloc);
                    },
                    buttonText: CONFIRM,
                    isNeedTransparentSpace: false,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddNewCardView extends StatelessWidget {
  final Function onTap;
  const AddNewCardView(
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        children: const [
          Icon(
            MdiIcons.plusCircle,
            color: SUB_TOTAL_TEXT_COLOR,
          ),
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            PAYMENT_PAGE_ADD_NEW_CARD,
            style: TextStyle(
                color: SUB_TOTAL_TEXT_COLOR, fontSize: TEXT_REGULAR_2x),
          ),
        ],
      ),
    );
  }
}

class CreditCardList extends StatelessWidget {
  final List<CardVO> cardList;
  final Function(int) cardChange;
  const CreditCardList(
    this.cardChange, {
    required this.cardList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (cardList.length == 0)
        ? Container()
        : CarouselSlider.builder(
            itemCount: cardList.length,
            itemBuilder: (context, itemIndex, pageviewIndex) {
              return CreditCardItem(
                card: cardList[itemIndex],
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, carouselPageChangedReason) {
                cardChange(index);
              },
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              height: CREDIT_CARD_HEIGHT,
            ),
          );
  }
}

class PaymentAmountSectionView extends StatelessWidget {
  final double paymentAmount;
  const PaymentAmountSectionView({
    required this.paymentAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleText(PAYMENT_PAGE_PAYMENT_AMOUNT),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        HeaderText('\$ $paymentAmount'),
      ],
    );
  }
}
