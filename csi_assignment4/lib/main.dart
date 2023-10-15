import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'display.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var latitude = 18.520760;
  var longitude = 73.855408;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // latitude = position.latitude;
    // longitude = position.longitude;

    http.Response response = await http.get(Uri.parse(
        'https://fcc-weather-api.glitch.me/api/current?lat=$latitude&lon=$longitude'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedWeather = jsonDecode(data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DisplayWeather(
              weatherLocation: decodedWeather,
            );
          },
        ),
      );
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: null,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
