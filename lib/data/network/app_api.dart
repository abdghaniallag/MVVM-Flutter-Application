import 'package:mvvm_first_c/app/constant.dart';
import 'package:mvvm_first_c/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @POST('/costumers/login')
  Future<AuthenticationRespons> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
  @POST('/costumers/forgotpassword')
  Future<ForgotPasswordResponse> forgotPassword(
    @Field("email") String email,
  );
  @POST('/costumers/register')
  Future<AuthenticationRespons> register(
    @Field("country_mobile_code") String countryMobileCode,
    @Field("user_name") String userName,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );
}
