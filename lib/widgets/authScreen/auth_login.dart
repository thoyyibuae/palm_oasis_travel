// import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:tutvideo/constants/asset_paths.dart';
import 'package:tutvideo/screens/bottom_nav.dart';

import '../../theme/basic_colors.dart';

class AuthLogin extends StatefulWidget {
  /// to pop the authscreen instead of pushing new nav screen
  final bool pop;
  static const routeName = '/auth';

  const AuthLogin({
    Key? key,
    required this.pop,
  }) : super(key: key);

  @override
  _AuthLoginState createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  // User user;
  String? _number;
  Future<String> _loginUser(LoginData data) async {
    // var random = new Random();

    try {
      // user = await Database(context: context).login(User(
      //     password: data.password,
      //     deviceType: Responsive.isDesktop(context) ? 1 : 2,
      //     email: _number != null ? _number : data.name,
      //     fcm: Hive.box('token')?.get('token') ?? "null",
      //     gender: 1,
      //     language: context.locale.toString() == 'en' ? 1 : 2,
      //     mobile: data.name,
      //     status: 1,
      //     userType: 1,
      //     userName: data.name));
      // if (user != null) {
      //   print('userTypId');
      //   print(user.userType);
      // }
      return "";
    } catch (e) {
      return e.toString();
      // return null;
    }
  }

  Future<String> _registerUser(SignupData data, String phone) async {
    // var random = new Random();
    //  print(random.nextInt(10000));
    try {
      // user = await Database(context: context).createUser(User(
      //   fullname: _number != null ? phone : data.name,
      //   password: data.password,
      //   deviceType: Responsive.isDesktop(context) ? 1 : 2,
      //   email: _number != null ? '$phone@m.com' : data.name,
      //   fcm: Hive.box('token')?.get('token') ?? "null",
      //   gender: 1,
      //   language: context.locale.toString() == 'en' ? 1 : 2,
      //   mobile: phone ?? data.name,
      //   status: 1,
      //   userType: 1,
      //   userName: _number != null ? phone : data.name,
      // ));
      return "";
    } catch (e) {
      return e.toString();
    }
    // if (!mockUsers.containsKey(data.name)) {
    //   return 'Username not exists';
    // }
    // if (mockUsers[data.name] != data.password) {
    //   return 'Password does not match';
    // }
    // return null;
    // });
  }

  Future<String> _recoverPassword(String name) async {
    return "";
    // //   Navigator.push(
    // //       context,
    // //       FadePageRoute(
    // //         builder: (context) => NewPasswordForForgotScreen(
    // //           email: name,
    // //         ),
    // //       ));
    // // // return
    // try {
    //   if (_number != null) {
    //     final phone = await Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => PhoneNumberOtpScreen(
    //             phone: _number,
    //           ),
    //         ));
    //     if (phone == null) return 'phoneNumberNotVerified'.tr();
    //     if (phone is bool //&& phone == true
    //         ) {
    //       if (widget.pop) {
    //         Navigator.pop(context);
    //       } else {
    //         Database.guestMode = true;
    //       }
    //       return null;
    //     }
    //     _number = phone;
    //     var error = await Navigator.push(
    //         context,
    //         FadePageRoute(
    //           builder: (context) => NewPasswordForForgotScreen(
    //             email: phone ?? name,
    //           ),
    //         ));
    //     if (error == null)
    //       return null;
    //     else
    //       return error;
    //   } else {
    //     String error = await Database(context: context).recoverPassword(name);
    //     if (error == null) {
    //       error = await Navigator.push(
    //           context,
    //           FadePageRoute(
    //             builder: (context) => ForgotPasswordVerificationScreen(
    //               email: name,
    //             ),
    //           ));
    //       if (error == null)
    //         return null;
    //       else
    //         return error;
    //     } else
    //       return error;
    //   }
    // } catch (e) {
    //   return e.toString();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final inputBorder = BorderRadius.vertical(
    //   bottom: Radius.circular(10.0),
    //   top: Radius.circular(20.0),
    // );

    return Scaffold(
        body:
            // Consumer<UserDatas>(
            //     builder: (context, userProvider, child) =>
            FlutterLogin(
      // key: UniqueKey(),
      // title: 'app_name'.tr()),
      title: null,
      logo: AssetPaths.logo,
      // logoTag: 'app_name'.tr()),
      // titleTag: 'app_name'.tr()),

      messages: LoginMessages(
        userHint: 'usernameHint'.tr(), //'usernameHint'.tr()),
        passwordHint: 'passwordHint'.tr(),
        confirmPasswordHint: 'confirmPasswordHint'.tr(),
        loginButton: 'loginButton'.tr(),
        signupButton: 'signupButton'.tr(),

        forgotPasswordButton: 'forgotPasswordButton'.tr(),
        recoverPasswordButton: 'helpMe'.tr(),
        goBackButton: 'goBack'.tr(),
        confirmPasswordError: 'notMatch'.tr(),
        recoverPasswordIntro: 'recoverPasswordIntro'.tr(),
        recoverPasswordDescription: 'recoverPasswordDescription'.tr(),
        recoverPasswordSuccess: 'recoverPasswordSuccess'.tr(),
      ),
      logoTag: 'logo',
      // titleTag: 'title',
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
        //  Colors.red.shade300,
        accentColor: Theme.of(context).accentColor,
        // Colors.red.shade400,
        errorColor: Theme.of(context).errorColor,
        //  Colors.deepOrange,
        pageColorLight: Theme.of(context).scaffoldBackgroundColor,
        //  Colors.white, //Colors.black87,
        pageColorDark: Colors.white, // Colors.red.shade400,

        titleStyle: TextStyle(
          color: Theme.of(context).primaryColor,

          //  Colors.red,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        // beforeHeroFontSize: 50,
        // afterHeroFontSize: 20,
        //   bodyStyle: TextStyle(
        //     fontStyle: FontStyle.italic,
        //     decoration: TextDecoration.underline,
        //   ),
        //   textFieldStyle: TextStyle(
        //     color: Colors.orange,
        //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        //   ),
        //   buttonStyle: TextStyle(
        //     fontWeight: FontWeight.w800,
        //     color: Colors.yellow,
        //   ),
        cardTheme: CardTheme(
          color: BasicColors.kScaffold,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),

        primaryColorAsInputLabel: true,
        inputTheme: InputDecorationTheme(
          filled: true,

          floatingLabelBehavior: FloatingLabelBehavior.always,

          fillColor: Theme.of(context).primaryColor.withOpacity(0.3),

          //  Colors.red.withOpacity(.3),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
              // backgroundColor: Colors.orange,
              color: Theme.of(context).errorColor
              //  Colors.red,
              ),
          labelStyle: TextStyle(fontSize: 12),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
          //   borderRadius: inputBorder,
          // ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
          //   borderRadius: inputBorder,
          // ),
          // errorBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.red.shade700, width: 7),
          //   borderRadius: inputBorder,
          // ),
          // focusedErrorBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.red.shade400, width: 8),
          //   borderRadius: inputBorder,
          // ),
          // disabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey, width: 5),
          //   borderRadius: inputBorder,
          // ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Theme.of(context).splashColor,
          //  Colors.purple,
          backgroundColor: Theme.of(context).primaryColor,
          //  Colors.red.shade300,
          highlightColor: Theme.of(context).primaryColor,
          //  Colors.red.shade500,
          elevation: 9.0,
          highlightElevation: 6.0,
          // shape: BeveledRectangleBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
      userValidator: (value) {
        String? error = FlutterLogin.defaultEmailValidator(value);
        if (value == null) error = "";
        if (error != null) {
          value!.replaceAll(' ', '');
          value.replaceAll('-', '');
          if (RegExp(r'^(?:\+971|971|00971|0)?\d{9}$').hasMatch(value)) {
            var _number = value.substring(value.length - 9, value.length);
            _number = '+971' + _number;
            print(_number);
            return null;
          }
        }
        _number = null;
        return error == null ? null : 'invalidNumberOrEmail'.tr();
      },
      //  FlutterLogin.defaultEmailValidator,
      passwordValidator: (value) {
        if (value == null || value.isEmpty || value.length <= 4) {
          return 'shortPassword'.tr();
        }
        return null;
      },
      // (value) {
      //   if (value.isEmpty) {
      //     return 'Password is empty';
      //   }
      //   return null;
      // },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (loginData) async {
        try {
          // print('Signup info');
          // print('Name: ${loginData.name}');
          // print('Password: ${loginData.password}');
          // final phone = await Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => PhoneNumberOtpScreen(
          //         phone: _number,
          //       ),
          //     ));
          // if (phone == null) return 'phoneNumberNotVerified'.tr();
          // if (phone is bool //&& phone == true
          //     ) {
          //   if (widget.pop) {
          //     Navigator.pop(context);
          //   } else {
          //     Database.guestMode = true;
          //   }
          //   return null;
          // }

          // return _registerUser(loginData, phone as String);
          return null;
        } catch (e) {
          ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
          return e.toString();
        }
      },
      onSubmitAnimationCompleted: () {
        // if (user == null) {
        //   setState(() {
        //     BasicScreen.showErrorSnackBar(
        //         context, 'Please check the credentials');
        //   });
        // } else {
        //   context.locale = user.language == 1
        //       ? context.supportedLocales[0]
        //       : EasyLocalization.of(context).supportedLocales[1];
        //   user.deviceType = Responsive.isDesktop(context) ? 1 : 2;
        //   user.fcm = Hive.box('token')?.get('token') ?? "null";
        //   user.password = 'false';
        //   Database(context: context)
        //       .addUser(user)
        //       .then((value) => userProvider.initUser());

        //   // User user = await Database(context:context).getUser();
        //   // userProvider.user = user;
        //   if (widget.pop) {
        //     //   ///returning if user logged in
        //     Navigator.of(context).pop(user != null);
        //   } //else
        //   //   Navigator.of(context).pushReplacement(FadePageRoute(
        //   //     builder: (context) => NavScreen(),
        //   //   ));
        // }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(),
            ));
      },

      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    )
        // ),
        );
  }
}
