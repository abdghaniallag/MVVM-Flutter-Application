import 'package:mvvm_first_c/app/constant.dart';
import 'package:mvvm_first_c/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio  ,{String baseUrl})=_AppServiceClient;
  @POST('/costumers/login')
  Future<AuthenticationRespons>login( 
    @Field("email") String email,    
    @Field("password") String passwordn,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
@POST('/costumers/forgotpassword')
  Future<ForgotPasswordRespons>forgotPassword( 
    @Field("email") String email,    
  );

}