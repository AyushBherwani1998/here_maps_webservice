import 'package:flutter/material.dart';
import 'package:here_maps/here_maps.dart';
import 'package:here_maps/models/exploreNearbyPlacesModel.dart';
import 'package:location/location.dart' as l;
import 'package:flutter/services.dart';

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
      home: MyHomePage(title: 'Explore Nearby Places Example'),
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
  Future<List<Item>> _explorePlace;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Item>>(
        future: _explorePlace,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(
                          "Category: ${snapshot.data[index].category.title}"),
                    ),
                  );
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void getLocation() async {
    var currentLocation;
    var location = new l.Location();

    try {
      currentLocation = await location.getLocation();
      setState(() {
        _explorePlace = HereMaps(appId: null, appCode: null)
            .exploreNearbyPlaces(
                lat: currentLocation.latitude.toString(),
                lon: currentLocation.longitude.toString());
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
  }
}
