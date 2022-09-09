import 'package:bmi_bmi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BmiWidget extends ConsumerWidget {
  const BmiWidget({Key? key});

  @override
  Widget build(context, ref) {
    double _sliderBmi;
    var bmi = ref.watch(refBmi).bmi;
    if (bmi.isNaN || bmi.isInfinite) {
      bmi = 0;
    }
    if (bmi > 40) {
      _sliderBmi = 40;
    } else if (bmi < 8) {
      _sliderBmi = 8;
    } else {
      _sliderBmi = bmi;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 50,
                      color: Color.fromARGB(255, 21, 132, 223),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 50,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      height: 50,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Slider(
                activeColor: _sliderBmi > 28 || _sliderBmi < 18
                    ? Color.fromARGB(255, 247, 14, 14)
                    : Color.fromARGB(255, 7, 255, 102),
                value: _sliderBmi,
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
        Text(
          "dein Bmi ist:",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${bmi.toStringAsFixed(1)}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
