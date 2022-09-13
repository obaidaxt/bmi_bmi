import 'package:bmi_bmi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BmiWidget extends ConsumerWidget {
  const BmiWidget({super.key});

  @override
  Widget build(context, ref) {
    double sliderBmi;
    var bmi = ref.watch(refBmi).bmi;
    if (bmi.isNaN || bmi.isInfinite) {
      bmi = 0;
    }
    if (bmi > 40) {
      sliderBmi = 40;
    } else if (bmi < 8) {
      sliderBmi = 8;
    } else {
      sliderBmi = bmi;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 50,
                      color: const Color.fromARGB(255, 21, 132, 223),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 50,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 50,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Slider(
                activeColor: sliderBmi > 28 || sliderBmi < 18
                    ? const Color.fromARGB(255, 247, 14, 14)
                    : const Color.fromARGB(255, 7, 255, 102),
                value: sliderBmi,
                max: 40,
                min: 8,
                // label: _bmi.round().toString(),
                onChanged: (double value) {
                  // setState(() {
                  //   _bmi = value;
                  // });
                },
              ),
            ],
          ),
        ),
        const Text(
          "dein Bmi ist:",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          bmi.toStringAsFixed(1),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
