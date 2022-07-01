import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tutvideo/constants/api_links.dart';
import 'package:tutvideo/models/ResponseModels/get_blogs.dart';
import 'package:tutvideo/models/ResponseModels/get_countries.dart';
import 'package:tutvideo/models/ResponseModels/get_homepage_countries.dart';
import 'package:tutvideo/models/ResponseModels/get_package_details.dart';
import 'package:tutvideo/models/ResponseModels/get_packages.dart';
import 'package:tutvideo/models/ResponseModels/get_sliders.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_nationalities.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_requirements.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_types.dart';
import '../../models/ResponseModels/country.dart';
import '../../models/ResponseModels/get_country_details.dart';
import 'dio_response_manager.dart';

class RestApiService {
  final BuildContext? context;
  late String languageId;

  RestApiService({this.context}) {
    try {
      languageId = context?.locale.languageCode ?? 'en';
      if (languageId.isEmpty) languageId = 'en';
    } catch (e) {
      languageId = 'en';
      print(e);
    }
  }

  Future<Response>? getDioResponse(String url,
      [bool? auth, bool errorResponse = true]) {
    print('calling $url api with auth=$auth');
    Future<Response>? responseFuture;
    try {
      responseFuture = DioResponseManager(url,
              isAuthMandatory: auth, context: context,
          languageCode: languageId)
          .get();
    } catch (e) {
      print('responseError');
      print(url);
      print(e);
      if (errorResponse) throw e;
    }
    return responseFuture;
  }

  /// auth null no auth, authMandatory false auth optional; true will refreshToken or send to authPage if no token, if error response true it will throw error response else error message
  Future<Response> postDioResponse(String url, data,
      [bool? authMandatory, bool errorResponse = true]) async {
    Response response;
    try {
      response = await DioResponseManager(url,
              data: data,
              isAuthMandatory: authMandatory,
              context: context,
              languageCode: '')
          .post();
    } catch (e) {
      if (errorResponse) throw e;
      throw errorMessage(e);
    }
    return response;
  }

  Future<Response> deleteDioResponse(String url, Object? data,
      [bool? authMandatory, bool errorResponse = true]) async {
    Response response;
    try {
      response = await DioResponseManager(url,
              data: data,
              isAuthMandatory: authMandatory,
              context: context,
              languageCode: languageId)
          .delete();
    } catch (e) {
      if (errorResponse) throw e;

      throw errorMessage(e);
    }
    return response;
  }

  Future<Response> putDioResponse(String url, Object? data,
      [bool? authMandatory, bool errorResponse = true]) async {
    Response response;
    try {
      response = await DioResponseManager(url,
              data: data,
              isAuthMandatory: authMandatory,
              context: context,
              languageCode: languageId)
          .put();
    } catch (e) {
      if (errorResponse) throw e;

      throw errorMessage(e);
    }
    return response;
  }

  String errorMessage(dynamic dioError) {
    if (!(dioError is DioError)) return dioError.toString();
    print(dioError.type);
    print(dioError.error);
    print(dioError.message);
    print(dioError.response);
    if (dioError.response?.statusCode == null ||
        dioError.response!.statusCode == 101)
      return 'Please check your connection';
    if (dioError.response!.statusCode == 400) {
      {
        final data = dioError.response?.data;
        print(data is Map<String, dynamic>);
        print(data.containsKey('errors'));
        print(data['errors'] is List<dynamic>);
        if (data is Map<String, dynamic> &&
            data.containsKey('errors') &&
            data['errors'] is List<dynamic>)
          return data['errors'].join(",");
        else
          return dioError.message;
      }
    } else if (dioError.response!.statusCode == 404) {
      final data = dioError.response?.data;
      if (data != null &&
          data is Map &&
          data.containsKey('errorMessage') &&
          data['errorMessage'] is String)
        return data['errorMessage'];
      else if (dioError.response?.data is List<dynamic>) {
        return dioError.response?.data?.join(",");
      }
    }
    return dioError.message;
  }

  // Dio addInterceptors(Dio dio, bool auth) {
  //   return dio
  //     ..interceptors.add(InterceptorsWrapper(
  //         // onRequest: (RequestOptions options) => requestInterceptor(options),
  //         // onResponse: (Response response) => responseInterceptor(response),
  //         onError: (DioError dioError, _) => errorInterceptor(dioError),
  //         onRequest: (RequestOptions options, _) async {
  //           if (auth != null) {
  //             if (auth && !LocalStorageService.isLoggedIn) {
  //               print('no user found in local');
  //               // return options;
  //             }
  //             if (!auth && !LocalStorageService.isLoggedIn) return;
  //             // options;

  //             if (LocalStorageService.tokenValue != null) {
  //               // print('adding auth token to header');
  //               var customHeaders = {
  //                 'content-type': 'application/json',
  //                 'Authorization': 'Bearer ' + LocalStorageService.tokenValue!
  //               };
  //               options.headers.addAll(customHeaders);
  //             }
  //           }
  //           // return options;//todo
  //         }));
  // }

  // errorInterceptor(DioError dioError) {
  //   print('dio error interceptor:${dioError.requestOptions.uri}');
  //   print(dioError.error);
  //   print(dioError.message);
  //   print(dioError.response);
  //   // if (dioError == null) throw 'checkConnection'.tr();
  //   if (dioError.message.contains('401')) {
  //     Hive.box('user').clear();
  //     // throw null; //try authTokenRefresh
  //     // throw 'userDoesNotExist'.tr();
  //   }
  //   throw dioError;
  // }

  // Future<bool> isFirstTime() async {
  //   var box = await Hive.openBox('musicHouse');
  //   bool isEmpty = box.isEmpty;
  //   print("is first time: $isEmpty");
  //   return isEmpty;
  // }

  // Future<void> setNotFirstTime() async {
  //   print('setting not first time');
  //   var box = await Hive.openBox('musicHouse');
  //   await box.add(true);
  //   await box.close();
  // }

  Future<List<Package>?> get packages async {
    try {
      final response = await getDioResponse(
        ApiLinks.getPackages,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetPackages.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageDetails?> packageDetails(int packageId, int hotelId) async {
    try {
      final response = await getDioResponse(
        ApiLinks.getPackageDetails(packageId, hotelId),
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetPackageDetails.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Country>?> get countries async {
    try {
      final response = await getDioResponse(
        ApiLinks.getCountries,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetCountries.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Country>?> get homepageCountries async {
    try {
      final response = await getDioResponse(
        ApiLinks.getHomepageCountries,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetHomepageCountries.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Blog>?> get blogs async {
    try {
      final response = await getDioResponse(
        ApiLinks.getBlogs,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetBlogs.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SliderData>?> get sliders async {
    try {
      final response = await getDioResponse(
        ApiLinks.getSliders,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetSliders.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VisaType>?> get visaTypes async {
    try {
      final response = await getDioResponse(
        ApiLinks.getVisaTypes,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetVisaTypes.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VisaNationality>?> get visaNationalities async {
    try {
      final response = await getDioResponse(
        ApiLinks.getVisaNationalities,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetVisaNationalities.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<CountryDetails?> countryDetails(int countryId) async {
    try {
      final response = await getDioResponse(
        ApiLinks.getCountryDetails(countryId),
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetCountryDetails.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<VisaRequirements?> visaRequirements(
      int visaTypeId, int countryId) async {
    try {
      final url = ApiLinks.getVisaRequirements(countryId, visaTypeId);
      log(url);
      final response = await getDioResponse(
        url,
      );
      if (response?.data == null) throw 'checkYourConnection'.tr();
      final getPackages = GetVisaRequirements.fromJson(response!.data);
      return getPackages.data;
    } catch (e) {
      rethrow;
    }
  }
}
