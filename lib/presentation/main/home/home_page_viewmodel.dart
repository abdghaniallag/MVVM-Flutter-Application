import 'dart:async';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/domain/usecase/homePageUsecase.dart';
import 'package:mvvm_first_c/presentation/base/base.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel extends BaseViewModel
    with HomePageViewModelInputs, HomePageViewModelOutputs {
  HomeUseCase _homeUseCase;
  HomePageViewModel(this._homeUseCase);
  StreamController bannersStreamController = BehaviorSubject<List<BannerAd>>();
  StreamController servicesStreamController = BehaviorSubject<List<Service>>();
  StreamController storesStreamController = BehaviorSubject<List<Stores>>();

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => inputState.add(ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message)),
        (homeDate) {
      inputState.add(ContentState());
      bannersInputs.add(homeDate.homeData.banners);
      serviceInputs.add(homeDate.homeData.services);
      storesInputs.add(homeDate.homeData.stores);
    });
  }

  @override
  void dispose() {}

  @override
  Sink get bannersInputs => bannersStreamController.sink;

  @override
  Stream<List<BannerAd>> get bannersOutputs =>
      bannersStreamController.stream.map((banners) => banners);

  @override
  Sink get serviceInputs => servicesStreamController.sink;

  @override
  Stream<List<Service>> get servicesOutputs =>
      servicesStreamController.stream.map((services) => services);

  @override
  Sink get storesInputs => storesStreamController.sink;

  @override
  Stream<List<Stores>> get storesOutputs =>
      storesStreamController.stream.map((strores) => strores);
}

abstract class HomePageViewModelInputs {
  Sink get storesInputs;
  Sink get serviceInputs;
  Sink get bannersInputs;
}

abstract class HomePageViewModelOutputs {
  Stream<List<Service>> get servicesOutputs;
  Stream<List<Stores>> get storesOutputs;
  Stream<List<BannerAd>> get bannersOutputs;
}
