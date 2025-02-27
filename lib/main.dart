import 'package:flutter/material.dart';
import 'package:medshield/screens/input_page.dart';
import 'package:device_preview/device_preview.dart'; // Helper method for reusable text boxes
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Connects to Firebase
  runApp(HealthMonitor());
}

class HealthMonitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      title: 'MedShield',
      home: InputPage(),
    );
  }
}
