import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widget_keys.dart';

class Counter extends StatefulWidget {
  final Function() increaseCount;
  final Function() decreaseCount;
  final int count;
  final String snackName;

  const Counter(this.decreaseCount, this.increaseCount,
      {required this.count,required ,required this.snackName, Key? key})
      : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: COUNTER_WIDTH,
      height: COUNTER_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClickButton(
            () {
              widget.decreaseCount();
            },key: Key(widget.snackName+KEY_SNACK_DECREASE),
          ),
          NumberView(number: widget.count.toString()),
          ClickButton(
            () {
              widget.increaseCount();
            },
            isPlus: true,key: Key(widget.snackName+KEY_SNACK_INCREASE),
          ),
        ],
      ),
    );
  }
}

class NumberView extends StatelessWidget {
  const NumberView({
    Key? key,
    required this.number,
  }) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: COUNTER_WIDTH / 3,
      height: COUNTER_HEIGHT,
      decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: SECONDARY_TEXT_COLOR))),
      child: Center(
          child: Text(
        number,
        style: const TextStyle(
            fontSize: TEXT_REGULAR_2x, color: SECONDARY_TEXT_COLOR),
      )),
    );
  }
}

class ClickButton extends StatelessWidget {
  final Function onTap;
  final bool isPlus;
  const ClickButton(
    this.onTap, {
    this.isPlus = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: COUNTER_WIDTH / 3,
        height: COUNTER_HEIGHT,
        decoration: BoxDecoration(
          border: Border.all(color: SECONDARY_TEXT_COLOR, width: 1),
          borderRadius: (isPlus)
              ? const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
        ),
        child: Center(
          child: Text(
            (isPlus) ? '+' : '-',
            style: const TextStyle(
                fontSize: TEXT_REGULAR_2x, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
