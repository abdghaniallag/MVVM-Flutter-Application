import 'package:dartz/dartz.dart';
import 'package:mvvm_first_c/data/network/failure.dart';
import 'package:mvvm_first_c/data/request/request.dart';

import 'model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
  Future<Either<Failure, StoreDetail>> getStoreDetail();
}
