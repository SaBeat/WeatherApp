import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var temp;
  var description;
  var humidity;
  var currently;
  var windSpeed;

  Future getWeather() async{
    http.Response response=await http.get('http://api.openweathermap.org/data/2.5/weather?q=Sabirabad&units=metric&appid=29a157ca62b332a350c1a49c542d092c');
    var results=jsonDecode(response.body);
    setState(() {
      this.temp=results['main']['temp'];
      this.description=results['weather'][0]['description'];
      this.humidity=results['main']['humidity'];
      this.currently=results['weather'][0]['main'];
      this.windSpeed=results['wind']['speed'];
    });
  }
  @override
  void initState() {
    super.initState();
    getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[400],
        title: Text(
          'WeatherApp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            color: Colors.red[500],
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30,top: 15),

                  child: Text(
                   'Sabirabad',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                //SizedBox(height: 5),
                Text(
                 temp!=null?temp.toString()+'°C' :' Loading',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    currently!=null?currently.toString():'Loading',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.thermostat_outlined),
                    onTap: (){},
                    title: Text('Temperature'),
                    trailing: Text(temp!=null?temp.toString()+'52':'Loading'),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud),
                    onTap: (){},
                    title: Text('Cloud'),
                    trailing: Text(description!=null?description.toString():'Loading'),
                  ),
                  ListTile(
                    leading: Icon(Icons.wb_sunny),
                    onTap: (){},
                    title: Text('Humidity'),
                    trailing: Text(humidity!=null?humidity.toString():'Loading'),
                  ),
                  ListTile(
                    leading: Icon(Icons.fast_rewind),
                    onTap: (){},
                    title: Text('Wind Speed'),
                    trailing: Text(windSpeed!=null?windSpeed.toString():'Loading'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
