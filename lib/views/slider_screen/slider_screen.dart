import 'package:bmi_bmi/main.dart';
import 'package:bmi_bmi/widgets/bmi_widget.dart';
import 'package:bmi_bmi/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:bmi_bmi/models/bmi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../text_screen/text_screen.dart';

class SliderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BodyMassIndex bmi = ref.watch(refBmi);

    double _bmi = bmi.gewicht * 10000 / (bmi.groesse * bmi.groesse);
    String bmass = _bmi.toStringAsFixed(2);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(top: 5)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextScreen(),
                    ));
              },
              child: Text(
                'Vorne',
                style: TextStyle(color: Colors.black),
              )),
          title: Text('ideal Gewicht'),
        ),
        body: Container(
          color: Color.fromARGB(255, 194, 165, 206),
          child: Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SliderWidget(
                    option: SliderWidget.groesse,
                  ),
                ),
                Expanded(
                  child: SliderWidget(
                    option: SliderWidget.gewicht,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BmiWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
