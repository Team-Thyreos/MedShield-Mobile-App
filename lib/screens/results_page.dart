import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:medshield/constants.dart';
import 'package:medshield/components/reusable_card.dart';
import 'package:medshield/components/bottom_button.dart';
import 'package:share_plus/share_plus.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({
    required this.heartRate,
    required this.oxygen,
    required this.temperature,
    required this.interpretation,
    required this.recommendation,
  });

  // final String bmiResult;
  final double oxygen;
  final int heartRate;
  final double temperature;
  final String interpretation;
  final String recommendation;
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MedShield'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'save') {
                await saveResultsToCSV(heartRate, temperature, interpretation,
                    recommendation, oxygen);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Results saved successfully! to $path")),
                );
              } else if (value == 'share') {
                await shareResults(heartRate, temperature, interpretation,
                    recommendation, oxygen);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'save',
                child: Row(
                  children: [
                    Icon(Icons.save, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Save Results'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Share Results'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColour,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // First Header
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Health Assessment",
                      style: kTitleTextStyle.copyWith(
                        fontSize: 22.0, // Customize size
                        fontWeight: FontWeight.bold, // Customize weight
                        color: kBottomContainerColour, // Customize color
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 5.0), // Spacing below the header
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      interpretation,
                      textAlign: TextAlign.justify,
                      style: kBodyTextStyle,
                    ),
                  ),
                  SizedBox(height: 2.0), // Increased spacing between sections

                  // Second Header
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Recommended Actions",
                      style: kTitleTextStyle.copyWith(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color:
                            kBottomContainerColour, // Different color for variety
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      recommendation,
                      textAlign: TextAlign.justify,
                      style: kBodyTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CHECK',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  /// Function to save results to a CSV file
  Future<void> saveResultsToCSV(int heartRate, double temperature,
      String interpretation, String recommendation, double oxygen) async {
    List<List<dynamic>> data = [
      ["heartRate", "temperature" "oxygen", "Interpretation"],
      [heartRate, temperature, oxygen, interpretation, recommendation]
    ];

    String csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationDocumentsDirectory();
    path = '${directory.path}/medshield_results.csv'; // Made path mutable
    final file = File(path!);

    await file.writeAsString(csvData);

    print("Results saved to: $path");
  }

  /// Function to share results
  Future<void> shareResults(int heartRate, double temperature,
      String interpretation, String recommendation, double oxygen) async {
    String message = "Here are my Vitals results:\n\n"
        "📊 HeartRate: $heartRate\n"
        "📊 OxygenLevel: $oxygen\n"
        "📊 Temperature: $temperature\n"
        "📝 Interpretation: $interpretation\n\n"
        "📝 Recommended Actions: $recommendation\n\n"
        "Shared via MedShield App.";

    await Share.share(message);
  }
}

// class ResultsPage extends StatelessWidget {
//   ResultsPage({
//     required this.interpretation,
//     required this.bmiResult,
//     required this.resultText,
//   });
//
//   final String HResult;
//   final String O2Result;
//   final String TempResult;
//   final String bmiResult;
//   final String resultText;
//   final String interpretation;
//   final?  path;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MedShield'),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (value) async {
//               if (value == 'save') {
//                 await saveResultsToCSV(bmiResult, resultText, interpretation);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Results saved successfully! to $path")),
//                 );
//               } else if (value == 'share') {
//                 await shareResults(bmiResult, resultText, interpretation);
//               }
//             },
//             itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 value: 'save',
//                 child: Row(
//                   children: [
//                     Icon(Icons.save, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text('Save Results'),
//                   ],
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'share',
//                 child: Row(
//                   children: [
//                     Icon(Icons.share, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text('Share Results'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(15.0),
//               alignment: Alignment.bottomLeft,
//               child: Text(
//                 'Your Result',
//                 style: kTitleTextStyle,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: ReusableCard(
//               colour: kActiveCardColour,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   // Text(
//                   //   'resultText.toUpperCase(),
//                   //   style: kResultTextStyle,
//                   // ),
//                   // Text(
//                   //   bmiResult,
//                   //   style: kBMITextStyle,
//                   // ),
//                   Text(
//                     'You have a moderate vital signals. Keep up your daily excercises', //interpretation,
//                     textAlign: TextAlign.center,
//                     style: kBodyTextStyle,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           BottomButton(
//             buttonTitle: 'RE-CHECK',
//             onTap: () {
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   /// Function to save results to a CSV file
//   Future<void> saveResultsToCSV(
//       String bmiResult, String resultText, String interpretation) async {
//     List<List<String>> data = [
//       ["Vitals Result", "Category", "Interpretation"],
//       [bmiResult, resultText, interpretation]
//     ];
//
//     String csvData = const ListToCsvConverter().convert(data);
//     final directory = await getApplicationDocumentsDirectory();
//      path = '${directory.path}/medshield_results.csv';
//     final file = File(path);
//
//     await file.writeAsString(csvData);
//
//     print("Results saved to: $path");
//   }
//
//   /// Function to share results
//   Future<void> shareResults(
//       String bmiResult, String resultText, String interpretation) async {
//     String message = "Here are my Vitals results:\n\n"
//         "📊 HeartRate: $HRResult\n"
//         "📊 OxygenLevel: $O2Result\n"
//         "📊 Temperature: $TempResult\n"
//         "💡 Category: $resultText\n"
//         "📝 Interpretation: $interpretation\n\n"
//         "Shared via MedShield App.";
//
//     await Share.share(message);
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:bmi_calculator/constants.dart';
// // import 'package:bmi_calculator/components/reusable_card.dart';
// // import 'package:bmi_calculator/components/bottom_button.dart';
// //
// // class ResultsPage extends StatelessWidget {
// //   ResultsPage(
// //       {required this.interpretation,
// //       required this.bmiResult,
// //       required this.resultText});
// //
// //   final String bmiResult;
// //   final String resultText;
// //   final String interpretation;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('MedShield'),
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: <Widget>[
// //           Expanded(
// //             child: Container(
// //               padding: EdgeInsets.all(15.0),
// //               alignment: Alignment.bottomLeft,
// //               child: Text(
// //                 'Your Result',
// //                 style: kTitleTextStyle,
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 5,
// //             child: ReusableCard(
// //               colour: kActiveCardColour,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: <Widget>[
// //                   Text(
// //                     resultText.toUpperCase(),
// //                     style: kResultTextStyle,
// //                   ),
// //                   Text(
// //                     bmiResult,
// //                     style: kBMITextStyle,
// //                   ),
// //                   Text(
// //                     interpretation,
// //                     textAlign: TextAlign.center,
// //                     style: kBodyTextStyle,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           BottomButton(
// //             buttonTitle: 'RE-CHECK',
// //             onTap: () {
// //               Navigator.pop(context);
// //             },
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
