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

  StreamController _homeObjectStreamController = BehaviorSubject<HomeData>();

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
      inputHome.add(HomeData(
        homeObject.homeData.services,
        homeObject.homeData.stores,
        homeObject.homeData.banners,
      ));
    });
  }

  @override
  void dispose() {
    _homeObjectStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHome => _homeObjectStreamController.sink;

  @override
  Stream<HomeData> get outputHome =>
      _homeObjectStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInputs {
  Sink get inputHome;
}

abstract class HomeViewModelOutputs {
  Stream<HomeData> get outputHome;
}
