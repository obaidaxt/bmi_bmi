import 'dart:developer';

import 'package:bmi_bmi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderWidget extends ConsumerWidget {
  const SliderWidget({
    required this.option,
    super.key,
  });

  final BmiOptions option;

  @override
  Widget build(BuildContext context, ref) {
    final bmi = ref.watch(refBmi);

    log('Größe: ${bmi.groesse}');
    log('Gewicht: ${bmi.gewicht}');

    final double displayValue;
    if (option == BmiOptions.groesse) {
      displayValue = bmi.groesse;
    } else {
      displayValue = bmi.gewicht;
    }
    final String label;
    if (option == BmiOptions.groesse) {
      label = 'Deine Größe ist';
    } else {
      label = 'Dein Gewicht ist';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            '$label: ${displayValue.toStringAsFixed(1)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 50, 50, 15),
          child: Slider(
            value: displayValue,
            onChanged: (value) {
              final bmiNotifier = ref.read(refBmi.notifier);
              if (option == BmiOptions.groesse) {
                bmiNotifier.updateGroesse(value);
              } else {
                bmiNotifier.updateGewicht(value);
              }
            },
            min: 40,
            max: 250,
            divisions: 300,
            label: bmi.groesse.round().toString(),
            activeColor: const Color.fromARGB(255, 31, 72, 141),
            inactiveColor: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}

enum BmiOptions {
  groesse,
  gewicht,
}
