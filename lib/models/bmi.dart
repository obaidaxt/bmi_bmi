import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyMassIndex {
  final double gewicht;
  final double groesse;

  const BodyMassIndex({this.gewicht = 80, this.groesse = 180});

  double get bmi {
    if (groesse <= 0) {
      return double.nan;
    }
    final bmi = gewicht * 10000 / pow(groesse, 2);
    return bmi;
  }

  BodyMassIndex copyWith({double? gewicht, double? groesse}) {
    return BodyMassIndex(
      gewicht: gewicht ?? this.gewicht,
      groesse: groesse ?? this.groesse,
    );
  }
}

class BodyMassIndexNotifier extends StateNotifier<BodyMassIndex> {
  BodyMassIndexNotifier([super.state = const BodyMassIndex()]);
  void updateGewicht(double gewicht) {
    state = state.copyWith(gewicht: gewicht);
  }

  void updateGroesse(double groesse) {
    state = state.copyWith(groesse: groesse);
  }
}
