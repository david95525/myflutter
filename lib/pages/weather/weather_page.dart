import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/models/weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel? weather;
  static const String authorizationkey =
      String.fromEnvironment('authorization_key');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather API Sample'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                weather != null ? "時間: ${weather?.datetime}" : "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                weather != null ? "${weather?.weatherDescription}" : "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                "${CustomLocalizations.of(context)?.text("Averagetemp")}:${weather?.temperature}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              )
            ]),
      ),
    );
  }

  void fetchData() async {
    if (authorizationkey.isEmpty) {
      throw AssertionError('TMDB_KEY is not set');
    }
    const timeout = Duration(seconds: 10);
    var url =
        Uri.https('opendata.cwa.gov.tw', '/api/v1/rest/datastore/F-D0047-063', {
      'Authorization': authorizationkey,
      'format': 'JSON',
      'locationName': '南港區',
      'elementName': 'MinT,MaxT,PoP12h,T,Wx,WeatherDescription',
      'sort': 'time',
      'timeFrom': DateTime.now().toIso8601String(),
      'timeTo': DateTime.now().add(const Duration(days: 1)).toIso8601String()
    });
    var response = await http.get(url).timeout(timeout);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonmap = jsonDecode(response.body);
      setState(() {
        weather = WeatherModel(
            id: "01",
            temperature: int.parse(jsonmap['records']['locations'][0]
                    ['location'][0]['weatherElement'][1]['time'][0]
                ['elementValue'][0]['value'] as String),
            minTemperature: 0,
            maxTemperature: 0,
            weatherTypes: 0,
            weatherDescription: jsonmap['records']['locations'][0]['location'][0]['weatherElement']
                [4]['time'][0]['elementValue'][0]['value'] as String,
            datetime: jsonmap['records']['locations'][0]['location'][0]
                ['weatherElement'][4]['time'][0]['startTime'] as String);
      });
    } else {
      throw Exception();
    }
  }
}
