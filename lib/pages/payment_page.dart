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
import 'package:movie_booking_app/widget_keys.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/header_text.dart';
import 'package:movie_booking_app/widgets/subtitle_text.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
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

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentBloc? paymentBloc;

  @override
  void initState() {
    CheckOutRequest checkOutRequest = CheckOutRequest(
      cinemaDayTimeslotId: widget.cinemaDayTimeslotId,
      row: widget.row,
      seatNumber: widget.selectdSeatName,
      bookingDate: widget.bookingDate,
      totalPrice: widget.subTotal,
      movieId: widget.movieId,
      cinemaId: widget.cinemaId,
      snacks: widget.selectedSnackList
          .map((snack) => SnackRequest(id: snack.id, quantity: snack.quantity))
          .toList(),
    );
    paymentBloc = PaymentBloc(checkOutRequest);
    paymentBloc?.makeRun();
    super.initState();
  }

  @override
  void dispose() {
    paymentBloc?.makeDispose();
    super.dispose();
  }

  void navigationToAddNewCardPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewCardPage(),
      ),
    );
  }

  void navigateToTicketPage(BuildContext context) {
    paymentBloc?.checkout().then((checkoutInfoRes) {
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
    return ChangeNotifierProvider(
      create: (context) => paymentBloc,
      child: Selector<PaymentBloc, ProfileVO?>(
        selector: (context, bloc) => bloc.profile,
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, profile, child) {
          PaymentBloc bloc = Provider.of<PaymentBloc>(context, listen: false);
          print('Payment Bloc ===> ${profile.toString()}');
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
                    paymentAmount: widget.subTotal,
                  ),
                ),
                const SizedBox(height: MARGIN_MEDIUM_2x),
                CreditCardList(
                  (index) {
                    bloc.changeCard(index);
                  },
                  cardList: profile?.cards ?? [],
                  key: const Key(KEY_CARD_LIST),
                ),
                const SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2x),
                  child: AddNewCardView(
                    () {
                      navigationToAddNewCardPage(context);
                    },
                    key: const Key(KEY_ADD_NEW_CARD_BUTTON),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(MARGIN_MEDIUM_2x),
                  child: FloatingLongButton(
                    () {
                      navigateToTicketPage(context);
                    },
                    buttonText: CONFIRM,
                    isNeedTransparentSpace: false,
                    key: const Key(KEY_PAYMENT_CONFIRM),
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
        mainAxisSize: MainAxisSize.max,
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
    List<CardVO> reversedCardList = cardList.reversed.toList();
    return (reversedCardList.length == 0)
        ? Container()
        : CarouselSlider.builder(
            itemCount: reversedCardList.length,
            itemBuilder: (context, itemIndex, pageviewIndex) {
              return CreditCardItem(
                card: reversedCardList[itemIndex],
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, carouselPageChangedReason) {
                cardChange(reversedCardList.length - 1 - index);
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
