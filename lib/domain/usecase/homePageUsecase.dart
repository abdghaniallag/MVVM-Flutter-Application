import 'package:mvvm_first_c/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/domain/repository.dart';
import 'package:mvvm_first_c/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void inputF) async {
    return await _repository.getHome();
  }
}
