import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class ProfileDao {
  static final ProfileDao _singleton = ProfileDao._internal();

  factory ProfileDao() {
    return _singleton;
  }

  ProfileDao._internal();

  void saveProfile(ProfileVO profile)async{
    await getProfileBox().put(profile.id, profile);
  }

  ProfileVO getProfile(){
    if(getProfileBox().length > 0){
      return getProfileBox().getAt(0) ?? ProfileVO();
    }else{
      return ProfileVO();
    }
  }

  void deleteProfile(ProfileVO profile) async{
    await getProfileBox().delete(profile.id);
  }

  void deleteAllProfile()async{
    await getProfileBox().clear();
  }
  
  void updateCardList(List<CardVO> cardList, int profileId)async{
  ProfileVO tempProfle = getProfileBox().get(profileId) ?? ProfileVO();
  if(tempProfle.cards != null){
    tempProfle.cards = cardList;
  }
  await getProfileBox().put(profileId, tempProfle);
  }

  //Reactive Programming
  Stream<void> getProfileEventStream(){
    return getProfileBox().watch();
  }

  Stream<ProfileVO> getProfileStream(){
    return Stream.value(getProfile());
  }

  Box<ProfileVO> getProfileBox(){
    return Hive.box<ProfileVO>(BOX_NAME_PROFILE_VO);
  }
}
