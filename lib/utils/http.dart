import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Http {
    final client = http.Client();

  Future<dynamic> get(String url, [String? query]) async {
    final response = await client.get(
      Uri.parse(url),
      headers: <String, String>{'Accept': 'application/json'},
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(
      {required String url, Object? body, String? query}) async {
    final String encodedData = json.encode(body);
    final response = await client.post(Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'content-type': 'application/json'
        },
        body: encodedData);

    return _handleResponse(response);
  }


  dynamic _handleResponse(http.Response response) {
    try {
      if (response.body.isEmpty || response.statusCode != 200) {
        return null;
      }
      dynamic json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return json;
      }
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
