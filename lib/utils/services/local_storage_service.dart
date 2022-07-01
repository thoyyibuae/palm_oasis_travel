import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static Future init() async {
    // if (!kIsWeb) {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    // }
    // if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(UserAdapter());
    // print("userbox exists: ${await Hive.boxExists('user')}");
    await Hive.openBox('user');
    await Hive.openBox('fcm');
    await Hive.openBox('tokenValue');
    await Hive.openBox('refreshToken');
    await Hive.openBox('arguments');
    // await Hive.openBox('roleClaims');
    await Hive.openBox('userCache');
    // await Hive.openBox(Routes.companyId);
    // await RestApiService().refresh();

    if (kIsWeb) guestMode = true;
  }

  /// if json null, it wil remove arguments
  static void storeArgument(String route, {Map<String, dynamic>? json}) {
    if (json == null)
      Hive.box('arguments').delete(route);
    else
      Hive.box('arguments').put(route, jsonEncode(json));
  }

  static getArgument(String route) {
    final arguments = Hive.box('arguments').get(route);
    if (arguments != null) {
      print(arguments);
      return jsonDecode(arguments);
    }
  }

  static bool hasPermission(String permission) {
    return roleClaims != null &&
        roleClaims!.isNotEmpty &&
        roleClaims!.contains(permission);
  }

  static List<String>? get roleClaims {
    print('get token value');
    final box = Hive.box('roleClaims');
    if (box.isEmpty) {
      print("roleClaims not obtained from Hive db");

      return null;
    }
    // String? _roleClaims =
    return box.get('roleClaims');

    // if (_roleClaims == null) {
    //   LocalStorageService.logout();
    //   return null;
    // }
    // return tokenValue;
    // print(
    //     "User obtained from Hive ${_user?.tokenValue?.substring(0, 10)}...");
  }

  static set roleClaims(List<String>? value) {
    final box = Hive.box('roleClaims');
    if (!box.isOpen) {
      print("roleClaims box not open Hive db");
    } else {
      box.put('roleClaims', value);
    }
  }

  static String? get tokenValue {
    print('get token value');
    final box = Hive.box('tokenValue');
    if (box.isEmpty) {
      print("tokenValue not obtained from Hive db");

      return null;
    }
    String? tokenValue = box.get('tokenValue');

    if (tokenValue == null) {
      LocalStorageService.logout();
      return null;
    }
    return tokenValue;
    // print(
    //     "User obtained from Hive ${_user?.tokenValue?.substring(0, 10)}...");
  }

  static set tokenValue(String? value) {
    final box = Hive.box('tokenValue');
    if (!box.isOpen) {
      print("tokenValue box not open Hive db");
    } else {
      box.put('tokenValue', value);
    }
  }

  static String? get refreshToken {
    final box = Hive.box('refreshToken');
    if (box.isEmpty) {
      print("refreshToken not obtained from Hive db");
      return null;
    }
    String refreshToken = box.get('refreshToken');

    if (refreshToken == null) {
      logout();
      return null;
    }
    return refreshToken;
    // print(
    //     "User obtained from Hive ${_user?.tokenValue?.substring(0, 10)}...");
  }

  static set refreshToken(String? value) {
    final box = Hive.box('refreshToken');
    if (!box.isOpen) {
      print("refreshToken box not open Hive db");
    } else {
      box.put('refreshToken', value);
    }
  }

  // static bool get isLoggedIn {
  //   return user != null;
  // }

  static set guestMode(bool isGuest) {
    final box = Hive.box('user');
    isGuest ? box.put('guest', true) : box.clear();
  }

  static void logout() {
    print('clearing user');
    Hive.box('user').clear();
    Hive.box('tokenValue').clear();
    Hive.box('refreshToken').clear();
    // Hive.box(Routes.companyId).clear();
  }

  // static User? get user {
  //   final box = Hive.box('user');
  //   if (box.isEmpty) {
  //     print("User not obtained from Hive db");

  //     return null;
  //   }
  //   final user = box.get('user');
  //   if (user == null) return null;

  //   User _user = User.fromJson(jsonDecode(user));

  //   // if (_user != null) {
  //   //   if (_user.tokenValue == null || _user.refreshToken == null) {
  //   //     print("_user.tokenValue: ${_user.tokenValue}");
  //   //     print("_user.refreshToken: ${_user.refreshToken}");
  //   //     logout();
  //   //     return null;
  //   //   }
  //   //   // print(
  //   //   //     "User obtained from Hive ${_user?.tokenValue?.substring(0, 10)}...");
  //   // }

  //   return _user;
  // }

  // Future<void> addUser(User newUser) async {
  //   var box = await Hive.openBox('user');
  //   await box.put('user', jsonEncode(newUser.toJson())); //add(user);
  //   print("User added in Hive db");
  // }

  static String? get fcmToken {
    print('get token value');
    final box = Hive.box('fcm');
    if (box.isEmpty) {
      print("fcm not obtained from Hive db");

      return null;
    }
    String? tokenValue = box.get('tokenValue');

    if (tokenValue == null) {
      LocalStorageService.logout();
      return null;
    }
    return tokenValue;
    // print(
    //     "User obtained from Hive ${_user?.tokenValue?.substring(0, 10)}...");
  }

  static set fcmToken(String? value) {
    final box = Hive.box('fcm');
    if (!box.isOpen) {
      print("fcm box not open Hive db");
    } else {
      box.put('fcm', value);
    }
  }

  // static String? get companyId {
  //   print('get companyId value');
  //   final box = Hive.box(Routes.companyId);
  //   if (box.isEmpty) {
  //     print("fcm not obtained from Hive db");

  //     return null;
  //   }
  //   String? tokenValue = box.get(Routes.companyId);
  //   return tokenValue;
  //   // print(
  //   //     "User obtained from Hive ${_user?.tokenValue?.substring(0, 10)}...");
  // }

  // static set companyId(String? value) {
  //   final box = Hive.box(Routes.companyId);
  //   if (!box.isOpen) {
  //     print("companyId box not open Hive db");
  //   } else {
  //     box.put(Routes.companyId, value);
  //   }
  // }

  static bool storeInUserCache(String valueName, dynamic value) {
    final box = Hive.box('userCache');
    if (!box.isOpen) {
      return false;
    } else {
      box.put(valueName, value);
      return true;
    }
  }

  static dynamic getFromUserCache(String valueName) {
    final box = Hive.box('userCache');
    if (!box.isOpen) {
      return null;
    } else {
      return box.get(valueName);
    }
  }
}
