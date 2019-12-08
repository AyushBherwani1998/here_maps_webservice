import 'package:flutter/material.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';

class GeoCoding extends StatefulWidget {
  @override
  _GeoCodingState createState() => _GeoCodingState();
}

class _GeoCodingState extends State<GeoCoding> {
  Map<String, dynamic> latLon = Map();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      final text = _searchController.text;
      _searchController.value = _searchController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GeoCoding"),
      ),
      body: Column(
        children: <Widget>[
          getSearchBar(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: latLon.isNotEmpty
                  ? Text("${latLon['Latitude']},${latLon['Longitude']}")
                  : Text("No Results"),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                getGeoCode();
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(24),
              color: Colors.blueAccent,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "GeoCode",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  getSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        child: TextField(
          controller: _searchController,
          onChanged: ((value) {
            setState(() {
              _searchController.text = value;
            });
            print(_searchController.text);
          }),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            hintText: "Geocode Query",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(0))),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  void getGeoCode() {
    HereMaps(appId: "yourAppId", appCode: "youAppCode")
        .geoCode(searchText: _searchController.text)
        .then((response) {
      print(response['Response']['View'][0]['Result'][0]['Location']
          ['DisplayPosition']);
      setState(() {
        latLon = response['Response']['View'][0]['Result'][0]['Location']
            ['DisplayPosition'];
      });
    });
  }
}
