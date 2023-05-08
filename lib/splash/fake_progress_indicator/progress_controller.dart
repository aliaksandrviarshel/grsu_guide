import 'fake_progress_indicator.dart';

class ProgressController {
  late final FakeLinearProgressIndicatorState _state;

  void attach(FakeLinearProgressIndicatorState state) {
    _state = state;
  }

  void speedUp() {
    _state.speedUp();
  }
}
