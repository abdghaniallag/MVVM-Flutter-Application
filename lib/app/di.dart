import 'package:get_it/get_it.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm_first_c/app/app_preferences.dart';
import 'package:mvvm_first_c/data/data_source/local_data_source.dart';
import 'package:mvvm_first_c/data/data_source/remot_data_source.dart';
import 'package:mvvm_first_c/data/network/app_api.dart';
import 'package:mvvm_first_c/data/network/dio_factory.dart';
import 'package:mvvm_first_c/data/network/network_info.dart';
import 'package:mvvm_first_c/data/repository/repository_impl.dart';
import 'package:mvvm_first_c/domain/repository.dart';
import 'package:mvvm_first_c/domain/usecase/forgot_password_usecase.dart';
import 'package:mvvm_first_c/domain/usecase/home_page_usecase.dart';
import 'package:mvvm_first_c/domain/usecase/login_usecase.dart';
import 'package:mvvm_first_c/domain/usecase/stores_detail_usecase.dart';
import 'package:mvvm_first_c/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:mvvm_first_c/presentation/login/login_viewmodel.dart';
import 'package:mvvm_first_c/presentation/main/home/home_page_viewmodel.dart';
import 'package:mvvm_first_c/presentation/storeDetails/store_details_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/register_usecase.dart';
import '../presentation/register/registerViewModel.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  // Shared Preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // App Preferences
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // Network Info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));
  // Dio
  instance.registerLazySingleton<DioFactoy>(() => DioFactoy(instance()));
  // App Service Client
  final dio = await instance<DioFactoy>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // Remot Data Source
  instance.registerLazySingleton<RemotDataSource>(
      () => RemotDataSourceImpilenter(instance()));
  // local Data Source
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplimenter(instance()));
  // RepositoryImpl
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomePageViewModel>(
        () => HomePageViewModel(instance()));
  }
}

initStoresModule() {
  if (!GetIt.I.isRegistered<StoreDetailUseCase>()) {
    instance.registerFactory<StoreDetailUseCase>(
        () => StoreDetailUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}
