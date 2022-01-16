import 'dart:async';
import 'dart:io';

import 'package:mvvm_first_c/domain/usecase/login_usecase.dart';
import 'package:mvvm_first_c/presentation/base/base.dart';
import 'package:mvvm_first_c/presentation/common/freezed_data.dart';
import 'package:mvvm_first_c/presentation/resources/values_manager.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidController =
      StreamController<void>.broadcast();
StreamController _isUserLoggedSeccesfuly =
      StreamController<void>();

  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase; //todo remove ?
  LoginViewModel(this._loginUseCase);
  //inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidController.close();
  }

  @override
  void start() {
    inputState.add(
        ContentState()); // view tells the state renderere, show the content of the screen
    // inputState.add(ErrorState(stateRendererType, message)); view tells the state renderere, show error state
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  setPassword(String Password) {
    inputPassword.add(Password);
    loginObject = loginObject.copyWith(password: Password);
    _validat();
  }

  @override
  setUserName(String UserName) {
    inputUserName.add(UserName);
    loginObject = loginObject.copyWith(userName: UserName);
    _validat();
  }

  _validat() {
    inputAllInputs.add(null);
  }

  @override
  Sink get inputAllInputs => _isAllInputsValidController.sink;

  @override
  login() async {inputState.add(
    LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
   
    (await _loginUseCase.execute(
            LoginUseCaseInupt(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  //left failure
                  // inputState.add(ErrorState(
                  //     StateRendererType.POPUP_ERROR_STATE, failure.message))
                },
            (data) => {{
                  //right success
                  inputState.add(ContentState())}
                });
  }

//outpputs
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIspasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return (_isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName));
  }

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidController.stream.map((_) => _isAllInputsValid());
}

abstract class LoginViewModelInputs {
  setUserName(String UserName);
  setPassword(String Password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAllInputs;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIspasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
