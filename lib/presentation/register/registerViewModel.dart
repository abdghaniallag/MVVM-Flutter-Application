import 'dart:async';
import 'dart:io';

import 'package:mvvm_first_c/app/functions.dart';
import 'package:mvvm_first_c/presentation/base/base.dart';
import 'package:mvvm_first_c/presentation/resources/strings_manager.dart';

import '../../domain/usecase/register_usecase.dart';
import '../common/freezed_data.dart';
import '../state_renderer/state_renderer.dart';
import '../state_renderer/state_renderer_implimenter.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _mobile_numberStreamController =
      StreamController<String>.broadcast();
  StreamController _profilePictureController =
      StreamController<File>.broadcast();
  StreamController _isAllInputsValidController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyController =
      StreamController<bool>();

  var registerObject = RegisterObject("", "", "", "", "", "");
  RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _emailStreamController.close();
    _mobile_numberStreamController.close();
    _profilePictureController.close();
    _isAllInputsValidController.close();
  }

  @override
  Sink get inputAllInputs => _isAllInputsValidController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputmobile_number => _mobile_numberStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidController.stream.map((_) => _isAllInputsValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsmobile_numberValid =>
      _mobile_numberStreamController.stream
          .map((mobile_number) => _ismobile_numberValid(mobile_number));

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureController.stream.map((profilePicture) => profilePicture);

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setuserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setmobile_number(String mobile_number) {
    inputmobile_number.add(mobile_number);
    if (_ismobile_numberValid(mobile_number)) {
      registerObject = registerObject.copyWith(mobile_number: mobile_number);
    } else {
      registerObject = registerObject.copyWith(mobile_number: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (_isProfilePictureValid(profilePicture)) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _registerUseCase.execute(RegisterUseCaseInupt(
            registerObject.mobile_number,
            registerObject.countryCode,
            registerObject.userName,
            registerObject.email,
            registerObject.password,
            '')))
        .fold(
            (failure) => {
                  //left failure
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      {
        //right success
        inputState.add(ContentState());
        isUserLoggedInSuccessfullyController.add(true);
      }
    });
  }

  bool _isUserNameValid(String userName) {
    return userName.length >= 2;
  }

  bool _ismobile_numberValid(String mobile_number) {
    return mobile_number.length >= 1;
  }

  bool _isCountryCodeValid(String countryCode) {
    return countryCode.isNotEmpty;
  }

  bool _isProfilePictureValid(File profilePicture) {
    return profilePicture.path.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 2;
  }

  bool _isAllInputsValid() {
    return registerObject.password.isNotEmpty &&
        registerObject.countryCode.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.mobile_number.isNotEmpty &&
        registerObject.userName.isNotEmpty;
  }

  _validate() {
    inputAllInputs.add(null);
  }

  @override
  Stream<String?> get outputErrorUserNameValid => outputIsUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.invalidUserName);

  @override
  Stream<String?> get outputErrorEmailValid => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<String?> get outputErrormobile_numberValid =>
      outputIsmobile_numberValid.map((ismobile_numberValid) =>
          ismobile_numberValid ? null : AppStrings.invalidMobileNumber);

  @override
  Stream<String?> get outputErrorPasswordValid => outputIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.invalidpassword);

  @override
  setCountryCode(String countryCode) {
    if (_isCountryCodeValid(countryCode)) {
      registerObject = registerObject.copyWith(countryCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryCode: "");
    }
    _validate();
  }
}

abstract class RegisterViewModelInputs {
  setuserName(String userName);
  setmobile_number(String mobile_number);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  register();

  Sink get inputUserName;
  Sink get inputmobile_number;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputs;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserNameValid;
  Stream<bool> get outputIsmobile_numberValid;
  Stream<String?> get outputErrormobile_numberValid;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmailValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPasswordValid;
  Stream<File> get outputProfilePicture;
  Stream<bool> get outputIsAllInputsValid;
}
