import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/persistence/daos/genre_dao.dart';

import '../mock_data/mock_data.dart';

class GenreDaoImplMock extends GenreDao {
  Map<int, GenreVO> genreListFromDatabaseMock = {};

  @override
  List<GenreVO> getAllGenres() {
    return getMockGenres() ?? [];
  }

  @override
  void saveAllGenres(List<GenreVO> genreList) {
    genreList.forEach((element) {
      genreListFromDatabaseMock[element.id ?? 0] = element;
    });
  }

  @override
  String searchGenreById(int genreId) {
  return getMockGenres()?.first.name ?? '';
  }
}
