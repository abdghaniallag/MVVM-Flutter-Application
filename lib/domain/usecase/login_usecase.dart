import 'package:mvvm_first_c/app/functions.dart';
import 'package:mvvm_first_c/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_first_c/data/request/request.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/domain/repository.dart';
import 'package:mvvm_first_c/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInupt, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInupt input) async {
    DeviceInfo _deviceInfo = await getDeviceDetails();

    return await _repository.login(LoginRequest(
        input.email, input.password, _deviceInfo.identifier, _deviceInfo.name));
  }
}

class LoginUseCaseInupt {
  String email;
  String password;
  LoginUseCaseInupt(this.email, this.password);
}
