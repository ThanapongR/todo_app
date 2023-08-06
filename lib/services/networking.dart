import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final Uri url;

  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
