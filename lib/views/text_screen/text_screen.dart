import 'package:bmi_bmi/main.dart';
import 'package:bmi_bmi/models/bmi.dart';
import 'package:bmi_bmi/views/slider_screen/slider_screen.dart';
import 'package:bmi_bmi/widgets/bmi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextScreen extends ConsumerStatefulWidget {
  TextScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends ConsumerState<TextScreen> {
  TextEditingController myControllerInKg = TextEditingController();
  TextEditingController myControllerInCm = TextEditingController();
  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    BodyMassIndex bmi = ref.watch(refBmi);
    if (isFirstTime) {
      myControllerInCm.text = bmi.groesse.toStringAsFixed(1);
      myControllerInKg.text = bmi.gewicht.toStringAsFixed(1);
      isFirstTime = false;
    }
    double _bmi = bmi.gewicht * 10000 / (bmi.groesse * bmi.groesse);
    String bmass = _bmi.toStringAsFixed(2);
    double _sliderBmi;
    if (_bmi.isNaN || _bmi.isInfinite) {
      _bmi = 0;
    }
    if (_bmi > 40) {
      _sliderBmi = 40;
    } else if (_bmi < 8) {
      _sliderBmi = 8;
    } else {
      _sliderBmi = _bmi;
    }

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(top: 5)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SliderScreen(),
                    ));
              },
              child: Text(
                'Zurück',
                style: TextStyle(color: Colors.black),
              )),
          title: Text('ideal Gewicht'),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            color: Color.fromARGB(255, 105, 197, 140),
            height: constraints.maxHeight,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextWidget(
                    label: 'Gewicht in kg',
                    value: bmi.gewicht,
                    controller: myControllerInKg,
                    onChanged: (value) {
                      if (value != null) {
                        final input = double.tryParse(value);
                        if (input != null) {
                          final oldState = ref.read(refBmi);
                          final provider = ref.read(refBmi.notifier);
                          provider.state = BodyMassIndex(
                            groesse: oldState.groesse,
                            gewicht: input,
                          );
                        }
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextWidget(
                    label: 'Gewicht in kg',
                    value: bmi.gewicht,
                    controller: myControllerInKg,
                    onChanged: (value) {
                      if (value != null) {
                        final input = double.tryParse(value);
                        if (input != null) {
                          final oldState = ref.read(refBmi);
                          final provider = ref.read(refBmi.notifier);
                          provider.state = BodyMassIndex(
                            groesse: oldState.groesse,
                            gewicht: input,
                          );
                        }
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BmiWidget(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  TextWidget({
    required this.value,
    required this.label,
    required this.onChanged,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final double value;
  final String label;
  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      height: 55,
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            labelText: label,
          ),
          textAlign: TextAlign.center,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
