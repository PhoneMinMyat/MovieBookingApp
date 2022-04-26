import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

abstract class ProfileDao {
  

  void saveProfile(ProfileVO profile);

  ProfileVO getProfile();

  void deleteProfile(ProfileVO profile);

  void deleteAllProfile();
  
  void updateCardList(List<CardVO> cardList, int profileId);

  //Reactive Programming
  Stream<void> getProfileEventStream();

  Stream<ProfileVO> getProfileStream();

 
}
