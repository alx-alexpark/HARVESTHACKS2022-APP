import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:harvesthacks2022/firebase_options.dart';

class ApiUtil {
  static List<double> temps = [0.4, 0.7, 1];
  static List<String> models = [
    "text-ada-001",
    "text-babbage-001",
    "text-curie-001",
    "text-davinci-002"
  ];
  static double currentTemp = 0.7;
  static String currentModel = "text-curie-001";

  static Future<String> paraphrase(String input) async {
    // only reason im using firebase_options.dart is because it is a file already already in .gitignore.
    final queryParameters = {
      'token': DefaultFirebaseOptions.token,
      'text': input,
      'temp': currentTemp.toString(),
      'model': currentModel.toString(),
    };
    print('a');
    var url = Uri.https(
        'RefactoringAPI.bernygg.repl.co', '/paraphrase', queryParameters);
    print('b');
    final response = await http.get(url);
    print('c');
    return jsonDecode(response.body)["text"];
  }

  static void setTemp(int i) {
    currentTemp = temps[i];
    print("Temp changed");
  }

  static void setModel(int i) {
    currentModel = models[i];
    print("Model changed");
  }
}
