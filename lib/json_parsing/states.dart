import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryStates {
  StatesData? data;
  CountryStates({this.data});
  CountryStates.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? StatesData.fromJson(json['data']) : null;
  }

}
class StatesData {
  List<States>? states;
  StatesData({this.states});
  StatesData.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
  }
}

class States {
  String? name;
  States({this.name,});

  States.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}


class CountryStatesServices{
  // static const String url = "https://countriesnow.space/api/v0.1/countries/states/q?country=Afghanistan";
  static Future<List<States>> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final countriesList = CountryStates.fromJson(jsonData);
      return countriesList.data!.states!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}