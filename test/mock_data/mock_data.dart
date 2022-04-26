import 'package:movie_booking_app/data/vos/actor_vo.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_list_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/timeslots_vo.dart';
import 'package:movie_booking_app/network/responses/get_log_in_response.dart';
import 'package:movie_booking_app/utils/constraints.dart';

List<MovieVO>? getMockMovieListForTest() {
  return [
    MovieVO(
      adult: false,
      backdropPath: ' /cTTggc927lEPCMsWUsdugSj6wAY.jpg',
      genreIds: [28, 12],
      id: 335787,
      originalLanguage: 'en',
      originalTitle: 'Uncharted',
      overview:
          ' A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother.',
      popularity: 677.833,
      posterPath: '/sqLowacltbZLoCa4KYye64RvvdQ.jpg',
      releaseDate: '2022-02-10',
      title: 'Uncharted',
      video: false,
      voteAverage: 7.1,
      voteCount: 903,
      belongsToCollection: null,
      budget: null,
      genres: null,
      homepage: null,
      imdbId: null,
      productionCompanies: null,
      productionCountries: null,
      revenue: null,
      runtime: null,
      spokenLanguage: null,
      status: null,
      tagLine: null,
      isNowPlaying: true,
      isUpcoming: false,
    ),
    MovieVO(
      adult: false,
      backdropPath: ' /cTTggc927lEPCMsWUsdugSj6wAY.jpg',
      genreIds: [28, 12],
      id: 335787,
      originalLanguage: 'en',
      originalTitle: 'The Longest Day',
      overview: 'World War II movie based on Normandy Landing',
      popularity: 677.833,
      posterPath: '/sqLowacltbZLoCa4KYye64RvvdQ.jpg',
      releaseDate: '1952-02-10',
      title: 'The Longest Day',
      video: false,
      voteAverage: 7.1,
      voteCount: 903,
      belongsToCollection: null,
      budget: null,
      genres: null,
      homepage: null,
      imdbId: null,
      productionCompanies: null,
      productionCountries: null,
      revenue: null,
      runtime: null,
      spokenLanguage: null,
      status: null,
      tagLine: null,
      isNowPlaying: false,
      isUpcoming: true,
    ),
  ];
}

List<ActorVO>? getMockActors() {
  return [
    ActorVO(
        adult: false,
        gender: 2,
        id: 1136406,
        knownFor: null,
        knownForDepartment: 'Acting',
        name: 'Tom Holland',
        popularity: 108.741,
        profilePath: ' /bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg',
        originalName: ' Tom Holland',
        castId: 9,
        character: 'Nathan Drake',
        creditId: '59233009c3a3683f52001537',
        order: 0),
    ActorVO(
        adult: false,
        gender: 2,
        id: 13240,
        knownFor: null,
        knownForDepartment: 'Acting',
        name: 'Mark Wahlberg',
        popularity: 36.92,
        profilePath: ' /bTEFpaWd7A6AZVWOqKKBWzKEUe8.jpg',
        originalName: 'Mark Wahlberg',
        castId: 15,
        character: ' Victor \'Sully\' Sullivan',
        creditId: '5dcca609b76cbb0011735eae',
        order: 1),
    ActorVO(
        adult: false,
        gender: 2,
        id: 3131,
        knownFor: null,
        knownForDepartment: 'Acting',
        name: ' Antonio Banderas',
        popularity: 24.828,
        profilePath: '/uqqgAdPfi1TmG3tfKfhsf20fHE6.jpg',
        originalName: 'Antonio Banderas',
        castId: 27,
        character: 'Santiago Moncada',
        creditId: '5e5d5bf566ae4d001289a72f',
        order: 2),
  ];
}

List<GenreVO>? getMockGenres() {
  return [
    GenreVO(id: 1, name: 'Action'),
    GenreVO(id: 2, name: 'Adventure'),
    GenreVO(id: 3, name: 'Comedy'),
  ];
}

ProfileVO? getMockProfile() {
  return ProfileVO(
      id: 1,
      name: 'John',
      email: 'John1999@gmail.com',
      phone: '+9594141646416',
      profileImage: null,
      totalExpense: null,
      token: 'adfa64434dasf6416das4f1',
      cards: [
        CardVO(
            id: 1,
            cardHolder: 'John',
            cardNumber: '64649674964961',
            cardType: 'JCB',
            expirationDate: '08/22'),
        CardVO(
            id: 2,
            cardHolder: 'Test',
            cardNumber: '568615419484',
            cardType: 'JCB',
            expirationDate: '08/22'),
        CardVO(
            id: 3,
            cardHolder: 'Test Two',
            cardNumber: '154964143161',
            cardType: 'JCB',
            expirationDate: '08/22'),
      ]);
}

List<CinemaVO>? getMockCinemaVOList() {
  return [
    CinemaVO(cinema: 'Cinema I', cinemaId: 1, timeslots: [
      TimeslotsVO(cinemaDayTimeSlotId: 1, startTime: '10:00 AM'),
      TimeslotsVO(cinemaDayTimeSlotId: 2, startTime: '12:00 PM'),
      TimeslotsVO(cinemaDayTimeSlotId: 3, startTime: '1:00 PM')
    ]),
    CinemaVO(cinema: 'Cinema II', cinemaId: 2, timeslots: [
      TimeslotsVO(cinemaDayTimeSlotId: 4, startTime: '10:00 AM'),
      TimeslotsVO(cinemaDayTimeSlotId: 5, startTime: '12:00 PM'),
      TimeslotsVO(cinemaDayTimeSlotId: 6, startTime: '1:00 PM')
    ]),
    CinemaVO(cinema: 'Cinema III', cinemaId: 3, timeslots: [
      TimeslotsVO(cinemaDayTimeSlotId: 7, startTime: '10:00 AM'),
      TimeslotsVO(cinemaDayTimeSlotId: 8, startTime: '12:00 PM'),
      TimeslotsVO(cinemaDayTimeSlotId: 9, startTime: '1:00 PM')
    ])
  ];
}

CinemaListVO? getMockCinemaListVO() {
  return CinemaListVO(cinemaList: [
    CinemaVO(cinema: 'Cinema I', cinemaId: 1, timeslots: [
      TimeslotsVO(cinemaDayTimeSlotId: 1, startTime: '10:00 AM'),
      TimeslotsVO(cinemaDayTimeSlotId: 2, startTime: '12:00 PM'),
      TimeslotsVO(cinemaDayTimeSlotId: 3, startTime: '1:00 PM')
    ]),
    CinemaVO(cinema: 'Cinema II', cinemaId: 2, timeslots: [
      TimeslotsVO(cinemaDayTimeSlotId: 4, startTime: '10:00 AM'),
      TimeslotsVO(cinemaDayTimeSlotId: 5, startTime: '12:00 PM'),
      TimeslotsVO(cinemaDayTimeSlotId: 6, startTime: '1:00 PM')
    ]),
    CinemaVO(cinema: 'Cinema III', cinemaId: 3, timeslots: [
      TimeslotsVO(cinemaDayTimeSlotId: 7, startTime: '10:00 AM'),
      TimeslotsVO(cinemaDayTimeSlotId: 8, startTime: '12:00 PM'),
      TimeslotsVO(cinemaDayTimeSlotId: 9, startTime: '1:00 PM')
    ])
  ]);
}

List<List<MovieSeatVO>>? getMockMovieSeatList() {
  return [
    [
      MovieSeatVO(
          id: 1,
          seatName: 'A1',
          symbol: 'A',
          type: SEAT_TYPE_AVAILABLE,
          price: 6.0,
          isSelected: false),
      MovieSeatVO(
          id: 2,
          seatName: 'A2',
          symbol: 'A',
          type: SEAT_TYPE_AVAILABLE,
          price: 6.0,
          isSelected: false),
      MovieSeatVO(
          id: 3,
          seatName: 'A3',
          symbol: 'A',
          type: SEAT_TYPE_AVAILABLE,
          price: 6.0,
          isSelected: false)
    ],
    [
      MovieSeatVO(
          id: 4,
          seatName: 'B1',
          symbol: 'B',
          type: SEAT_TYPE_AVAILABLE,
          price: 6.0,
          isSelected: false),
      MovieSeatVO(
          id: 5,
          seatName: 'B2',
          symbol: 'B',
          type: SEAT_TYPE_AVAILABLE,
          price: 6.0,
          isSelected: false),
      MovieSeatVO(
          id: 6,
          seatName: 'B3',
          symbol: 'B',
          type: SEAT_TYPE_AVAILABLE,
          price: 6.0,
          isSelected: false)
    ]
  ];
}

List<PaymentMethodVO> getMockPaymentMethodList() {
  return [
    PaymentMethodVO(id: 1, name: 'Credit Card', description: 'VISA, JCB'),
    PaymentMethodVO(id: 2, name: 'Mobile Banking', description: 'VISA, JCB'),
    PaymentMethodVO(id: 3, name: 'E-Wallet', description: 'VISA, JCB'),
  ];
}

List<SnackVO> getMockSnackList() {
  return [
    SnackVO(
        id: 1,
        name: 'Popcorns',
        description: 'Snack Description',
        image: null,
        price: 2,
        quantity: 0),
    SnackVO(
        id: 2,
        name: 'Smoothies',
        description: 'Snack Description',
        image: null,
        price: 3,
        quantity: 0),
    SnackVO(
        id: 3,
        name: 'Carrots',
        description: 'Snack Description',
        image: null,
        price: 4,
        quantity: 0),
  ];
}

CheckoutVO getMockCheckOut() {
  return CheckoutVO(
      id: 721,
      bookingNo: 'Cinema II-3698-5814',
      bookingDate: '2022-04-25',
      row: 'F',
      seat: 'F-5,F-6',
      totalSeat: 2,
      total: '\$17',
      movieId: 294793,
      cinemaId: 2,
      username: 'Pmm',
      timeslot: TimeslotsVO(cinemaDayTimeSlotId: 6, startTime: '1:00 PM'),
      snacks: [
        SnackVO(
            id: 1446,
            name: 'Smoothies',
            description: ' Voluptatum consequatur aut molestiae soluta nulla.',
            price: 3.0,
            image: '/img/snack.jpg',
            quantity: 1)
      ]);
}

List<CardVO> getMockCardList() {
  return [
    CardVO(
        id: 1,
        cardHolder: 'John',
        cardNumber: '64649674964961',
        cardType: 'JCB',
        expirationDate: '08/22'),
    CardVO(
        id: 2,
        cardHolder: 'Test',
        cardNumber: '568615419484',
        cardType: 'JCB',
        expirationDate: '08/22'),
    CardVO(
        id: 3,
        cardHolder: 'Test Two',
        cardNumber: '154964143161',
        cardType: 'JCB',
        expirationDate: '08/22'),
  ];
}

GetLogInResponse getMockGetLogInResponse() {
  return GetLogInResponse(
      code: 200,
      data: ProfileVO(
          id: 1,
          name: 'John',
          email: 'John1999@gmail.com',
          phone: '+9594141646416',
          profileImage: null,
          totalExpense: null,
          token: 'adfa64434dasf6416das4f1',
          cards: [
            CardVO(
                id: 1,
                cardHolder: 'John',
                cardNumber: '64649674964961',
                cardType: 'JCB',
                expirationDate: '08/22'),
            CardVO(
                id: 2,
                cardHolder: 'Test',
                cardNumber: '568615419484',
                cardType: 'JCB',
                expirationDate: '08/22'),
            CardVO(
                id: 3,
                cardHolder: 'Test Two',
                cardNumber: '154964143161',
                cardType: 'JCB',
                expirationDate: '08/22'),
          ]),
      message: 'Success',
      token: 'adfa64434dasf6416das4f1');
}
