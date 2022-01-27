class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;
  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}
class  ForgetPasswordRequest {
   String email;
   ForgetPasswordRequest(this.email);
}