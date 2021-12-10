import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MaterialApp(
    title:"Weather App",
    home:MyApp() ),);
}
class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  var temp;
  var desc;
  var curr;
  var humid;
  var wind;
  Future getData() async{
    http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Indore&units=metric&appid=4144bc523f83bc3b48adbf54ca8bacf5"));
    var res=jsonDecode(response.body);
    setState(() {
      this.temp=res['main']['temp'];
      this.desc=res['weather'][0]['description'];
      this.curr=res['weather'][0]['main'];
      this.humid=res['main']['humidity'];
      this.wind=res['wind']['speed'];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: <Widget>[
            Image(image:AssetImage('Assets/GDSC.jpeg'))
            ,Text("  Weather App"),
          ],
        ),
        centerTitle: true,
        
        ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child:Text('Currently in Indore',style: TextStyle(
                    fontSize:25,
                    fontWeight: FontWeight.w600
                  )),),
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child:Text(temp!=null ? temp.toString()+'\u00B0'+"C":"Loading",style: TextStyle(
                    fontSize:50,
                    fontWeight: FontWeight.w600
                  ),)),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,10,20,0),
                  child:Text(curr!=null ? curr.toString():"Loading",style: TextStyle(
                    fontSize:25,
                    fontWeight: FontWeight.w600
                  ),)),  
            ],),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometer),
                    title: Text("Temperature"),
                    trailing:Text(temp!=null ? temp.toString()+'\u00B0'+"C":"Loading"),
                    tileColor: Colors.white,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing:Text(desc!=null ? desc.toString():"Loading"),
                    tileColor: Colors.white,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing:Text(humid!=null ? humid.toString():"Loading"),
                    tileColor: Colors.white,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing:Text(wind!=null ? wind.toString():"Loading"),
                    tileColor: Colors.white,
                  )
                ],
              ),),
          )
        ],),
    );
  }
}