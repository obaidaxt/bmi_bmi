import 'dart:math';

class BodyMassindex {
  double gewicht;
  double groesse;
  BodyMassindex({this.gewicht = 80, this.groesse = 1.80});
  double? get bmi {
    if (groesse <= 0) {
      return null;
    }
    final result = gewicht / pow(groesse, 2);
    return result;
  }
}
