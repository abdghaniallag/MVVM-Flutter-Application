import 'dart:async';
import 'dart:ffi';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/domain/usecase/stores_detail_usecase.dart';
import 'package:mvvm_first_c/presentation/base/base.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer.dart';
import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  StoreDetailUseCase _storeDetailUseCase;

  StreamController _storeDetailStreamController =
      BehaviorSubject<StoreDetail>();

  StoreDetailsViewModel(this._storeDetailUseCase);

  // inputs
  @override
  void start() {
    _getStoreDetail();
  }

  _getStoreDetail() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _storeDetailUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (storeDetail) {
      inputState.add(ContentState());
      inputStores.add(StoreDetail(
        storeDetail.image,
        storeDetail.id,
        storeDetail.title,
        storeDetail.detail,
        storeDetail.services,
        storeDetail.about,
      ));
    });
  }

  @override
  void dispose() {
    _storeDetailStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStores => _storeDetailStreamController.sink;

  @override
  Stream<StoreDetail> get outputStores =>
      _storeDetailStreamController.stream.map((homeData) => homeData);
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStores;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetail> get outputStores;
}
