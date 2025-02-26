import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medshield/components/icon_content.dart';
import 'package:medshield/components/reusable_card.dart';
import 'package:medshield/constants.dart';
import 'package:medshield/screens/results_page.dart';
import 'package:medshield/components/bottom_button.dart';
import 'package:medshield/components/round_icon_button.dart';
import 'package:medshield/calculator_brain.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medshield/asyn_functions.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 180;
  int weight = 0;
  int age = 10;
  double oxygen = 0;
  double temperature = 0;
  int heartRate = 0;

  @override
  void initState() {
    super.initState();
    getHealthData(); // Fetch data on startup
  }

  void getHealthData() async {
    final data = await fetchHealthData(); // Fetch data from Firebase

    if (data != null) {
      setState(() {
        heartRate = (data["bpm"] ?? heartRate).toInt();
        oxygen = (data["spo2"] ?? oxygen).toDouble();
        temperature = (data["temperature"] ?? temperature).toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MedShield'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: getHealthData,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    icon: FontAwesomeIcons.lungs,
                    label: 'OXYGEN',
                    value: oxygen > 0 ? '${oxygen.toStringAsFixed(1)}%' : '-',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    icon: FontAwesomeIcons.thermometerHalf,
                    label: 'TEMPERATURE',
                    value: temperature > 0
                        ? '${temperature.toStringAsFixed(1)}°C'
                        : '-',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              icon: FontAwesomeIcons.heartbeat,
              label: 'HEART RATE',
              value: heartRate > 0 ? '$heartRate bpm' : '-',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  label: 'WEIGHT',
                  value: weight > 0 ? weight.toString() : '-',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onPressed: () {
                          setState(() {
                            weight--;
                          });
                        },
                      ),
                      SizedBox(width: 10.0),
                      RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onPressed: () {
                          setState(() {
                            weight++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  label: 'AGE',
                  value: age > 0 ? age.toString() : '-',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onPressed: () {
                          setState(() {
                            age--;
                          });
                        },
                      ),
                      SizedBox(width: 10.0),
                      RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onPressed: () {
                          setState(() {
                            age++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BottomButton(
            buttonTitle: 'CHECK',
            onTap: () {
              HealthMonitor patient = HealthMonitor(
                oxygenLevel: oxygen,
                temperature: temperature,
                heartRate: heartRate,
                age: age,
              );

              Map<String, String> result = patient.analyzeHealth();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    oxygen: oxygen,
                    heartRate: heartRate,
                    temperature: temperature,
                    interpretation: result["Health Assessment"] ??
                        "No assessment available",
                    recommendation: result["Recommended Actions"] ??
                        "No recommendations available",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
