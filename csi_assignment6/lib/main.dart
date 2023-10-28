import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoding/geocoding.dart';
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
        primarySwatch: Colors.deepPurple,
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
  var latitude;
  var longitude;
  var currentAddress;
  bool check = false;

  void _Checkper() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitude = position.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      check = true;
      currentAddress = "${place.locality},${place.postalCode},${place.country}";
    });
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result =
        await sendSMS(message: message, recipients: recipents).toString();
  }

  List<String> recipents = ["9960935030"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            check ? Text(currentAddress) : Container(),
            check ? Text('Latitude = $latitude') : Container(),
            check ? Text('Longitude = $longitude') : Container(),
            TextButton(
                onPressed: () {
                  _Checkper();
                },
                child: Text(
                  'Locate Me',
                  style: TextStyle(fontSize: 20),
                )),
            TextButton(
                onPressed: (() {
                  _sendSMS("Location",
                      recipents); //_sendSMS(currentAddress, recipents);
                }),
                child: Text('Send SMS'))
          ],
        ),
      ),
    );
  }
}
