import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper{

  Future<dynamic> getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    String data = response.body;
    print(response.statusCode);
    if(response.statusCode == 200){
      var wordData = jsonDecode(data);
      return wordData;
    } else {
      print(response.statusCode);
    }
  }
}