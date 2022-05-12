import 'dart:async';

import 'package:mvvm_first_c/presentation/state_renderer/state_renderer_implimenter.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variable and functions that will be used throgh any view model
  StreamController _inputStreamController = BehaviorSubject<FlowState>();
  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // intiate view model
  void dispose(); // distruct view model
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
