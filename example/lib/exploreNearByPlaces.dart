import 'package:flutter/material.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';
import 'package:location/location.dart' as l;
import 'package:flutter/services.dart';

class ExploreNearbyPlaces extends StatefulWidget {

  @override
  _ExploreNearbyPlacesState createState() => _ExploreNearbyPlacesState();
}

class _ExploreNearbyPlacesState extends State<ExploreNearbyPlaces> {
  List<dynamic> _explorePlace;

  @override
  void initState() {
    _explorePlace = [];
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Explore Nearby Places Example"),
      ),
      body: _explorePlace.isNotEmpty
          ? ListView.builder(
          itemCount: _explorePlace.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_explorePlace[index]['title']),
                subtitle: Text(
                    "Category: ${_explorePlace[index]['category']['title']}"),
              ),
            );
          })
          : Container(
        alignment: Alignment.center,
        child: LinearProgressIndicator(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void getLocation() async {
    var currentLocation;
    var location = new l.Location();

    try {
      currentLocation = await location.getLocation();
      HereMaps(appId: "yourAppId", appCode: "youAppCode")
          .exploreNearbyPlaces(
          lat: currentLocation.latitude, lon: currentLocation.longitude,offset: 10)
          .then((response) {
        print(response);
        setState(() {
          _explorePlace.addAll(response['results']['items']);
        });
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
  }
}
