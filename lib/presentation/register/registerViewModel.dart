import 'dart:async';

import 'package:mvvm_first_c/presentation/base/base.dart';

import '../../domain/usecase/register_usecase.dart';
import '../common/freezed_data.dart';
import '../state_renderer/state_renderer_implimenter.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _NameStreamController = StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileStreamController =
      StreamController<String>.broadcast();
  StreamController _profilePictureController =
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyController =
      StreamController<void>();
  var registerObject = RegisterObject("", "", "", "", "");
  RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  @override
  void dispose() {
    _NameStreamController.close();
    _passwordStreamController.close();
    _emailStreamController.close();
    _mobileStreamController.close();
    _profilePictureController.close();
    _isAllInputsValidController.close();
  }

  @override
  Sink get inputAllInputs => _isAllInputsValidController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputName => _NameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputmobile => _mobileStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidController.stream.map((_) => _isAllInputsValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsNameValid =>
      _NameStreamController.stream.map((name) => _isNameValid(name));

  @override
  Stream<bool> get outputIsmobileValid =>
      _mobileStreamController.stream.map((mobile) => _ismobileValid(mobile));

  @override
  Stream<bool> get outputIsProfilePictureValid =>
      _profilePictureController.stream
          .map((profilePicture) => _isProfilePictureValid(profilePicture));

  @override
  Stream<bool> get outputIspasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  setEmail(String email) {
    inputPassword.add(email);
    registerObject = registerObject.copyWith(email: email);
    _validat();
  }

  @override
  setName(String name) {
    inputPassword.add(name);
    registerObject = registerObject.copyWith(name: name);
    _validat();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    _validat();
  }

  @override
  setmobile(String mobile) {
    inputPassword.add(mobile);
    registerObject = registerObject.copyWith(mobile: mobile);
    _validat();
  }

  @override
  setProfilePicture(String profilePicture) {
    inputPassword.add(profilePicture);
    registerObject = registerObject.copyWith(profilePicture: profilePicture);
    _validat();
  }

  _validat() {
    inputAllInputs.add(null);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  bool _isEmailValid(String email) {
    return email.isEmpty;
  }

  bool _isNameValid(String name) {
    return name.isEmpty;
  }

  bool _ismobileValid(String mobile) {
    return mobile.isEmpty;
  }

  bool _isProfilePictureValid(String profilePicture) {
    return profilePicture.isEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isEmpty;
  }

  _isAllInputsValid() {
    return (_isPasswordValid(registerObject.password) &&
        _isNameValid(registerObject.name) &&
        _isNameValid(registerObject.email) &&
        _isNameValid(registerObject.mobile) &&
        _isNameValid(registerObject.profilePicture));
  }
}

abstract class RegisterViewModelInputs {
  setName(String name);
  setmobile(String mobile);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(String profilePicture);
  register();

  Sink get inputName;
  Sink get inputmobile;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputs;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsNameValid;
  Stream<bool> get outputIsmobileValid;
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIspasswordValid;
  Stream<bool> get outputIsProfilePictureValid;
  Stream<bool> get outputIsAllInputsValid;
}
