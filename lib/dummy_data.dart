import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/utils/constraints.dart';

const List<String> comboList = [
  'Combo set M',
  'Combo set L',
  'Combo for 2',
  'Combo for 3',
  'Combo for Family',
];

const List menuList = [
  [MdiIcons.tagHeart, 'Promotion Code'],
  [MdiIcons.googleTranslate, 'Select a language'],
  [MdiIcons.clipboardText, 'Term of services'],
  [MdiIcons.help, 'Help'],
  [MdiIcons.starCircle, 'Rate us']
];

const List paymentMethodList = [
  [MdiIcons.creditCardChip, 'Credit card'],
  [MdiIcons.creditCardOutline, 'Internet banking (ATM card)'],
  [MdiIcons.wallet, 'E-wallet'],
];

List<MovieSeatVO> dummyMovieSeats = [];
