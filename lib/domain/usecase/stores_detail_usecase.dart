import 'package:mvvm_first_c/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/domain/repository.dart';
import 'package:mvvm_first_c/domain/usecase/base_usecase.dart';

class StoreDetailUseCase extends BaseUseCase<void, StoreDetail> {
  Repository _repository;
  StoreDetailUseCase(this._repository);
  @override
  Future<Either<Failure, StoreDetail>> execute(void inputF) async {
    return await _repository.getStoreDetail();
  }
}
