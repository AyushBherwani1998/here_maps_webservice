import 'package:flutter/material.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';
import 'package:location/location.dart' as l;
import 'package:flutter/services.dart';

class ExplorePopularPlaces extends StatefulWidget {
  @override
  _ExplorePopularPlacesState createState() => _ExplorePopularPlacesState();
}

class _ExplorePopularPlacesState extends State<ExplorePopularPlaces> {
  List<dynamic> _explorePopularPlace;

  @override
  void initState() {
    _explorePopularPlace = [];
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Explore Popular Places Example"),
      ),
      body: _explorePopularPlace.isNotEmpty
          ? ListView.builder(
              itemCount: _explorePopularPlace.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_explorePopularPlace[index]['title']),
                    subtitle: Text(
                        "Category: ${_explorePopularPlace[index]['category']['title']}"),
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
      HereMaps(apiKey: "your apiKey")
          .explorePopularPlaces(
              lat: currentLocation.latitude,
              lon: currentLocation.longitude,
              offset: 10)
          .then((response) {
        print(response);
        setState(() {
          _explorePopularPlace.addAll(response['results']['items']);
        });
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
  }
}
