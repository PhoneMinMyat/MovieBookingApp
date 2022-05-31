// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_booking_app/config/config_values.dart';
import 'package:movie_booking_app/config/environment_config.dart';

Color PRIMARY_COLOR = kAppThemeColors[EnvironmentConfig.kConfigThemeColor] ??
    const Color.fromRGBO(98, 62, 234, 1.0);
const SECONDARY_TEXT_COLOR = Color.fromRGBO(140, 159, 179, 1.0);
const SUB_TOTAL_TEXT_COLOR = Color.fromRGBO(59, 203, 159, 1.0);
const TICKET_COLOR = Color.fromRGBO(244, 244, 244, 1.0);

const MOVIE_SEAT_AVAILABLE_COLOR = Color.fromRGBO(208, 216, 235, 1.0);
const MOVIE_SEAT_TAKEN_COLOR = Color.fromRGBO(129, 145, 178, 1.0);
Color MOVIE_SEAT_SELECT_COLOR = kAppThemeColors[EnvironmentConfig.kConfigThemeColor] ??
    const Color.fromRGBO(98, 62, 234, 1.0);
