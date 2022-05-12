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
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobile_number;
  String profilePicture;
  RegisterRequest(this.countryMobileCode, this.userName, this.email,
      this.password, this.mobile_number, this.profilePicture);
}
