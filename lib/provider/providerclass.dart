import 'package:flutter/foundation.dart';
import '../json_parsing/cities.dart';
import '../json_parsing/countries.dart';
import '../json_parsing/states.dart';


class ProviderScenes with ChangeNotifier{

  String? selectedCountry;
  String? selectedStateValue;
  String? selectedcitiesValue;
  Future <List<Data>> load() async {
    List<Data> countriesList = await Services.fetchData();
    return countriesList;
  }

  void selectedScene(String val){
    selectedCountry = val;
    selectedStateValue = null;
    selectedcitiesValue = null;
    notifyListeners();
  }

  Future <List<States>> loadStates() async {
      String url = "https://countriesnow.space/api/v0.1/countries/states/q?country=$selectedCountry";
      List<States> statesList = await CountryStatesServices.fetchData(url);
    return statesList;
    }

    void selectedState(String val){
    selectedStateValue = val;
    selectedcitiesValue = null;
    notifyListeners();
  }
  Future <List<String>> loadCities()async {
    String url = "https://countriesnow.space/api/v0.1/countries/state/cities/q?country=$selectedCountry&state=$selectedStateValue";
    List<String> citiesList = await CitiesServices.fetchData(url);
    return citiesList;
  }
  void selectedCities(String val){
    selectedcitiesValue = val;
    notifyListeners();
  }
  }




  

  
  // Future <List<States>> loadStates1(){
    
  // }

