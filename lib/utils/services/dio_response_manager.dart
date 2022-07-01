import 'dart:developer';
// import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:music_house_flutter/theme/basic_colors.dart';
// import 'package:music_house_flutter/theme/basic_settings.dart';
// import 'package:music_house_flutter/resources/local_db/database.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../constants/api_links.dart';
// import '../../theme/basic_colors.dart';
// import 'local_storage_service.dart';
// import 'package:music_house_flutter/widgets/adaptive_text.dart';

class DioResponseManager {
  final bool? isAuthMandatory;
  final String url;
  final Object? data;
  late Dio _dio;
  static BuildContext? _context;
  final String languageCode;

  /// if isAuthMandatory null, no authToken will added. False auth will be checked in Hive, if no will send without token
  /// if yes request will be sent with token
  DioResponseManager(
    this.url, {
    required this.languageCode,
    BuildContext? context,
    this.isAuthMandatory,
    this.data,
  }) {
    _context = context;
    _dio = Dio(BaseOptions(
      baseUrl: ApiLinks.base,
      connectTimeout: 300000,
    ));
    // addInterceptors();
  }

  Future<Response>? getDioResponse(String url) {
    // Dio dio = getDio();
    Future<Response>? responseFuture;

    try {
      responseFuture = _dio.get(url,
          options: Options(headers: {
            if (_context != null) 'locale': _context?.locale.languageCode
          }));
    } catch (e) {
      print('responseError');
      print(url);
      print(e);
    }
    return responseFuture;
  }

  /// auth null no auth, authMandatory false auth optional; true will refreshToken or send to authPage if no token

  Future<Response> post() async {
    log(_dio.options.baseUrl + url);
    print(data?.toString());
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (error) {
      print(url);
      return retryIfLoggedOut(error, post);
    }
  }

  Future<Response> put() async {
    print(url);
    print(data.toString());
    try {
      return await _dio.put(url, data: data);
    } catch (error) {
      print(url);
      return retryIfLoggedOut(error, put);
    }
  }

  Future<Response> get() async {
    print(url);
    try {
      return await _dio.get(url,
          options: Options(headers: {
            if (_context != null) 'locale': _context?.locale.languageCode
          }));
    } catch (error) {
      print(url);
      return retryIfLoggedOut(error, get);
    }
  }

  Future<Response> delete() async {
    print(url);
    print(data.toString());
    try {
      return await _dio.delete(url, data: data);
    } catch (error) {
      print(url);
      return retryIfLoggedOut(error, post);
    }
  }

  Future<Response> retryIfLoggedOut(
      var error, Future<Response> Function() function) async {
    // if (error is DioError &&
    //     (error.response?.statusCode != null &&
    //         error.response!.statusCode == 401 //|| error.message.contains('404')
    //     )) {
    //   try {
    //     if (LocalStorageService.tokenValue != null) {
    //       final value = await DioResponseManager(ApiLinks.refresh, data: {
    //         "token": LocalStorageService.tokenValue,
    //         "refreshToken": LocalStorageService.refreshToken,
    //       }).post();
    //       LocalStorageService.tokenValue = value.data['token'];
    //       LocalStorageService.refreshToken = value.data['refreshToken'];
    //       return function();
    //       // _dio.post(url,data: data);
    //     } else {
    //       if (_context != null)
    //         Navigator.of(_context!).popUntil((route) => route.isFirst);
    //       throw error;
    //     }
    //   } catch (e) {
    //     e.toString().contains('400');
    //     LocalStorageService.logout();
    //     if (_context != null)
    //       Navigator.of(_context!).popUntil((route) => route.isFirst);
    //     throw e;
    //   }
    // } else if (error == null ||
    //     (error is DioError &&
    //         error.response?.statusCode != null &&
    //         (error.response!.statusCode == 111 ||
    //             error.response!.statusCode == 101))) {
    //   if (_context != null) {
    //     ScaffoldMessenger.maybeOf(_context!)?.removeCurrentSnackBar();
    //     ScaffoldMessenger.maybeOf(_context!)
    //         ?.showSnackBar(SnackBar(
    //             duration: Duration(days: 1),
    //             action: SnackBarAction(
    //               label: 'retry'.tr(),
    //               textColor: BasicColors.kDarkYellow,
    //               onPressed: () {
    //                 ScaffoldMessenger.maybeOf(_context!)
    //                     ?.removeCurrentSnackBar();
    //                 function();
    //               },
    //             ),
    //             content: Text(
    //               'checkYourInternetConnection'.tr(),
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             backgroundColor: BasicColors.kDarkBlue))
    //         .closed
    //         .then((value) {
    //       print(value);
    //       // if(value==SnackBarClosedReason.
    //       //  throw error;
    //     });
    //   }
    //   print('connectionError');
    //   throw error;
    // } else if (error is DioError &&
    //     (error.type == DioErrorType.receiveTimeout ||
    //         error.type == DioErrorType.sendTimeout ||
    //         error.type == DioErrorType.connectTimeout)) {
    //   if (_context != null) {
    //     ScaffoldMessenger.maybeOf(_context!)?.removeCurrentSnackBar();
    //     ScaffoldMessenger.maybeOf(_context!)?.showSnackBar(SnackBar(
    //       duration: Duration(days: 1),
    //       action: SnackBarAction(
    //         label: 'retry'.tr(),
    //         textColor: BasicColors.kDarkYellow,
    //         onPressed: () {
    //           ScaffoldMessenger.maybeOf(_context!)?.removeCurrentSnackBar();
    //           function();
    //         },
    //       ),
    //       content: Text(
    //         'checkYourInternetConnection'.tr(),
    //         style: TextStyle(color: Colors.white),
    //       ),
    //       backgroundColor: BasicColors.kDarkBlue,
    //     ));
    //     // ?.closed
    //     // ?.then((value) => throw error);
    //   }
    //   print('connectionError');
    //   throw error;
    // }
    throw error;
  }

  // addInterceptors() {
  //   _dio..interceptors.add(AuthInterceptor(isAuthMandatory));
  // }
}

// class AuthInterceptor extends Interceptor {
//   final bool? isAuthMandatory;

//   AuthInterceptor(this.isAuthMandatory);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     if (isAuthMandatory != null) {
//       if (isAuthMandatory! && LocalStorageService.tokenValue == null) {
//         print('no user found in local');
//         return super.onRequest(options, handler);
//       }
//       if (!isAuthMandatory! && LocalStorageService.tokenValue == null)
//         return super.onRequest(options, handler);

//       if (LocalStorageService.tokenValue != null) {
//         var customHeaders = {
//           'content-type': 'application/json',
//           'Authorization': 'Bearer ' + LocalStorageService.tokenValue!
//         };
//         print(LocalStorageService.tokenValue);
//         options.headers.addAll(customHeaders);
//       } else
//         throw ('Contact dev, User or token Empty at dioResponse interceptor');
//     }
//     return super.onRequest(options, handler);
//   }
// }
