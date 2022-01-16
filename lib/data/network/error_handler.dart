import 'package:dio/dio.dart';
import 'package:mvvm_first_c/data/network/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTROL,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  UNKNOWN,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INRENET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handel(dynamic error) {
    if (error is DioError) {
      failure = _handelError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handelError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioErrorType.response:
        switch (dioError.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.NOT_FOUND:
         
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.UNKNOWN:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INRENET_CONNECTION:
        return Failure(ResponseCode.NO_INRENET_CONNECTION,
            ResponseMessage.NO_INRENET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  //API status code
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTROL = 201; //success with no content
  static const int BAD_REQUEST = 400; //failure , api rejected the request
  static const int FORBIDDEN = 403; //failure , api rejected the request
  static const int UNAUTHORISED = 401; //failure , user is not AUTHORISED
  static const int NOT_FOUND = 404; //failure , api url is not found
  static const int INTERNAL_SERVER_ERROR = 500; //crach happend in server side
  // local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INRENET_CONNECTION = -7;
}

class ResponseMessage {
  //API status code
  static const String SUCCESS = "success";
  static const String NO_CONTROL = "success with no content";
  static const String BAD_REQUEST = "bad request, try again later";
  static const String FORBIDDEN = "forbiden request, try again later";
  static const String UNAUTHORISED = "user is unauthorised, try again later";
  static const String NOT_FOUND = "Url is not found, try again later";
  static const String INTERNAL_SERVER_ERROR =
      "some thing went wrong, try again later";
  // local status code
  static const String DEFAULT = "DEFAULT some thing went wrong, try again later";
  static const String CONNECT_TIMEOUT = "time out error, try again later";
  static const String CANCEL = "request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "time out error, try again later";
  static const String SEND_TIMEOUT = "time out error, try again later";
  static const String CACHE_ERROR = "time out error, try again later";
  static const String NO_INRENET_CONNECTION =
      "please check your internet connection";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;  
  static const int FAILURE = 1;  

}
