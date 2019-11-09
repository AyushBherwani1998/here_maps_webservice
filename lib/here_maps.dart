library here_maps;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:here_maps/models/exploreNearbyPlacesModel.dart';
import 'package:here_maps/models/geoCodingAutoCompleteModel.dart';
import 'package:here_maps/models/geoCodingModel.dart';
import 'package:http/http.dart' as http;

class HereMaps {
  final String appId;
  final String appCode;

  HereMaps({@required this.appId, @required this.appCode})
      : assert(appId != null, "appId can't be null"),
        assert(appCode != null, "appCode can't be null");

  /// Returns a list of places close to a location

  Future<List<Item>> exploreNearbyPlaces(
      {@required double lat, @required double lon, int offset}) async {
    assert(lat != null, "lat can't be null");
    assert(lon != null, "lon can't be null");
    assert(offset >= 0, "offset can't be negative");

    var _headers = {
      "Accept": "application/json",
    };

    Map<String, String> body = Map();
    body["at"] = '$lat,$lon';
    body['size'] = offset?.toString() ?? "20";
    body["app_id"] = this.appId;
    body["app_code"] = this.appCode;

    var uri = Uri.http('places.api.here.com', '/places/v1/discover/here', body);
    http.Response response = await http.get(uri, headers: _headers);
    return NearbyPlaces.fromJson(json.decode(response.body)).results.items;
  }

  ///Get better search suggestions for your addresses with fewer keystrokes.

  Future<List<Suggestion>> geoCodingAutoComplete(
      {@required String query}) async {
    assert(query != null, "query can't be null");
    var _headers = {
      "Accept": "application/json",
    };
    Map<String, String> data = Map();
    data["query"] = query;
    data["app_id"] = this.appId;
    data["app_code"] = this.appCode;

    var uri = Uri.http(
        'autocomplete.geocoder.api.here.com', '/6.2/suggest.json', data);
    http.Response response = await http.get(uri, headers: _headers);
    return GeoCodingAutoComplete.fromJson(json.decode(response.body))
        .suggestions;
  }

  /// Submit the name of a known landmark to request the corresponding geo-coordinates.
  Future<Map<String, dynamic>> geoCoder(
      {@required String searchText, @required GeoCoder queryType}) async {

    assert(searchText != null, "searchText can't be null");
    assert(queryType != null, "queryType can't be null");

    var _headers = {
      "Accept": "application/json",
    };
    Map<String, String> data = Map();
    data["searchtext"] = searchText;
    data["app_id"] = this.appId;
    data["app_code"] = this.appCode;

    var uri = Uri.http('geocoder.api.here.com', '/6.2/geocode.json', data);
    http.Response response = await http.get(uri, headers: _headers);
    if (GeoCoder.coordinates == queryType)
      return GeoCoding.fromJson(json.decode(response.body))
          .response
          .view[0]
          .result[0]
          .location
          .displayPosition
          .toJson();
    return {"errro": "Please Select a valid option"};
  }
}

enum GeoCoder {
  coordinates,
}
