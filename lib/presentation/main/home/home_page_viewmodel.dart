import 'dart:async';
import 'dart:ffi';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/domain/usecase/homePageUsecase.dart';
import 'package:mvvm_first_c/presentation/base/base.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  StreamController _bannersStreamController = BehaviorSubject<List<BannerAd>>();
  StreamController _servicesStreamController = BehaviorSubject<List<Service>>();
  StreamController _storesStreamController = BehaviorSubject<List<Stores>>();

  HomePageViewModel(this._homeUseCase);

  // inputs
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.homeData.banners);
      inputServices.add(homeObject.homeData.services);
      inputStores.add(homeObject.homeData.stores);
    });
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // outputs
  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Stores>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  Sink get inputStores;

  Sink get inputServices;

  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Stores>> get outputStores;

  Stream<List<Service>> get outputServices;

  Stream<List<BannerAd>> get outputBanners;
}
