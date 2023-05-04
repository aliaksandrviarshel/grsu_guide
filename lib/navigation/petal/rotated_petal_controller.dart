import 'rotated_petal.dart';

class RotatedPetalsController {
  late final List<RotatedPetalState> _states = [];

  void attach(RotatedPetalState state) {
    _states.add(state);
  }

  void previous() {
    for (var element in _states) {
      element.previous();
    }
  }

  void next() {
    for (var element in _states) {
      element.next();
    }
  }
}
