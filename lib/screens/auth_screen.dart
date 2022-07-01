import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
// import 'package:music_house_flutter/providers/user_datas.dart';
// import 'package:music_house_flutter/resources/local_db/database.dart';
// import 'package:music_house_flutter/theme/basic_colors.dart';
// import 'package:music_house_flutter/widgets/adaptive_text.dart';
// import 'package:music_house_flutter/widgets/basic_screen.dart';
// import 'package:music_house_flutter/widgets/bottom_action_button.dart';
// import 'package:music_house_flutter/widgets/custom_route.dart';
// import 'package:music_house_flutter/widgets/language_widget.dart';
// import 'package:music_house_flutter/widgets/mobileWidgets/auth_screen/auth_login.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:music_house_flutter/models/databaseModels/user.dart' as MyUser;
// import 'package:music_house_flutter/widgets/responsive.dart';
import 'package:provider/provider.dart';
// import '../loading_circle_screen.dart';
// import '../phone_number_otp_screen.dart';
import 'package:http/http.dart' as http;

import '../theme/basic_colors.dart';
import '../utils/helpers/basic_screen.dart';
import '../utils/helpers/bottom_action_button.dart';
import '../utils/helpers/language_widget.dart';
import '../utils/helpers/loading_circle_screen.dart';
import '../widgets/authScreen/auth_login.dart';
import 'bottom_nav.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthScreen extends StatefulWidget {
  static const String route = '/login';

  /// to pop the authscreen instead of pushing new nav screen
  final bool pop;
  const AuthScreen({Key? key, this.pop = false}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Widget _buildScaffold() {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 5,
          brightness:
              !kIsWeb && Platform.isIOS ? Brightness.light : Brightness.dark,
          backgroundColor: Colors.transparent,
          leading: widget.pop
              ? BackButton(
                  color: BasicColors.kDarkBlue,
                )
              : null,
          elevation: 0,
          actions: [
            LanguageWidget(
              fontColor: BasicColors.kDarkBlue,
            ),
          ],
        ),
        body: _loading ? LoadingCircleScreen() : AuthLogin(pop: widget.pop),
        bottomNavigationBar: _loading
            ? null
            : SizedBox(
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Consumer<UserDatas>(
                    //     builder: (_, userProvider, __) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 3.3,
                            top: 3.1,
                            right: 3.3,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width / 3,
                            ),
                            child: Wrap(
                              children: [
                                Text(
                                  'socialLogin'.tr(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Theme.of(context).primaryColor,
                                    // BasicColors.kRed, //Colors.red.shade100,
                                    fontFamily: 'Quicksand',
                                    decoration: TextDecoration.none,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        SocialLoginButton(
                          icon: FontAwesomeIcons.facebookF,
                          onTap: () async {
                            
                            // // Trigger the sign-in flow
                            // print('fb login');
                            // log('message');
                            // _runLoading();
                            // final facebookInstance =
                            //     FacebookAuth.instance;
                            // try {
                            //   // try {
                            //   // by default the login method has the next permissions ['email','public_profile']

                            //   // mobile build only
                            //   LoginResult loginResult =
                            //       await facebookInstance.login();
                            //   print(loginResult);
                            //   print(loginResult.status?.toString());
                            //   print(loginResult.accessToken);
                            //   print(loginResult.message);
                            //   // get the user data
                            //   // FacebookAuth
                            //   //           .instance.
                            //   if (loginResult.status !=
                            //       LoginStatus.success) {
                            //     // _stopLoading();
                            //     throw loginResult?.message ?? "";
                            //     // return;
                            //   }
                            //   AccessToken accessToken =
                            //       loginResult.accessToken;

                            //   // // web build only

                            //   // AccessToken accessToken =
                            //   //     await facebookInstance.login();
                            //   // // //up to this
                            //   if (accessToken == null) throw "";
                            //   print(accessToken.toJson());

                            //   if (accessToken == null) {
                            //     _stopLoading();
                            //     return;
                            //   }
                            //   final userData =
                            //       await facebookInstance.getUserData();
                            //   print(userData);
                            //   String email = userData['email'];
                            //   final picture = userData['picture'];
                            //   String image;
                            //   if (picture != null) {
                            //     Map data = picture['data'];
                            //     if (data != null) {
                            //       String url = data['url'];
                            //       if (url != null) {
                            //         final base64 =
                            //             await networkImageToBase64(url);
                            //         if (base64 != null)
                            //           image =
                            //               "data:image/jpeg;base64," +
                            //                   base64;
                            //       }
                            //     }
                            //   }
                            //   MyUser
                            //       .User user = await Database(
                            //           context: context)
                            //       .socialLogin(MyUser.User(
                            //           fullname: userData['name'],
                            //           password: email,
                            //           deviceType:
                            //               Responsive.isDesktop(context)
                            //                   ? 1
                            //                   : 2,
                            //           image: image,
                            //           email: email,
                            //           fcm: Hive.box('token')
                            //                   ?.get('token') ??
                            //               "null",
                            //           gender: 1,
                            //           language:
                            //               context.locale.toString() ==
                            //                       'en'
                            //                   ? 1
                            //                   : 2,
                            //           mobile: email,
                            //           status: 1,
                            //           userType: 1,
                            //           provider: 'facebook.com',
                            //           tokenName: 'userId',
                            //           tokenValue: accessToken.userId,
                            //           userName: email));
                            //   user = await getPhoneNumberForUser(
                            //       user, image);
                            //   if (user == null) return;
                            //   Database(context: null)
                            //       .addUser(user)
                            //       .then((value) {
                            //     userProvider.initUser();
                            //     userProvider.socialLogoutCallBack =
                            //         facebookInstance.logOut;
                            //   });
                            //   if (widget.pop) {
                            //     //   ///returning if user logged in
                            //     Navigator.of(context).pop(user != null);
                            //   }
                            //   // } catch (e) {
                            //   //   _stopLoading();

                            //   // if (e == null)

                            //   //   //     ? e.message
                            //   //   //     :
                            //   //    e.toString();
                            //   //   // web build only
                            //   //   // if(e is FacebookAuth)
                            //   //   // switch (e.errorCode) {
                            //   //   //   case FacebookAuthErrorCode
                            //   //   //       .OPERATION_IN_PROGRESS:
                            //   //   //     throw ("You have a previous login operation in progress");
                            //   //   //     break;
                            //   //   //   case FacebookAuthErrorCode
                            //   //   //       .CANCELLED:
                            //   //   //     throw ("login cancelled");
                            //   //   //     break;
                            //   //   //   case FacebookAuthErrorCode.FAILED:
                            //   //   //     throw ("login failed");
                            //   //   //     break;
                            //   //   //   default:
                            //   //   //     throw 'unknownError';
                            //   //   // }
                            //   // else
                            //   //     throw e;
                            //   // }
                            // } catch (e) {
                            //   print('caught $e');
                            //   _stopLoading();
                            //   if (e != null &&
                            //       e.toString().isNotEmpty) {
                            //     BasicScreen.showErrorSnackBar(
                            //         context, e.toString());
                            //     final accessToken =
                            //         facebookInstance?.accessToken;
                            //     if (accessToken != null) {
                            //       final token = await accessToken;
                            //       if (token != null &&
                            //           token.token.isNotEmpty)
                            //         facebookInstance.logOut();
                            //     }
                            //   }
                            // }
                            // // _stopLoading();
                          },
                        ),
                        SocialLoginButton(
                          onTap: () async {
                            // _runLoading();
                            // GoogleSignIn _googleSignIn;
                            // try {
                            //   print('google log in clicked');
                            //   _googleSignIn = GoogleSignIn(
                            //     scopes: [
                            //       'email',
                            //       // 'https://www.googleapis.com/auth/contacts.readonly',
                            //     ],
                            //   );
                            //   GoogleSignInAccount account =
                            //       await _googleSignIn.signIn();
                            //   if (account == null ||
                            //       !await _googleSignIn.isSignedIn()) {
                            //     _stopLoading();
                            //     return;
                            //   }
                            //   String image;
                            //   String base64 =
                            //       await networkImageToBase64(
                            //           _googleSignIn
                            //               .currentUser.photoUrl);
                            //   if (base64 != null)
                            //     image =
                            //         "data:image/jpeg;base64," + base64;
                            //   MyUser.User user = await Database(context: context)
                            //       .socialLogin(MyUser.User(
                            //           fullname: _googleSignIn.currentUser
                            //               .displayName,
                            //           password: _googleSignIn.currentUser
                            //               .email,
                            //           deviceType:
                            //               Responsive.isDesktop(context)
                            //                   ? 1
                            //                   : 2,
                            //           image: image,
                            //           email: _googleSignIn
                            //               .currentUser.email,
                            //           fcm: Hive.box('token')
                            //                   ?.get('token') ??
                            //               "null",
                            //           gender: 1,
                            //           language:
                            //               context.locale.toString() == 'en'
                            //                   ? 1
                            //                   : 2,
                            //           mobile: _googleSignIn.currentUser.email,
                            //           status: 1,
                            //           userType: 1,
                            //           provider: 'google.com',
                            //           tokenName: 'idToken',
                            //           tokenValue: _googleSignIn.currentUser.id,
                            //           userName: _googleSignIn.currentUser.email));
                            //   user = await getPhoneNumberForUser(
                            //       user, image);
                            //   if (user == null) return;
                            //   Database(context: context)
                            //       .addUser(user)
                            //       .then((value) {
                            //     userProvider.initUser();
                            //     userProvider.socialLogoutCallBack =
                            //         _googleSignIn.disconnect;
                            //   });
                            //   if (widget.pop) {
                            //     Navigator.of(context).pop(user != null);
                            //   }
                            // } catch (e) {
                            //   if (mounted) {
                            //     _stopLoading();
                            //     print(e.toString());

                            //     if (e is
                            //         // // web build only
                            //         // AuthException
                            //         // Mobile build only
                            //         FirebaseAuthException) {
                            //       print('error fire: ${e.message}');
                            //       print(e.code);
                            //     }

                            //     if (e != null &&
                            //         e.toString().isNotEmpty)
                            //       BasicScreen.showErrorSnackBar(
                            //           context,
                            //           e is
                            //                   // // web build only
                            //                   // AuthException
                            //                   // Mobile build only
                            //                   FirebaseAuthException
                            //               ? e.message
                            //               : e.toString());
                            //     if (_googleSignIn != null &&
                            //         await _googleSignIn.isSignedIn()) {
                            //       await _googleSignIn.disconnect();
                            //     }
                            //     _stopLoading();
                            //   }
                            // }
                          }, // button pressed
                          icon: FontAwesomeIcons.google,
                        ),
                        if (!kIsWeb && !kIsWeb && Platform.isIOS)
                          SocialLoginButton(
                            // splash color
                            onTap: () async {
                              // _runLoading();
                              // try {
                              //   print('apple log in clicked');

                              //   AuthorizationCredentialAppleID
                              //       credential;
                              //   try {
                              //     credential = await SignInWithApple
                              //         .getAppleIDCredential(
                              //       scopes: [
                              //         AppleIDAuthorizationScopes.email,
                              //         AppleIDAuthorizationScopes
                              //             .fullName,
                              //         // AppleIDAuthorizationScopes.values.
                              //       ],
                              //       // webAuthenticationOptions:
                              //       //     WebAuthenticationOptions(
                              //       //   // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                              //       //   clientId: 'ae.musichouse.app',
                              //       //   redirectUri: Uri.parse(
                              //       //     'https://musichouse.ae',
                              //       // ),
                              //       // ),
                              //       // // TODO: Remove these if you have no need for them
                              //       // nonce: 'example-nonce',
                              //       // state: 'example-state',
                              //     );
                              //   } catch (e) {
                              //     _stopLoading();
                              //     if (e
                              //         is SignInWithAppleAuthorizationException) {
                              //       if (e.code ==
                              //           AuthorizationErrorCode
                              //               .canceled) {
                              //         _stopLoading();
                              //         return;
                              //       } else
                              //         throw e.message;
                              //     } else if (e
                              //         is SignInWithAppleCredentialsException) {
                              //       throw e.message;
                              //     } else if (e
                              //         is SignInWithAppleNotSupportedException) {
                              //       throw e.message;
                              //     } else
                              //       throw e;
                              //   }
                              //   print(credential);
                              //   String email, name;
                              //   Box appleBox;
                              //   if (await Hive.boxExists('apple')) {
                              //     appleBox =
                              //         await Hive.openBox('apple');
                              //     email = appleBox.get('email');
                              //     name = appleBox.get('name');
                              //   }
                              //   if (credential == null) {
                              //     _stopLoading();
                              //     return;
                              //   }
                              //   if ((credential.email == null ||
                              //           credential.email.isEmpty) &&
                              //       (email == null && email.isEmpty))
                              //     throw "Unable to obtain the credential from Apple";
                              //   if (credential.identityToken == null ||
                              //       credential.identityToken.isEmpty)
                              //     throw "Token not obtained from Apple Id";
                              //   if (credential.email != null &&
                              //       credential.email.isNotEmpty) {
                              //     if (appleBox == null) {
                              //       appleBox =
                              //           await Hive.openBox('apple');
                              //     }
                              //     await appleBox.put(
                              //         'email', credential.email);
                              //     email = credential.email;
                              //     await appleBox.put(
                              //         'name', credential.givenName);
                              //     name = credential.givenName;
                              //   }

                              //   appleBox.close();

                              //   // credential.

                              //   // String image;
                              //   // String base64 =
                              //   //     await networkImageToBase64(
                              //   //         _googleSignIn
                              //   //             .currentUser.photoUrl);
                              //   // if (base64 != null)
                              //   //   image = "data:image/jpeg;base64," +
                              //   //       base64;
                              //   MyUser.User user = await Database(
                              //           context: context)
                              //       .socialLogin(MyUser.User(
                              //           fullname: name ?? email,
                              //           password: email,
                              //           deviceType:
                              //               Responsive.isDesktop(
                              //                       context)
                              //                   ? 1
                              //                   : 2,
                              //           image: "", //image,
                              //           email: email,
                              //           fcm: Hive.box('token')
                              //                   ?.get('token') ??
                              //               "null",
                              //           gender: 1,
                              //           language:
                              //               context.locale.toString() ==
                              //                       'en'
                              //                   ? 1
                              //                   : 2,
                              //           mobile: email,
                              //           status: 1,
                              //           userType: 1,
                              //           provider: 'apple.com',
                              //           tokenName: 'identityToken',
                              //           tokenValue:
                              //               credential.identityToken,
                              //           // _googleSignIn
                              //           //     .currentUser.id,
                              //           userName: email));
                              //   user = await getPhoneNumberForUser(
                              //       user, null);
                              //   if (user == null) return;
                              //   Database(context: context)
                              //       .addUser(user)
                              //       .then((value) {
                              //     userProvider.initUser();
                              //     // userProvider.socialLogoutCallBack =
                              //     //     () {};
                              //   });
                              // if (widget.pop) {
                              //   Navigator.of(context)
                              //       .pop(user != null);
                              // }
                              // } catch (e) {
                              //   _stopLoading();

                              //   print(e.toString());
                              //   BasicScreen.showErrorSnackBar(
                              //       context, e.toString());
                              //   // if (_googleSignIn != null &&
                              //   //     await _googleSignIn.isSignedIn()) {
                              //   //   _googleSignIn.disconnect();
                              //   // }
                              // }
                              // _stopLoading();
                            }, // button pressed
                            icon: FontAwesomeIcons.apple,
                          ),
                      ],
                      // )
                    ),
                    SizedBox(
                        width: size.width,
                        child: BottomActionButton(
                            color: Theme.of(context).primaryColor,

                            //  Colors.red.shade300,
                            padding: EdgeInsets.only(top: 5),
                            label: 'guestLogin',
                            onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNav(),
                                    ));
                              // if (widget.pop) {
                              //   Navigator.pop(context);
                              // } else {
                              //   // Database.guestMode = true;
                              // }
                            })),
                  ],
                ),
              ),
      );
    }

    return _buildScaffold();
  }

  _runLoading() => setState(() => _loading = true);
  _stopLoading() => setState(() => _loading = false);

  // Future<MyUser.User> getPhoneNumberForUser(
  //     MyUser.User user, String image) async {
  //   if (user.email == user.mobile ||
  //       user.mobile == null ||
  //       user.mobile.isEmpty) {
  //     var phone = await Navigator.push(
  //         context,
  //         FadePageRoute(
  //           builder: (context) => PhoneNumberOtpScreen(),
  //         ));

  //     if (phone == null) {
  //       // phone = '+971000000000';
  //       throw 'phoneNumberNotVerified'.tr();
  //     } else if (phone is bool && phone == true) {
  //       Database.guestMode = true;
  //       return null;
  //     } else if (phone is bool && phone == false) {
  //       Database.guestMode = true;
  //       return null;
  //     }
  //     user.mobile = phone;
  //     if (user.image == null || user.image.isEmpty) {
  //       user.image = image;
  //     }
  //     user = await Database(context: context).updateMyProfile(user);
  //     print(phone);
  //     return null;
  //   }

  //   context.locale = user.language == 1
  //       ? context.supportedLocales[0]
  //       : EasyLocalization.of(context).supportedLocales[1];
  //   user.deviceType = Responsive.isDesktop(context) ? 1 : 2;
  //   user.fcm = Hive.box('token')?.get('token') ?? "null";
  //   user.password = 'false';
  //   return user;
  // }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : "");
  }
}

class SocialLoginButton extends StatelessWidget {
  final void Function() onTap;

  final IconData icon;

  const SocialLoginButton({Key? key, required this.onTap, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.3),
      child: SizedBox.fromSize(
        size: Size(56, 56), // button width and height
        child: ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            // Colors.redAccent.shade100, // button color
            child: InkWell(
              splashColor: Theme.of(context).splashColor,
              //  Colors.red, // splash color

              onTap: onTap, // button pressed

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.grey.shade700,
                  ), // icon
                  // AdaptiveText("Facebook"), // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
