import 'dart:developer';

import 'package:bmi_bmi/main.dart';
import 'package:bmi_bmi/views/widgets/bmi_widget.dart';
import 'package:bmi_bmi/views/slider_screen/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:bmi_bmi/models/bmi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../text_screen/text_screen.dart';

class SliderScreen extends ConsumerWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BodyMassIndex bmi = ref.watch(refBmi);
    log('Größe: ${bmi.groesse}');
    log('Gewicht: ${bmi.gewicht}');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
              style:
                  TextButton.styleFrom(padding: const EdgeInsets.only(top: 5)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextScreen(),
                    ));
              },
              child: const Text(
                'Vorne',
                style: TextStyle(color: Colors.black),
              )),
          title: const Text('ideal Gewicht'),
        ),
        body: Container(
          color: const Color.fromARGB(255, 194, 165, 206),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                SliderWidget(
                  option: BmiOptions.groesse,
                ),
                SliderWidget(
                  option: BmiOptions.gewicht,
                ),
                BmiWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
