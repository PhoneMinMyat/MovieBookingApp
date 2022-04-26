import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/home_bloc.dart';

import '../data/models/the_movie_db_model_impl_mock.dart';
import '../data/models/tmba_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  HomeBloc? homeBloc;
  group('HomeBlocTest', () {
    setUp(() {
      homeBloc = HomeBloc(TheMovieDbModelImplMock(), TmbaModelImplMock());
    });

    test('Fetch Profile', (){
      expect(homeBloc?.profile, getMockProfile());
    });

    test('fetch now playing movies test', () {
      expect(
          homeBloc?.nowPlayingMovieList
              ?.contains(getMockMovieListForTest()?.first),
          true);
    });

     test('fetch upcoming movies test', () {
      expect(
          homeBloc?.upcomingMovieList
              ?.contains(getMockMovieListForTest()?.last),
          true);
    });
    //
  });
}
