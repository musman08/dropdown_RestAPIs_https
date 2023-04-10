import 'package:http/http.dart' as http;
import 'dart:convert';

class CitiesStates {
  List<String>? data;

  CitiesStates({this.data});

  CitiesStates.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }
}
class CitiesServices {
  // static const String url = "https://countriesnow.space/api/v0.1/countries/flag/images";

  static Future<List<String>> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final citiesList = CitiesStates.fromJson(jsonData);
      return citiesList.data!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}