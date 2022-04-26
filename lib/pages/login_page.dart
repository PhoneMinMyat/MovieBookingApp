import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking_app/bloc/register_bloc.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/network/responses/error_response.dart';
import 'package:movie_booking_app/pages/home_page.dart';

import 'package:movie_booking_app/resources/color.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/widget_keys.dart';
import 'package:movie_booking_app/widgets/long_button.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //Variable
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  //State Variable
  ProfileVO? profile;
  RegisterBloc registerBloc = RegisterBloc();

  @override
  void dispose() {
    registerBloc.makeDispose();
    super.dispose();
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (Route<dynamic> route) => false);
  }

  void registerUser(BuildContext context, TextEditingController nameController,
      TextEditingController emailController) {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text == confirmPasswordController.text) {
        registerBloc
            .registerUser(
          nameController.text,
          emailController.text,
          phoneNumberController.text,
          passwordController.text,
        )
            .then((success) {
          navigateToHomePage(context);
        }).catchError((error) {
          print(error);
        });
      } else {
        handleError(context, 'Passsword and Confirm Passoword must be same');
      }
    } else {
      handleError(context, 'Please Fill All Fields');
    }
  }

  void loginWithEmail(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
  ) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      registerBloc
          .loginWithEmail(emailController.text, passwordController.text)
          .then((success) {
        navigateToHomePage(context);
      }).catchError((error) {
        print(error);
      });
    } else {
      handleError(context, 'Please Fill All Fields');
    }
  }

  void handleError(BuildContext context, dynamic error) {
    if (error is DioError) {
      try {
        ErrorResponse errorResponse =
            ErrorResponse.fromJson(error.response?.data);
        showErrorAlert(context, errorResponse.message ?? '');
      } on Error catch (_) {
        showErrorAlert(context, error.toString());
      }
    } else {
      showErrorAlert(context, error.toString());
    }
  }

  void showErrorAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error!!!'),
        content: SingleChildScrollView(child: Text(message)),
      ),
    );
  }

  void signInwithGoogle() {
    registerBloc.signInWithGoogle();
  }

  void loginWithGoogle(BuildContext context) {
    registerBloc.logInWithGoogle().then((success) {
      navigateToHomePage(context);
    }).catchError((error) => print(error));
  }

  void registerWithFacebook() async {
    registerBloc.registerWithFacebook();
  }

  void loginWIthFacebook(BuildContext context) async {
    registerBloc.loginWithFacebook().then((success) {
      navigateToHomePage(context);
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => registerBloc,
      child: Scaffold(
        body: Selector<RegisterBloc, TextEditingController>(
          selector: (context, bloc) => bloc.nameController,
          builder: (context, nameController, child) =>
              Selector<RegisterBloc, TextEditingController>(
            selector: (context, bloc) => bloc.emailController,
            builder: (context, emailController, child) => SingleChildScrollView(
              key: const Key(KEY_REGISTER_SCROLL_VIEW),
              child: Container(
                padding: const EdgeInsets.all(MARGIN_MEDIUM_2x),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: MARGIN_XXLARGE + MARGIN_XXLARGE),
                    const WelcomeHeaderTextSection(),
                    const SizedBox(height: MARGIN_XLARGE),
                    Selector<RegisterBloc, bool?>(
                      selector: (context, bloc) => bloc.isSignIn,
                      builder: (context, isSignIn, child) =>
                          UserInputSectionView(
                        isSignIn: isSignIn ?? false,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        nameController: nameController,
                        phoneNumberController: phoneNumberController,
                        tapTabBar: () {
                          RegisterBloc bloc =
                              Provider.of<RegisterBloc>(context, listen: false);
                          bloc.tapTabBar();
                        },
                      ),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM_2x),
                    Selector<RegisterBloc, bool?>(
                      selector: (context, bloc) => bloc.isSignIn,
                      builder: (context, isSignIn, child) =>
                          ButtonGroupSectionView(
                        () {
                          RegisterBloc bloc =
                              Provider.of<RegisterBloc>(context, listen: false);
                          (isSignIn ?? false)
                              ? registerUser(context, nameController,
                                  emailController)
                              : loginWithEmail(context,  nameController,
                                  emailController);
                        },
                        () {
                          RegisterBloc bloc =
                              Provider.of<RegisterBloc>(context, listen: false);
                          (isSignIn ?? false)
                              ? signInwithGoogle()
                              : loginWithGoogle(context, );
                        },
                        () {
                          RegisterBloc bloc =
                              Provider.of<RegisterBloc>(context, listen: false);
                          (isSignIn ?? false)
                              ? registerWithFacebook()
                              : loginWIthFacebook(context, );
                        },
                        isSignIn: isSignIn ?? false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserInputSectionView extends StatefulWidget {
  final bool isSignIn;
  final Function tapTabBar;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;

  const UserInputSectionView({
    required this.isSignIn,
    required this.tapTabBar,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.phoneNumberController,
    Key? key,
  }) : super(key: key);

  @override
  State<UserInputSectionView> createState() => _UserInputSectionViewState();
}

class _UserInputSectionViewState extends State<UserInputSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBarSectionView(() {
          widget.tapTabBar();
        }),
        const SizedBox(height: MARGIN_XLARGE),
        TextFieldSectionView(
          isSignIn: widget.isSignIn,
          emailController: widget.emailController,
          passwordController: widget.passwordController,
          confirmPasswordController: widget.confirmPasswordController,
          nameController: widget.nameController,
          phoneNumberController: widget.phoneNumberController,
        ),
        const SizedBox(height: MARGIN_LARGE),
      ],
    );
  }
}

class TextFieldSectionView extends StatelessWidget {
  final bool isSignIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;

  const TextFieldSectionView({
    Key? key,
    required this.isSignIn,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.phoneNumberController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFieldWithLabelText(
          labelText: LOGIN_PAGE_EMAIL_TEXTFIELD_HINT,
          controller: emailController,
          key: const Key(KEY_EMAIL_TEXT_FIELD),
        ),
        TextFieldWithLabelText(
          labelText: LOGIN_PAGE_PASSWORD_TEXTFIELD_HINT,
          isPassword: true,
          controller: passwordController,
          key: const Key(KEY_PASSWORD_TEXT_FIELD),
        ),
        TextFieldWithLabelText(
          labelText: LOGIN_PAGE_CONFIRM_PASSWORD_TEXTFIELD_HINT,
          isPassword: true,
          visibility: isSignIn,
          controller: confirmPasswordController,
        ),
        TextFieldWithLabelText(
          labelText: LOGIN_PAGE_NAME_TEXTFIELD_HINT,
          visibility: isSignIn,
          controller: nameController,
        ),
        TextFieldWithLabelText(
          labelText: LOGIN_PAGE_PHONENUMBER_TEXTFIELD_HINT,
          isNumberKeyboardType: true,
          visibility: isSignIn,
          controller: phoneNumberController,
        ),
        Visibility(
          visible: !isSignIn,
          child: const Text(
            LOGIN_PAGE_FORGOT_PASSWORD,
            textAlign: TextAlign.end,
            style: TextStyle(color: SECONDARY_TEXT_COLOR),
          ),
        ),
      ],
    );
  }
}

class TextFieldWithLabelText extends StatelessWidget {
  final String labelText;
  final bool visibility;
  final bool isNumberKeyboardType;
  final bool isPassword;
  final bool isDate;
  final TextEditingController controller;
  const TextFieldWithLabelText({
    required this.labelText,
    this.visibility = true,
    this.isNumberKeyboardType = false,
    this.isPassword = false,
    this.isDate = false,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (visibility) ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: (!visibility) ? 0 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              labelText,
              style: const TextStyle(
                  fontSize: TEXT_REGULAR_2x, color: SECONDARY_TEXT_COLOR),
            ),
            TextField(
              keyboardType: (isNumberKeyboardType) ? TextInputType.phone : null,
              obscureText: isPassword,
              controller: controller,
            ),
            const SizedBox(height: MARGIN_XLARGE),
          ],
        ),
      ),
    );
  }
}

class ButtonGroupSectionView extends StatelessWidget {
  final Function onTapConfirm;
  final Function onGoogleTap;
  final Function onFacebookTap;
  final bool isSignIn;
  const ButtonGroupSectionView(
    this.onTapConfirm,
    this.onGoogleTap,
    this.onFacebookTap, {
    required this.isSignIn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onFacebookTap();
          },
          child: ButtonWithLogo(
            buttonText: (isSignIn)
                ? LOGIN_PAGE_SIGN_IN_WITH_FACEBOOK
                : LOGIN_PAGE_LOG_IN_WITH_FACEBOOK,
            imagePath: 'assets/images/facebook_logo.png',
          ),
        ),
        const SizedBox(height: MARGIN_LARGE),
        GestureDetector(
          onTap: () {
            onGoogleTap();
          },
          child: ButtonWithLogo(
            buttonText: (isSignIn)
                ? LOGIN_PAGE_SIGN_IN_WITH_GOOGLE
                : LOGIN_PAGE_LOG_IN_WITH_GOOGLE,
            imagePath: 'assets/images/google_logo.png',
          ),
        ),
        const SizedBox(height: MARGIN_LARGE),
        LongButton(
          () {
            onTapConfirm();
          },
          buttonText: CONFIRM,
          key: const Key(KEY_REGISTER_CONFIRM),
        ),
      ],
    );
  }
}

class ButtonWithLogo extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  const ButtonWithLogo({
    Key? key,
    required this.buttonText,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(
          border: Border.all(
            color: SECONDARY_TEXT_COLOR,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: MARGIN_XLARGE),
                child: Image.asset(imagePath),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: SECONDARY_TEXT_COLOR,
                  fontSize: TEXT_REGULAR_2x,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ));
  }
}

class TabBarSectionView extends StatelessWidget {
  final Function tapTabBar;
  const TabBarSectionView(
    this.tapTabBar, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: TabBar(
        indicatorColor: PRIMARY_COLOR,
        indicatorWeight: 4,
        unselectedLabelColor: Colors.black,
        labelColor: PRIMARY_COLOR,
        labelStyle: const TextStyle(
            fontSize: TEXT_REGULAR_2x, fontWeight: FontWeight.bold),
        onTap: (index) {
          tapTabBar();
        },
        tabs: const [
          Tab(
            text: LOGIN_PAGE_LOG_IN_TEXT,
          ),
          Tab(
            text: LOGIN_PAGE_SIGN_IN_TEXT,
          )
        ],
      ),
    );
  }
}

class WelcomeHeaderTextSection extends StatelessWidget {
  const WelcomeHeaderTextSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          LOGIN_PAGE_WELCOME_TITLE,
          style: TextStyle(fontSize: TEXT_BIG, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          LOGIN_PAGE_WELCOME_SUB_TITLE,
          style:
              TextStyle(fontSize: TEXT_REGULAR_2x, color: SECONDARY_TEXT_COLOR),
        )
      ],
    );
  }
}
