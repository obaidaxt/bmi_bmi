import 'package:bmi_bmi/models/bmi.dart';
import 'package:bmi_bmi/views/screen2/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen1 extends StatefulWidget {
  Screen1({Key? key, required this.title, required this.bmi}) : super(key: key);
  final BodyMassindex bmi;
  final String title;

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController myControllerInKg = TextEditingController();
  TextEditingController myControllerInCm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BodyMassindex bmi = widget.bmi;

    double _bmi = bmi.gewicht / (bmi.groesse * bmi.groesse);
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
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const Screen2()),
          //       );
          //     },
          //     icon: Icon(Icons.arrow_back)),

          leading: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(top: 5)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen2(title: 'Page 1', bmi: bmi),
                    ));
              },
              child: Text(
                'Zurück',
                style: TextStyle(color: Colors.black),
              )),
          title: Text('ideal Gewicht'),
        ),
        body: Container(
          color: Color.fromARGB(255, 105, 197, 140),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 200, 10, 50),
                padding: EdgeInsets.all(5),
                color: Colors.green,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  color: Colors.white70,
                  child: Center(
                    child: TextFormField(
                      controller: myControllerInKg,
                      decoration: InputDecoration(labelText: 'Gewicht in Kg'),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value != null) {
                          final input = double.tryParse(value);
                          if (input != null) {
                            setState(() {
                              bmi.gewicht = input;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                color: Colors.green,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  color: Colors.white70,
                  child: Center(
                    child: TextFormField(
                      controller: myControllerInCm,
                      decoration: InputDecoration(labelText: 'Größe in cm'),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value == null || value.isEmpty) {
                          return;
                        } else {
                          setState(() {
                            bmi.groesse = double.tryParse(value)!;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              // Container(
              // margin: EdgeInsets.all(90),
              // padding: EdgeInsets.all(50),
              // color: Colors.green,
              // Container(
              //   width: double.infinity,
              //   height: 55,
              //   color: _bmi > 25 || _bmi < 19 ? Colors.red : Colors.green,
              //   child: Text(_bmi.toStringAsFixed(0)),
              // ),
              // ),

              // Container(
              //   color: Colors.white,
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       padding: const EdgeInsets.all(16.0),
              //       textStyle: const TextStyle(fontSize: 20),
              //     ),
              //     onPressed: () {},
              //     child: const Text('Berechnen'),
              //   ),
              // ),
              Container(
                width: double.infinity,
                child: Text(
                  "dein Bmi ist:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                width: double.infinity,
                child: Text(
                  "${bmass}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
