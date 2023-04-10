import 'dart:convert';
import 'package:http/http.dart' as http;

class Countries {

  List<Data>? data;
  Countries({this.data});

  Countries.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}
class Data {
  String? name;
  Data({this.name,});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Services {
  static const String url = "https://countriesnow.space/api/v0.1/countries/flag/images";

  static Future<List<Data>> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final countriesList = Countries.fromJson(jsonData);
      return countriesList.data!;
    } else {
      throw Exception('Failed to load data');
    }
  }

}
