import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/bloc/my_app_bloc.dart';
import 'package:movie_booking_app/data/vos/actor_list_vo.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/country_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/data/vos/collection_vo.dart';
import 'package:movie_booking_app/data/vos/production_company_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/welcome_page.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ProfileVOAdapter());
  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(CountryVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(TimeslotsVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(PaymentMethodVOAdapter());
  Hive.registerAdapter(CinemaListVOAdapter());
  Hive.registerAdapter(ActorListVOAdapter());

  await Hive.openBox<ProfileVO>(BOX_NAME_PROFILE_VO);
  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<CinemaListVO>(BOX_NAME_CINEMA_LIST_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<PaymentMethodVO>(BOX_NAME_PAYMENT_METHOD_VO);
  await Hive.openBox<ActorListVO>(BOX_NAME_ACTOR_LIST_VO);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Montserrat'),
          home: Selector<MyAppBloc, ProfileVO?>(
            selector: (context, bloc) => bloc.userProfile,
            builder: (context, value, child) {
              if (value?.token != null) {
                return const HomePage();
              } else {
                return const WelcomePage();
              }
            },
          )),
    );
  }
}
