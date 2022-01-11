import 'package:mvvm_first_c/data/data_source/remot_data_source.dart';
import 'package:mvvm_first_c/data/mapper/mapper.dart';
import 'package:mvvm_first_c/data/network/error_handler.dart';
import 'package:mvvm_first_c/data/network/network_info.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/data/request/request.dart';
import 'package:mvvm_first_c/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_first_c/domain/repository.dart';

class RepositoryImpl extends Repository {
  RemotDataSource _remotDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(this._remotDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      //its safe to call the API
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConected) {
      try {
         final response = await _remotDataSource.login(loginRequest);
      if (response.status == ApiInternalStatus.SUCCESS) {
        // return data
        return Right(response.toDomain());
      } else {
        //return left logic biz error
        return Left(Failure(
            response.status?? ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT ));
      }
      } catch (error) {
       return Left(ErrorHandler.handel(error).failure);

      }
     
    } else {
      // return connection error
      return Left( (DataSource.NO_INRENET_CONNECTION.getFailure()));
    }
  }
}