library here_maps;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// [apiKey] can be obtained from the REST section
/// given under the Freemium Projects

class HereMaps {
  final String apiKey;

  HereMaps({@required this.apiKey})
      : assert(apiKey != null, "apiKey can't be null");

  /// exploreNearbyPlaces returns a List of places near the center of the [lat] and [lon] given
  /// [offset] can be given to set the number of results returned by exploreNearbyPlaces
  /// By default the value of [offset] is set to 20
  /// [nextUrl] can be given to fetch the next set of results

  Future<Map<String, dynamic>> exploreNearbyPlaces(
      {@required double lat,
      @required double lon,
      int offset = 20,
      String nextUrl}) async {
    assert(lat != null, "lat can't be null");
    assert(lon != null, "lon can't be null");
    assert(offset >= 0, "offset can't be negative");

    var _headers = {
      "Accept": "application/json",
    };

    Map<String, String> body = Map();
    body["at"] = '$lat,$lon';
    body['size'] = offset.toString();
    body["apiKey"] = this.apiKey;
    body["tf"] = "plain";

    var uri =
        Uri.https('places.ls.hereapi.com', '/places/v1/discover/here', body);
    return makeApiCall(nextUrl ?? uri, _headers);
  }

  /// exploreNearbyPlaces returns a List of popular places near the center of the [lat] and [lon] given
  /// [category] can be given to retrieve the popular places of particular [category]
  /// [offset] can be given to set the number of results returned by exploreNearbyPlaces
  /// By default the value of [offset] is set to 20
  /// [nextUrl] can be given to fetch the next set of results

  Future<Map<String, dynamic>> explorePopularPlaces(
      {@required double lat,
      @required double lon,
      Categories category,
      int offset = 20,
      String nextUrl}) async {
    assert(lat != null, "lat can't be null");
    assert(lon != null, "lon can't be null");
    assert(offset >= 0, "offset can't be negative");

    Map<String, String> categoryMap = {
      "eatAndDrink": "eat-drink",
      "goingOut": "going-out",
      "sightsMuseums": "sights-museums",
      "atmBankExchange": "atm-bank-exchange",
      "petrolStation": "petrol-station"
    };

    String cat;
    if (category != null) {
      cat = category.toString().substring(category.toString().indexOf('.') + 1);
    }
    var _headers = {
      "Accept": "application/json",
    };

    Map<String, String> body = Map();
    body["at"] = '$lat,$lon';
    if (cat != null)
      body['cat'] = categoryMap.containsKey(cat) ? categoryMap[cat] : cat;
    body['size'] = offset.toString();
    body["apiKey"] = this.apiKey;
    body["tf"] = "plain";

    var uri =
        Uri.https('places.ls.hereapi.com', '/places/v1/discover/explore', body);
    return makeApiCall(nextUrl ?? uri, _headers);
  }

  /// geoCodingAutoComplete provides better results for address searches with fewer keystrokes
  /// [query] is the mandatory parameter. The Results is returned on the basis of [query]
  /// [maxResults] can be given to restrict the suggestions based on [query]
  /// The valid value of [maxResults] is between 1 to 10

  Future<Map<String, dynamic>> geoCodingAutoComplete(
      {@required String query, int maxResults = 1}) async {
    assert(query != null, "query can't be null");
    assert(maxResults >= 1 && maxResults <= 10, "maxResults must be between 1 and 10");
    var _headers = {
      "Accept": "application/json",
    };
    Map<String, String> data = Map();
    data["query"] = query;
    data["apiKey"] = this.apiKey;
    data['maxResults'] = '$maxResults';

    var uri = Uri.https(
        'autocomplete.geocoder.ls.hereapi.com', '/6.2/suggest.json', data);
    return makeApiCall(uri, _headers);
  }

  /// geoCode can be used to retrieves the latitude, longitude and complete address details
  /// based on the [searchText] provided

  Future<Map<String, dynamic>> geoCode({@required String searchText}) async {
    assert(searchText != null, "searchText can't be null");

    var _headers = {
      "Accept": "application/json",
    };
    Map<String, String> data = Map();
    data["searchtext"] = searchText;
    data["apiKey"] = this.apiKey;

    var uri = Uri.https('geocoder.ls.hereapi.com', '/6.2/geocode.json', data);
    return makeApiCall(uri, _headers);
  }

  /// reverseGeoCode retrieves the first address around a specified [lat] & [long]
  /// using a 250 meter radius to retrieve the address.
  /// [maxResults] can be given to get the number of the Results
  /// By default value of [maxResults] is 1
  /// [mode] defines the Reverse GeCoding Mode
  /// [ReverseGeoCodeModes.retrieveAddresses] Search for the closest street address or addresses
  /// [ReverseGeoCodeModes.retrieveAreas]  Retrieve the administrative area information for the position provided in the request
  /// [ReverseGeoCodeModes.retrieveLandmarks] Search for landmarks like parks and lakes in the proximity provided in the request
  /// [ReverseGeoCodeModes.trackPosition] Retrieve street and address information based on a position and bearing
  /// [ReverseGeoCodeModes.retrieveAll] Search for streets, administrative areas and landmarks. This mode aggregates the results of the three different modes in one call

  Future<Map<String, dynamic>> reverseGeoCode(
      {@required double lat,
      @required double lon,
      ReverseGeoCodeModes mode = ReverseGeoCodeModes.retrieveAddresses,
      int maxResults = 1}) async {
    assert(lat != null, "lat can't be null");
    assert(lon != null, "lon can't be null");
    assert(maxResults <= 1, "maxResults should be greater than 1");
    var _headers = {
      "Accept": "application/json",
    };
    Map<String, String> data = Map();
    data["prox"] = '$lat,$lon';
    data["apiKey"] = this.apiKey;
    data['mode'] = mode.toString().substring(mode.toString().indexOf('.') + 1);

    var uri = Uri.https(
        'reverse.geocoder.ls.hereapi.com', '/6.2/reversegeocode.json', data);
    return makeApiCall(uri, _headers);
  }
}

/// Categories for explorePopularPlaces
enum Categories {
  eatAndDrink,
  goingOut,
  sightsMuseums,
  transport,
  accommodation,
  shopping,
  atmBankExchange,
  hospital,
  petrolStation
}

/// Modes for ReverseGeoCode
enum ReverseGeoCodeModes {
  retrieveAddresses,
  retrieveAreas,
  retrieveLandmarks,
  retrieveAll,
  trackPosition
}

Future<Map<String, dynamic>> makeApiCall(dynamic uri, Map headers) async {
  http.Response response = await http.get(uri, headers: headers);
  return json.decode(response.body);
}
