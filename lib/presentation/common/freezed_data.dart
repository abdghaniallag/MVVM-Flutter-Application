import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String name, String mobile, String email,
      String password, String profilePicture) = _RegisterObject;
}
