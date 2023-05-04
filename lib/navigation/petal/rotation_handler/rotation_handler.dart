abstract class RotationHandler {
  double get turns;
  bool isCurrent();
  bool isPrevious();
  bool isNext();
  void previous();
  void next();
}
