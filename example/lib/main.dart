import 'package:example/exploreNearByPlaces.dart';
import 'package:example/explorePopularPLaces.dart';
import 'package:example/geoCoding.dart';
import 'package:example/geoCodingAutoComplete.dart';
import 'package:example/reverseGeoCoding.dart';
import 'package:flutter/material.dart';

/// Example to show nearby places around you

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'HereMaps Web Service Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExploreNearbyPlaces()));
            },
            child: getContainer("Nearby Places"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExplorePopularPlaces()));
            },
            child: getContainer("Popular Places"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GeoCodingAutoComplete()));
            },
            child: getContainer("GeoCoding Auto Complete"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GeoCoding()));
            },
            child: getContainer("GeoCoding"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ReverseGeoCoding()));
            },
            child: getContainer("Reverse GeoCoding"),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getContainer(String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(24),
      color: Colors.blueAccent,
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
