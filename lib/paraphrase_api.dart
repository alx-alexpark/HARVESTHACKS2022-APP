import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:harvesthacks2022/firebase_options.dart';
import 'package:intl/number_symbols_data.dart';

class ApiUtil {
  static Map<int, double> temps = {1: 0.4, 2: 0.7, 3: 1};
  static double currentTemp = 0.7;

  static Future<String> paraphrase(String input) async {
    // only reason im using firebase_options.dart is because it is a file already already in .gitignore.
    final queryParameters = {
      'text': input,
      'token': DefaultFirebaseOptions.token,
      'temp': currentTemp,
    };
    var url = Uri.https(
        'RefactoringAPI.bernygg.repl.co', '/paraphrase', queryParameters);
    final response = await http.get(url);
    return jsonDecode(response.body)["text"];
  }

  static void setTemp(int i) {
    currentTemp = temps[i]!;
    print("Temp changed");
  }
}
