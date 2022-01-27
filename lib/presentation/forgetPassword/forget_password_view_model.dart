import 'dart:async';
 
import 'package:mvvm_first_c/presentation/base/base.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  @override
  void dispose() {
    _emailStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override 
  Sink get InputEmail => _emailStreamController.sink;

  @override 
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));
  bool isEmailValid(String email) {
    return email.isNotEmpty;
  }

  @override
  resetPassword() {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  setEmaill(String email) { 
    InputEmail.add(email);
  }
}

abstract class ForgetPasswordViewModelInputs {
  setEmaill(String email);
  resetPassword();

  Sink get InputEmail;
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
}
