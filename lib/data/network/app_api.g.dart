// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://flutterapp123.mocklab.io';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationRespons> login(email, password, imei, deviceType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'imei': imei,
      'deviceType': deviceType
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationRespons>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/costumers/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationRespons.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgotPasswordResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/costumers/forgotpassword',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgotPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationRespons> register(
      email, password, imei, deviceType, mobile) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'imei': imei,
      'deviceType': deviceType,
      'deviceType': mobile
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationRespons>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/costumers/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationRespons.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
