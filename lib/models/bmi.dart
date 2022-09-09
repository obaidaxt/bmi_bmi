import 'dart:math';

class BodyMassIndex {
  final double gewicht;
  final double groesse;

  BodyMassIndex({this.gewicht = 80, this.groesse = 180});

  double get bmi {
    if (groesse <= 0) {
      return double.nan;
    }
    final bmi = gewicht * 10000 / pow(groesse, 2);
    return bmi;
  }
}
