import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/data/models/the_movie_db_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';

import '../../mock_data/mock_data.dart';
import '../../network/the_movie_db_data_agent_mock.dart';
import '../../persistence/actor_dao_impl_mock.dart';
import '../../persistence/genre_dao_impl_mock.dart';
import '../../persistence/movie_dao_impl_mock.dart';

void main() {
  group('The Movie DB model Impl', () {
    var movieDbModel = TheMovieDbModelImpl();

    setUp(() {
      movieDbModel.setDaosAndDataAgents(MovieDaoImplMock(), ActorDaoImplMock(),
          GenreDaoImplMock(), TheMovieDbDataAgentMock());
    });

    test('Save Now Playing Movies and Get Now Playing Movies From Test', () {
      expect(
          movieDbModel.getNowPlayingMoviesFromDatabase(),
          emits([
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
            )
          ]));
    });

    test('Save UpComing Movies and Get UpComing Movies From Database', () {
      expect(
          movieDbModel.getUpcomingMoviesFromDatabase(),
          emits(getMockMovieListForTest()
              ?.where((element) => element.isUpcoming ?? false)));
    });

    test('Get Genres', () {
      expect(
        movieDbModel.getGenres(),
        completion(
          equals(
            getMockGenres(),
          ),
        ),
      );
    });


     test('Get Genres From Database', () {
      expect(
        movieDbModel.getGenresFromDatabase(),
        completion(
          equals(
            getMockGenres(),
          ),
        ),
      );
    });

    test('Save Credits By Movie and Get From Database', () {
      expect(movieDbModel.getCreditsByMovieFromDatabase(0),
          emits(getMockActors()));
    });

    test('Save Movie Details and Get From Database', () {
      expect(movieDbModel.getMovieDetailsFromDatabase(0),
          emits(getMockMovieListForTest()?.first));
    });
    //
  });
}
