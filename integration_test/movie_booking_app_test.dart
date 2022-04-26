import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/collection_vo.dart';
import 'package:movie_booking_app/data/vos/country_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/production_company_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/pages/add_new_card_page.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/pages/pick_time_page.dart';
import 'package:movie_booking_app/pages/seat_page.dart';
import 'package:movie_booking_app/pages/snack_page.dart';
import 'package:movie_booking_app/pages/ticket_page.dart';
import 'package:movie_booking_app/pages/welcome_page.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';
import 'package:movie_booking_app/widget_keys.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  await Hive.openBox<ProfileVO>(BOX_NAME_PROFILE_VO);
  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<CinemaListVO>(BOX_NAME_CINEMA_LIST_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<PaymentMethodVO>(BOX_NAME_PAYMENT_METHOD_VO);

  testWidgets('User Testing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await Future.delayed(const Duration(seconds: 2));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    ///WELCOME_PAGE

    expect(find.byType(WelcomePage), findsOneWidget);

    expect(find.text(TEST_DATA_WELCOME_TEXT), findsOneWidget);

    await tester.tap(find.text(TEST_DATA_WELCOME_BUTTON));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //LogIn Page

    expect(find.byType(LogInPage), findsOneWidget);

    expect(find.text(TEST_DATA_WELCOME_TEXT), findsOneWidget);
    expect(find.text(TEST_DATA_CONFIRM_BUTTON), findsOneWidget);
    expect(find.byKey(const Key(KEY_EMAIL_TEXT_FIELD)), findsOneWidget);
    expect(find.byKey(const Key(KEY_PASSWORD_TEXT_FIELD)), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key(KEY_EMAIL_TEXT_FIELD)), TEST_DATA_EMAIL_INPUT);
    await tester.enterText(find.byKey(const Key(KEY_PASSWORD_TEXT_FIELD)),
        TEST_DATA_PASSWORD_INPUT);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.dragUntilVisible(find.byKey(const Key(KEY_REGISTER_CONFIRM)),
        find.byKey(const Key(KEY_REGISTER_SCROLL_VIEW)), const Offset(0, 300));

    await tester.tap(find.byKey(const Key(KEY_REGISTER_CONFIRM)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //Home Page

    expect(find.byType(HomePage), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_COMING_SOON), findsOneWidget);
    expect(find.text(TEST_DATA_NOW_SHOWING), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);

    await tester.tap(find.text(TEST_DATA_MOVIE_NAME));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //MovieDetailPage

    expect(find.byType(MovieDetailPage), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_PLOT_SUMMARY), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_TIME), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_RATING), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_CAST), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_CHIP), findsOneWidget);
    expect(find.byKey(const Key(KEY_DETAILS_CONFIRM)), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_DETAILS_CONFIRM)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //PickTime Page
    expect(find.byType(PickTimePage), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byKey(const Key(KEY_SELECT_DATE_SCROLL_VIEW)), findsOneWidget);
    expect(find.byKey(const Key(KEY_PICK_TIME_CONFIRM)), findsOneWidget);
    expect(find.byKey(const Key(KEY_CINEMA_ITEM + '1')), findsOneWidget);
    expect(find.byKey(const Key(TEST_DATA_TIME_SLOT_PICK_KEY)), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_SELECT_DATE_ITEM_KEYS + '2')));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key(TEST_DATA_TIME_SLOT_PICK_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key(KEY_PICK_TIME_CONFIRM)));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    //Seat Page
    expect(find.byType(SeatPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);
    expect(find.byKey(const Key(KEY_SEAT_PAGE_SCROLLVIEW)), findsOneWidget);
    expect(find.byKey(const Key(KEY_SEAT_STATE_COLOR)), findsOneWidget);

    await tester.dragUntilVisible(find.byKey(const Key(KEY_SEAT_CONFIRM)),
        find.byKey(const Key(KEY_SEAT_PAGE_SCROLLVIEW)), const Offset(0, 300));

    expect(find.byKey(const Key(KEY_SEAT_CONFIRM)), findsOneWidget);
    expect(find.text(TEST_DATA_SEATS), findsOneWidget);
    expect(find.text(TEST_DATA_TICKETS), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_SEAT_ITEM + '64')));
    await tester.tap(find.byKey(const Key(KEY_SEAT_ITEM + '65')));
    await tester.tap(find.byKey(const Key(KEY_SEAT_ITEM + '66')));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_SEAT_ITEM + '66')));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_SEAT_CONFIRM)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //Snack Page
    expect(find.byType(SnackPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_SNACK_POPCORN), findsOneWidget);
    expect(find.text(TEST_DATA_SNACK_SMOOTHIES), findsOneWidget);
    expect(find.text(TEST_DATA_SNACK_CARROTS), findsOneWidget);
    expect(find.text(TEST_DATA_PAYMENT_METHOD), findsOneWidget);
    expect(find.text(TEST_DATA_CREDIT_CARD), findsOneWidget);
    expect(find.text(TEST_DATA_INTERNET_BANKING), findsOneWidget);
    expect(find.text(TEST_DATA_E_WALLET), findsOneWidget);
    expect(find.text(TEST_DATA_SUB_TOTAL_START), findsOneWidget);
    expect(find.byKey(const Key(KEY_SNACK_CONFIRM)), findsOneWidget);

    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_POPCORN + KEY_SNACK_INCREASE)));

    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_SMOOTHIES + KEY_SNACK_INCREASE)));
    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_SMOOTHIES + KEY_SNACK_INCREASE)));

    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_CARROTS + KEY_SNACK_INCREASE)));
    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_CARROTS + KEY_SNACK_INCREASE)));
    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_CARROTS + KEY_SNACK_INCREASE)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('3'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text(TEST_DATA_SUB_TOTAL_AFTER_INCREASE), findsOneWidget);

    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_POPCORN + KEY_SNACK_DECREASE)));

    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_SMOOTHIES + KEY_SNACK_DECREASE)));

    await tester.tap(
        find.byKey(const Key(TEST_DATA_SNACK_CARROTS + KEY_SNACK_DECREASE)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text(TEST_DATA_SUB_TOTAL_AFTER_DECREASE), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_SNACK_CONFIRM)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //Payment Page
    expect(find.byType(PaymentPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_PAYMENT_AMOUNT), findsOneWidget);
    expect(find.byKey(const Key(KEY_ADD_NEW_CARD_BUTTON)), findsOneWidget);
    expect(find.byKey(const Key(KEY_PAYMENT_CONFIRM)), findsOneWidget);
    expect(find.byKey(const Key(KEY_CARD_LIST)), findsOneWidget);
    expect(find.text(TEST_DATA_ADD_NEW_CARD), findsOneWidget);

    await tester.tap(find.text(TEST_DATA_ADD_NEW_CARD));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //Add new card page
    expect(find.byType(AddNewCardPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byKey(const Key(KEY_CARD_NUMBER_FIELD)), findsOneWidget);
    expect(find.byKey(const Key(KEY_CARD_HOLDER_FIELD)), findsOneWidget);
    expect(
        find.byKey(const Key(KEY_CARD_EXPIRATIONG_DATE_FIELD)), findsOneWidget);
    expect(find.byKey(const Key(KEY_CARD_CVC_FIELD)), findsOneWidget);
    expect(find.byKey(const Key(KEY_ADD_NEW_CARD_CONFIRM)), findsOneWidget);

    await tester.enterText(find.byKey(const Key(KEY_CARD_NUMBER_FIELD)),
        TEST_DATA_CARD_NUMBER_INPUT);
    await tester.enterText(find.byKey(const Key(KEY_CARD_HOLDER_FIELD)),
        TEST_DATA_CARD_HOLDER_INPUT);
    await tester.enterText(
        find.byKey(const Key(KEY_CARD_EXPIRATIONG_DATE_FIELD)),
        TEST_DATA_CARD_EXPIRATION_DATE_INPUT);
    await tester.enterText(
        find.byKey(const Key(KEY_CARD_CVC_FIELD)), TEST_DATA_CVC_INPUT);

    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key(KEY_ADD_NEW_CARD_CONFIRM)));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    //Return Payment Page
    expect(find.byType(PaymentPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(TEST_DATA_TEXT_ON_CARD), findsOneWidget);
    expect(find.text(TEST_DATA_CARD_HOLDER_INPUT), findsOneWidget);
    expect(find.byKey(const Key(KEY_PAYMENT_CONFIRM)), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_PAYMENT_CONFIRM)));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(TicketPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byKey(const Key(KEY_TICKET_PAGE_EXIT)), findsOneWidget);
    expect(find.text(TEST_DATA_AWESOME), findsOneWidget);
    expect(find.text(TEST_DATA_THIS_IS_YOUR_TICKET), findsOneWidget);
    expect(find.text(TEST_DATA_BOOKING_NO_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_SHOWTIME_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_THEATER_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_SCREEN_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_ROW_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_SEATS_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_PRICE_TITLE), findsOneWidget);
    expect(find.text(TEST_DATA_PRICE_TEXT), findsOneWidget);

    await tester.tap(find.byKey(const Key(KEY_TICKET_PAGE_EXIT)));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}
