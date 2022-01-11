import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_first_c/app/app_prefs.dart';
import 'package:mvvm_first_c/app/constant.dart';
import 'package:mvvm_first_c/presentation/resources/languge_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ATHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactoy {
  AppPreferences _appPreferences;
  DioFactoy(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    
    int _timeOut = 60 * 1000;
    String  _language =await _appPreferences.getAppLangague();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      ATHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: LanguageType.ENGLISH.getValue(),
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        headers: headers);
    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}
