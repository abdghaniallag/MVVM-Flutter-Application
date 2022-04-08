class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;
  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class ForgotPasswordRequest {
  String email;
  ForgotPasswordRequest(this.email);
}

class RegisterRequest {
  String mobile;
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String profilePicture;
  RegisterRequest(this.mobile, this.countryMobileCode, this.userName,
      this.email, this.password, this.profilePicture);
}
