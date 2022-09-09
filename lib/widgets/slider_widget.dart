import 'package:bmi_bmi/main.dart';
import 'package:bmi_bmi/models/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderWidget extends ConsumerWidget {
  const SliderWidget({
    required this.option,
    Key? key,
  }) : super(key: key);

  final BmiOptions option;
  static const groesse = BmiOptions.groesse;
  static const gewicht = BmiOptions.gewicht;

  @override
  Widget build(BuildContext context, ref) {
    final bmi = ref.watch(refBmi);
    final double displayValue;
    if (option == BmiOptions.groesse) {
      displayValue = bmi.groesse;
    } else {
      displayValue = bmi.gewicht;
    }
    final String label;
    if (option == bmi.groesse) {
      label = 'Deine Größe ist';
    } else {
      label = 'Dein Gewicht ist';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            '$label: ${displayValue.toStringAsFixed(1)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(50, 50, 50, 15),
          child: Slider(
            value: displayValue,
            onChanged: (value) {
              final provider = ref.read(refBmi.notifier);
              final oldState = ref.read(refBmi);
              if (option == BmiOptions.groesse) {
                provider.state = BodyMassIndex(
                  gewicht: oldState.gewicht,
                  groesse: value,
                );
              } else {
                provider.state = BodyMassIndex(
                  gewicht: value,
                  groesse: oldState.groesse,
                );
              }
            },
            min: 10,
            max: 250,
            divisions: 300,
            label: bmi.groesse.round().toString(),
            activeColor: Color.fromARGB(255, 31, 72, 141),
            inactiveColor: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}

enum BmiOptions { groesse, gewicht }
