import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:harvesthacks2022/firebase_options.dart';

class ApiUtil {
  static Future<String> paraphrase(String input) async {
    // only reason im using firebase_options.dart is because it is a file already already in .gitignore.
    final queryParameters = {
      'text': input,
      'token': DefaultFirebaseOptions.token
    };
    var url = Uri.https(
        'RefactoringAPI.bernygg.repl.co', '/paraphrase', queryParameters);
    final response = await http.get(url);
    return jsonDecode(response.body)["text"];
  }
}
