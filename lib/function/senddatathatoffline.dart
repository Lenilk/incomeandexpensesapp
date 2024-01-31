import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './ip.dart';

void sendDataThatOffline(Map<String, dynamic> data) {
  switch (data['type']) {
    case 'POST':
    case 'UPDATE':
    case 'DELETE':
  }
}

Future<bool> postData(Map<String, dynamic> data, BuildContext context) async {
  Map<String, String> header = {'Content-type': 'application/json'};
  http.Response response = await http
      .post(Uri.parse('$ip/createData'), body: data, headers: header)
      .timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('error', 404),
      );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
