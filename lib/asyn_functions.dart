import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchHealthData() async {
  final String url =
      "https://smartsystem-17bb5-default-rtdb.firebaseio.com/data.json";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching data: $e");
  }

  return null; // Return null if an error occurs
}
