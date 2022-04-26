import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/card_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/persistence/daos/profile_dao.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class ProfileDaoImpl extends ProfileDao{
  static final ProfileDaoImpl _singleton = ProfileDaoImpl._internal();

  factory ProfileDaoImpl() {
    return _singleton;
  }

  ProfileDaoImpl._internal();

  @override
  void saveProfile(ProfileVO profile)async{
    await getProfileBox().put(profile.id, profile);
  }

  @override
  ProfileVO getProfile(){
    if(getProfileBox().length > 0){
      return getProfileBox().getAt(0) ?? ProfileVO();
    }else{
      return ProfileVO();
    }
  }

  @override
  void deleteProfile(ProfileVO profile) async{
    await getProfileBox().delete(profile.id);
  }

  @override
  void deleteAllProfile()async{
    await getProfileBox().clear();
  }
  
  @override
  void updateCardList(List<CardVO> cardList, int profileId)async{
  ProfileVO tempProfle = getProfileBox().get(profileId) ?? ProfileVO();
  if(tempProfle.cards != null){
    tempProfle.cards = cardList;
  }
  await getProfileBox().put(profileId, tempProfle);
  }

  //Reactive Programming
  @override
  Stream<void> getProfileEventStream(){
    return getProfileBox().watch();
  }

  @override
  Stream<ProfileVO> getProfileStream(){
    return Stream.value(getProfile());
  }

  Box<ProfileVO> getProfileBox(){
    return Hive.box<ProfileVO>(BOX_NAME_PROFILE_VO);
  }
}
