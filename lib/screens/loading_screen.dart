import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // getLocation();
            getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      String name = decodedData['name'];
      double temp = decodedData['main']['temp'];
      int id = decodedData['weather'][0]['id'];

      print(name);
      print(temp);
      print(id);
    } else {
      print(response.statusCode);
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }
}
