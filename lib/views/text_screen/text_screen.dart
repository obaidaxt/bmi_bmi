import 'dart:developer';

import 'package:bmi_bmi/main.dart';
import 'package:bmi_bmi/models/bmi.dart';
import 'package:bmi_bmi/views/slider_screen/slider_screen.dart';
import 'package:bmi_bmi/views/widgets/bmi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextScreen extends ConsumerStatefulWidget {
  const TextScreen({Key? key}) : super(key: key);

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
    log('Größe (T): ${bmi.groesse}');
    log('Gewicht (T): ${bmi.gewicht}');
    if (isFirstTime) {
      log('is first time');
      setState(() {
        myControllerInCm.text = bmi.groesse.toStringAsFixed(1);
        myControllerInKg.text = bmi.gewicht.toStringAsFixed(1);
      });
      isFirstTime = false;
    }

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
              style:
                  TextButton.styleFrom(padding: const EdgeInsets.only(top: 5)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SliderScreen(),
                    ));
              },
              child: const Text(
                'Zurück',
                style: TextStyle(color: Colors.black),
              )),
          title: const Text('ideal Gewicht'),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            color: const Color.fromARGB(255, 105, 197, 140),
            height: constraints.maxHeight,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextWidget(
                    label: 'Groesse in cm',
                    value: bmi.groesse,
                    controller: myControllerInCm,
                    onChanged: (value) {
                      final neueGroesse = double.tryParse(value);
                      if (neueGroesse != null) {
                        final oldState = ref.read(refBmi);
                        final provider = ref.read(refBmi.notifier);
                        provider.state = BodyMassIndex(
                          groesse: neueGroesse,
                          gewicht: oldState.gewicht,
                        );
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
                      final input = double.tryParse(value);
                      if (input != null) {
                        final oldState = ref.read(refBmi);
                        final provider = ref.read(refBmi.notifier);
                        provider.state = BodyMassIndex(
                          groesse: oldState.groesse,
                          gewicht: input,
                        );
                      }
                    },
                  ),
                ),
                const Expanded(
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
  const TextWidget({
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
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 55,
      child: Center(
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              labelText: label,
              labelStyle: const TextStyle(color: Colors.black)),
          textAlign: TextAlign.center,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
