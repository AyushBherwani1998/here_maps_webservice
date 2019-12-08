import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here_maps/here_maps.dart';
import 'package:location/location.dart' as l;
import 'package:flutter/services.dart';

class ReverseGeoCoding extends StatefulWidget {
  @override
  _ReverseGeoCodingState createState() => _ReverseGeoCodingState();
}

class _ReverseGeoCodingState extends State<ReverseGeoCoding> {
  var currentLocation;
  String address;
  @override
  void initState() {
    doReverseGeoCoding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reverse GeoCoding"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(currentLocation!=null?
                "${currentLocation.latitude},${currentLocation.longitude}":"Loading"),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(address??"Loading"),
          )
        ],
      ),
    );
  }

  void doReverseGeoCoding() async {
    var location = new l.Location();

    try {
      await location.getLocation().then((location) {
        print(location);
        setState(() {
          currentLocation = location;
        });
      });
      HereMaps(appId: "4tnnFEQwe0pLywZzFGUp", appCode: "xTchV_ZrdfjkVO-0cyMz6Q")
          .reverseGeoCode(mode: ReverseGeoCodeModes.retrieveAreas,
              lat: currentLocation.latitude, lon: currentLocation.longitude)
          .then((response) {
        print(response);
        setState(() {
          address = response['Response']['View'][0]['Result'][0]['Location']
          ['Address']['Label'];
        });
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
  }
}
