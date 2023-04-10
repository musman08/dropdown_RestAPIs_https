import 'package:dropdown_project_week5/json_parsing/states.dart';
import 'package:flutter/material.dart';
import 'json_parsing/countries.dart';
import 'package:provider/provider.dart';
import 'provider/providerclass.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: SizedBox(
      height: 400, // adjust the height based on your needs
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           const Text(
            'Countries, States & Cities', style: TextStyle(fontSize: 36),
          ),
          const  SizedBox(height: 20,),
          Expanded(
            child: Consumer<ProviderScenes>(builder: ((context, value, Widget? child){
              return FutureBuilder(
              future: value.load(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  List<Data> dataList = snapshot.data;
                  return DropdownButton(
                    value: value.selectedCountry,
                    hint: const Text("Select the country"),
                    isExpanded: true, 
                    items: dataList.map(( data){
                        return DropdownMenuItem<String>(
                          value: data.name, 
                          child:Text(data.name!),
                        );
                      }
                    ).toList(), 
                    onChanged: ( val){
                      value.selectedScene(val!);
                    },
                    );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                  // const Text("Loading data");
                }
              }
            );
            })
            )  
          ),
          // States Dropdown
          const SizedBox(height: 20,),
          Expanded( 
            child: Consumer<ProviderScenes>(builder: ((context, value, Widget? child){
              if (value.selectedCountry!=null){
                return
                FutureBuilder(
              future: value.loadStates(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  List<States> dataList = snapshot.data; 
                  return DropdownButton(
                    value: value.selectedStateValue,
                    hint: const Text("Select the State"),
                    isExpanded: true, 
                    items: dataList.map(( data){
                        return DropdownMenuItem<String>(
                          value: data.name, 
                          child:Text(data.name!),
                        );
                      }
                    ).toList(), 
                    onChanged: ( val){
                      value.selectedState(val!);
                    },
                    );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            );

              }
              else{
                return Container();
                // DropdownButton(
                //     hint: const Text("Select the country first"),
                //     isExpanded: true, 
                //     items: [], 
                //     onChanged: ( val){
                //     },
                //     );
              }
            })
            )  
          ),
          const SizedBox(height: 20,),

          // Cities Dropdown button
          Expanded( 
            child: Consumer<ProviderScenes>(builder: ((context, value, Widget? child){
              if (value.selectedCountry!=null && value.selectedStateValue!= null){
                return
                FutureBuilder(
              future: value.loadCities(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  List<String> dataList = snapshot.data; 
                  return DropdownButton(
                    value: value.selectedcitiesValue,
                    hint: const Text("Select the City"),
                    isExpanded: true, 
                    items: dataList.map(( data){
                        return DropdownMenuItem<String>(
                          value: data, 
                          child:Text(data),
                        );
                      }
                    ).toList(), 
                    onChanged: ( val){
                      value.selectedCities(val!);
                    },
                    );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            );

              }
              else{
                return Container();
                // DropdownButton(
                //     hint: const Text("Select the country and state first"),
                //     isExpanded: true, 
                //     items: [], 
                //     onChanged: ( val){
                //     },
                //     );
              }
            })
            )  
          ),

        ],
      ),
    ),
  ),
),
    );
  }
}
