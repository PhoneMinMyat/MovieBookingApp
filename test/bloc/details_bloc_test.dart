import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/details_bloc.dart';

import '../data/models/the_movie_db_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  DetailsBloc? detailsBloc;
  group('Details Bloc Test', (){
    setUp((){
      detailsBloc = DetailsBloc(2, TheMovieDbModelImplMock());
    });

    test('fetch movie details', (){
      expect(detailsBloc?.movie, getMockMovieListForTest()?.first);
    });

    test('fetch actorlist', (){
      expect(detailsBloc?.actorList, getMockActors());
    });
    //
  });
}