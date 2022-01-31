import 'package:mvvm_first_c/data/network/failure.dart';

import 'package:dartz/dartz.dart';

import '../repository.dart';
import 'base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
