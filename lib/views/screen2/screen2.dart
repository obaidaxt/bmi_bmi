import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmi_bmi/models/bmi.dart';
import '../screen1/screen1.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key, required String title}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    BodyMassindex bmi = BodyMassindex();

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
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(top: 5)),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Screen1(title: 'Page 2'),
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
                      initialValue: '',
                      decoration: InputDecoration(labelText: 'Gewicht in Kg'),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        final gewicht = double.tryParse(value);
                        if (gewicht != null) {
                          setState(() {
                            bmi.gewicht = gewicht;
                          });
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
                      initialValue: '',
                      decoration: InputDecoration(labelText: 'Größe in cm'),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        var groesse = double.tryParse(value);
                        if (groesse != null) {
                          setState(() {
                            bmi.groesse = groesse;
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
                  "Screen2 dein Bmi ist:",
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
                  "$bmass",
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
