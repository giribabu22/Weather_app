
import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/about_today.dart';
import '../services/report_hourly.dart';
import 'package:http/http.dart' as http;

class WeatherReport extends StatefulWidget{
  final String city;
  const WeatherReport({Key? key, required this.city}) : super(key: key);
  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  late Future<Map<String,dynamic>?> weather;

  Future <Map<String,dynamic>?> gettingDataWeather() async {
    try{
      final url = "https://api.openweathermap.org/data/2.5/forecast?q=${widget.city}&appid=12e9e6c099e2cbfe4280af59ce7dcd86";      
      final response = await  http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw data['message'];
      }else{
        return data;
      }
    } catch (e) {
      return throw e.toString();
    }
  }
  @override
  void initState() {
    super.initState();
    // weather = gettingDataWeather();
  }
  
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(fontFamily: AutofillHints.transactionAmount),),
        actions: [
          InkWell(
            onTap: (){
              setState(() {
                weather;
              });
            },
            child: const Icon(Icons.refresh, size: 35,),
          )
        ],
      ),
      body: FutureBuilder(
        future: gettingDataWeather(), 
        builder: ( context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }
          if (snapshot.hasError) {
            return  Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentData = data['list'][0];
          final tempData = currentData['main']['temp'];
          final currentSky = currentData['weather'][0]['main'];

          final currentHumidity = currentData['main']['humidity'];
          final currentPressure = currentData['main']['pressure'];
          final currentWindSpeed = currentData['wind']['speed'];

          final listOfreport = data['list'];
          return  Padding(
            padding: const  EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Today', style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Text('${data['city']['name']}, ${data['city']['country']}', style: const TextStyle(fontSize: 16),),
                      const SizedBox(height: 10,),
                      Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}', style: const TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                SizedBox(
                  child: 
                    Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: 
                      Column(
                        children: [
                          const SizedBox(height: 10,),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text('$tempData K', 
                                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10,),
                                Icon(currentSky == 'Clouds'? Icons.cloud: Icons.sunny, size: 70, color: Colors.yellowAccent,),
                                const SizedBox(height: 10,),
                                Text(currentSky, style: const TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                    )
                  )
                ),
                const SizedBox(height: 20,),
                const Text('Today Forecast', style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      for (int i = 1; i < 7; i++) 
                        ReportToday(
                          icon: listOfreport[i]['weather'][0]['main'] == 'Clouds'? Icons.cloud: Icons.sunny,
                          time: listOfreport[i]['dt_txt'].toString().substring(11,16),
                          value: listOfreport[i]['main']['temp'].toString().substring(0,3),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Text('Details Info', style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AboutToday(icon : Icons.air,title:'Wind Speed',value: currentWindSpeed.toString()),
                    AboutToday(icon : Icons.water_drop,title:'Humidity',value:currentHumidity.toString()),
                    AboutToday(icon : Icons.beach_access,title:'Pressure',value: currentPressure.toString()),
                  ],
                )
              ],
            )
          );
        }
      )
    );
  }
}
