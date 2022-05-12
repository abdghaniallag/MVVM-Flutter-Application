import 'package:mvvm_first_c/data/network/error_handler.dart';
import 'package:mvvm_first_c/data/responses/responses.dart';

import '../network/app_api.dart';

const CACH_HOME_KEY = 'CACH_HOME_KEY';
const CACH_HOME_VALID_TIME = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeData(HomeResponse homeResponse);
  clearDataSource();
  removeDataSource(String key);
}

class LocalDataSourceImplimenter implements LocalDataSource {
  AppServiceClient _appServiceClient;
  LocalDataSourceImplimenter(this._appServiceClient);
  Map<String, CachedItems> cacheMap = Map();
  @override
  Future<HomeResponse> getHomeData() async {
    CachedItems? cachedItem = cacheMap[CACH_HOME_KEY];
    if (cachedItem != null && cachedItem.isCacheValid(CACH_HOME_VALID_TIME)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeData(HomeResponse homeResponse) async {
    cacheMap[CACH_HOME_KEY] = CachedItems(homeResponse);
  }

  @override
  clearDataSource() {
    cacheMap.clear();
  }

  @override
  removeDataSource(String key) {
    cacheMap.remove(key);
  }
}

class CachedItems {
  dynamic data;
  int cahedTime = DateTime.now().millisecondsSinceEpoch;
  CachedItems(this.data);
}

extension CacheItemsExtension on CachedItems {
  bool isCacheValid(int expectation) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    return currentTime - expectation < cahedTime;
  }
}
