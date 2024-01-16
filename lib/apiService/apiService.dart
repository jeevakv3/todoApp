import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> getData() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('exception $e');
    }
  }
}
