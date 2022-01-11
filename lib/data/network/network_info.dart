import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo{
  Future <bool> get isConected;
}
class NetworkInfoImpl  implements NetworkInfo{
  DataConnectionChecker _dataConnectionChecker;
  NetworkInfoImpl(this._dataConnectionChecker);
  @override
  // TODO: implement isConected
  Future<bool> get isConected => _dataConnectionChecker.hasConnection;
  
}