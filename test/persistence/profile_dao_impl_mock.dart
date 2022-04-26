import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/persistence/daos/profile_dao.dart';

import '../mock_data/mock_data.dart';

class ProfileDaoImplMock extends ProfileDao {
  Map<int, ProfileVO> profileFromDatabaseMock = {};
  @override
  void deleteAllProfile() {
    profileFromDatabaseMock.clear();
  }

  @override
  void deleteProfile(ProfileVO profile) {
    profileFromDatabaseMock.removeWhere((key, value) => key == profile.id);
  }

  @override
  ProfileVO getProfile() {
    return getMockProfile() ?? ProfileVO();
  }

  @override
  Stream<void> getProfileEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<ProfileVO> getProfileStream() {
    return Stream.value(getMockProfile() ?? ProfileVO());
  }

  @override
  void saveProfile(ProfileVO profile) {
    profileFromDatabaseMock[profile.id ?? 0] = profile;
  }

  @override
  void updateCardList(List<CardVO> cardList, int profileId) {
    profileFromDatabaseMock[profileId]?.cards = cardList;
  }
}
