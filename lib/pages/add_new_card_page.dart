import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_booking_app/bloc/new_card_bloc.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/network/responses/error_response.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/viewitems/simple_appbar_view.dart';
import 'package:movie_booking_app/widget_keys.dart';
import 'package:movie_booking_app/widgets/floating_long_button.dart';
import 'package:movie_booking_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({Key? key}) : super(key: key);

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController expirationController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  //Modal
  final TmbaModel _tmbaModel = TmbaModelImpl();
  void createCard(NewCardBloc bloc) async {
    if (cardNumberController.text.isNotEmpty &&
        cardHolderController.text.isNotEmpty &&
        expirationController.text.isNotEmpty &&
        cvcController.text.isNotEmpty) {
      await bloc
          .createCard(
              cardNumber: cardNumberController.text,
              cardHolder: cardHolderController.text,
              expiration: expirationController.text,
              cvc: cvcController.text)
          .then((value) async{
       await bloc.getProfile();
        Navigator.pop(context);
        print('Pop');
      }).catchError((error) => print(error));
    } else {
      handleError(context, 'Please Fill All The Fields');
    }
  }

  void handleError(BuildContext context, dynamic error) {
    if (error is DioError) {
      try {
        ErrorResponse errorResponse =
            ErrorResponse.fromJson(error.response?.data);
        // print(error.response?.extra);
        print(error.response?.headers);
        print(error.response?.redirects);
        print(error.response?.statusMessage);

        showErrorAlert(context, errorResponse.message ?? '');
      } on Error catch (_) {
        showErrorAlert(context, error.message);
      }
    } else {
      showErrorAlert(context, error.toString());
    }
  }

  void showErrorAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error!!!'),
        content: SingleChildScrollView(child: Text(message)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewCardBloc(),
      builder: (context, child) {
        NewCardBloc bloc = Provider.of<NewCardBloc>(context, listen: false);
        return Scaffold(
          appBar: const SimpleAppBarView(),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWithHeaderView(
                  labelText: ADD_CARD_NUMBER,
                  keyboardType: TextInputType.number,
                  controller: cardNumberController,
                  hintText: '123456789876543',
                  key: const Key(KEY_CARD_NUMBER_FIELD),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3x,
                ),
                TextFieldWithHeaderView(
                  labelText: ADD_CARD_HOLDER,
                  controller: cardHolderController,
                  hintText: 'John',
                  key: const Key(KEY_CARD_HOLDER_FIELD),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3x,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.4),
                      child: TextFieldWithHeaderView(
                        labelText: ADD_EXPIRATION_DATE,
                        keyboardType: TextInputType.datetime,
                        controller: expirationController,
                        hintText: '08/21',
                        key: const Key(KEY_CARD_EXPIRATIONG_DATE_FIELD),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.4),
                      child: TextFieldWithHeaderView(
                        labelText: ADD_CVC,
                        keyboardType: TextInputType.number,
                        hintText: '123',
                        controller: cvcController,
                        key: const Key(KEY_CARD_CVC_FIELD),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                FloatingLongButton(
                  () {
                    createCard(bloc);
                  },
                  buttonText: CONFIRM,
                  key: const Key(KEY_ADD_NEW_CARD_CONFIRM),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextFieldWithHeaderView extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hintText;
  const TextFieldWithHeaderView({
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(labelText),
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: SECONDARY_TEXT_COLOR)),
        ),
      ],
    );
  }
}
