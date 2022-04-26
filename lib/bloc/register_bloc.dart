import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';

class RegisterBloc extends ChangeNotifier {
  //Variables
  bool isDispose = false;

  //State Variable
  ProfileVO? profile;
  bool? isSignIn;


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //Modal
   TmbaModel _model = TmbaModelImpl();

  //Variable
  String googleToken = '';
  String facebookToken = '';

  RegisterBloc([TmbaModel? tmbaModel]) {
    if(tmbaModel != null){
      _model = tmbaModel;
    }
    isSignIn = false;
  }

  void tapTabBar() {
    if (isSignIn != null) {
      isSignIn = !isSignIn!;
      safeNotifyListeners();
    }
  }

  Future<bool> registerUser(
      String name, String email, String phoneNumber, String password) async {
    bool success = false;
  await  _model
        .postRegisterData(
            name, email, phoneNumber, password, googleToken, facebookToken)
        .then((profileRes) {
      profile = profileRes;
      safeNotifyListeners();
      success = true;
    }).catchError((error) {
      print(error);
    });
    return Future.value(success);
  }

  Future<bool> loginWithEmail(String email, String password) async {
    bool success = false;
   await _model.postLogInWithGmail(email, password).then((profileRes) {
      profile = profileRes;
      safeNotifyListeners();
      success = true;
    }).catchError((error) {
      print(error);
    });
    return Future.value(success);
  }

  void signInWithGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    _googleSignIn.signIn().then((googleAccount) {
      googleToken = googleAccount?.id ?? '';
      print('Google Token ===> $googleToken');
      emailController.text = googleAccount?.email ?? '';
      nameController.text = googleAccount?.displayName ?? '';
      safeNotifyListeners();
    });
  }

  Future<bool> logInWithGoogle() async {
    bool success = false;
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    await _googleSignIn.signIn().then((googleAccount) async{
      googleToken = googleAccount?.id ?? '';
      print('Google Token ====> $googleToken');
      if (googleToken != '') {
      await  _model.postLogInWithGoogle(googleToken).then((profileResponse) {
          profile = profileResponse;
          if (profile?.token != null) {
            success = true;
          }
        }).catchError((error) => print(error));
      }
    });
    return Future.value(success);
  }

  void registerWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken = result.accessToken;
      facebookToken = accessToken?.userId ?? '';
      final userData = await FacebookAuth.instance.getUserData();
      nameController.text = userData['name'].toString();
      emailController.text = userData['email'].toString();
      safeNotifyListeners();
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future<bool> loginWithFacebook() async {
    bool success = false;
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken = result.accessToken;
      facebookToken = accessToken?.userId ?? '';
      if (facebookToken != '') {
      await  _model.postLogInWithFacebook(facebookToken).then((profileResponse) {
          profile = profileResponse;
          if (profile?.token != null) {
            success = true;
          }
        }).catchError((error) => print(error));
      }
    } else {
      print(result.status);
      print(result.message);
    }
    return Future.value(success);
  }

   void safeNotifyListeners(){
    if(isDispose == false){
      notifyListeners();
    }
  }

  void makeDispose(){
    if(isDispose == false){
      isDispose = true;
    }
  }
}
