import 'dart:math';

class BodyMassindex {
  double gewicht;
  double groesse;
  BodyMassindex({this.gewicht = 80, this.groesse = 180});
  double? get bmi {
    if (groesse <= 0) {
      return null;
    }
    final bmi = gewicht * 10000 / pow(groesse, 2);
    return bmi;
  }
}
