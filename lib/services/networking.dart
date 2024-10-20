import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking(@required this.url);

  final url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return response.statusCode;
    }
  }
}
