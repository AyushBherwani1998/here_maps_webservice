
import 'dart:convert';

GeoCoding geoCodingFromJson(String str) => GeoCoding.fromJson(json.decode(str));

String geoCodingToJson(GeoCoding data) => json.encode(data.toJson());

class GeoCoding {
  Response response;

  GeoCoding({
    this.response,
  });

  factory GeoCoding.fromJson(Map<String, dynamic> json) => GeoCoding(
    response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response.toJson(),
  };
}

class Response {
  List<View> view;

  Response({
    this.view,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    view: List<View>.from(json["View"].map((x) => View.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "View": List<dynamic>.from(view.map((x) => x.toJson())),
  };
}

class View {
  String type;
  int viewId;
  List<Result> result;

  View({
    this.type,
    this.viewId,
    this.result,
  });

  factory View.fromJson(Map<String, dynamic> json) => View(
    type: json["_type"],
    viewId: json["ViewId"],
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_type": type,
    "ViewId": viewId,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  double relevance;
  String matchLevel;
  MatchQuality matchQuality;
  String matchType;
  Location location;

  Result({
    this.relevance,
    this.matchLevel,
    this.matchQuality,
    this.matchType,
    this.location,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    relevance: json["Relevance"],
    matchLevel: json["MatchLevel"],
    matchQuality: MatchQuality.fromJson(json["MatchQuality"]),
    matchType: json["MatchType"],
    location: Location.fromJson(json["Location"]),
  );

  Map<String, dynamic> toJson() => {
    "Relevance": relevance,
    "MatchLevel": matchLevel,
    "MatchQuality": matchQuality.toJson(),
    "MatchType": matchType,
    "Location": location.toJson(),
  };
}

class Location {
  String locationId;
  String locationType;
  DisplayPosition displayPosition;
  List<DisplayPosition> navigationPosition;
  MapView mapView;
  Address address;

  Location({
    this.locationId,
    this.locationType,
    this.displayPosition,
    this.navigationPosition,
    this.mapView,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationId: json["LocationId"],
    locationType: json["LocationType"],
    displayPosition: DisplayPosition.fromJson(json["DisplayPosition"]),
    navigationPosition: List<DisplayPosition>.from(json["NavigationPosition"].map((x) => DisplayPosition.fromJson(x))),
    mapView: MapView.fromJson(json["MapView"]),
    address: Address.fromJson(json["Address"]),
  );

  Map<String, dynamic> toJson() => {
    "LocationId": locationId,
    "LocationType": locationType,
    "DisplayPosition": displayPosition.toJson(),
    "NavigationPosition": List<dynamic>.from(navigationPosition.map((x) => x.toJson())),
    "MapView": mapView.toJson(),
    "Address": address.toJson(),
  };
}

class Address {
  String label;
  String country;
  String state;
  String county;
  String city;
  String district;
  String street;
  String houseNumber;
  String postalCode;
  List<AdditionalDatum> additionalData;

  Address({
    this.label,
    this.country,
    this.state,
    this.county,
    this.city,
    this.district,
    this.street,
    this.houseNumber,
    this.postalCode,
    this.additionalData,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    label: json["Label"],
    country: json["Country"],
    state: json["State"],
    county: json["County"],
    city: json["City"],
    district: json["District"],
    street: json["Street"],
    houseNumber: json["HouseNumber"],
    postalCode: json["PostalCode"],
    additionalData: List<AdditionalDatum>.from(json["AdditionalData"].map((x) => AdditionalDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Label": label,
    "Country": country,
    "State": state,
    "County": county,
    "City": city,
    "District": district,
    "Street": street,
    "HouseNumber": houseNumber,
    "PostalCode": postalCode,
    "AdditionalData": List<dynamic>.from(additionalData.map((x) => x.toJson())),
  };
}

class AdditionalDatum {
  String value;
  String key;

  AdditionalDatum({
    this.value,
    this.key,
  });

  factory AdditionalDatum.fromJson(Map<String, dynamic> json) => AdditionalDatum(
    value: json["value"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "key": key,
  };
}

class DisplayPosition {
  double latitude;
  double longitude;

  DisplayPosition({
    this.latitude,
    this.longitude,
  });

  factory DisplayPosition.fromJson(Map<String, dynamic> json) => DisplayPosition(
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Latitude": latitude,
    "Longitude": longitude,
  };
}

class MapView {
  DisplayPosition topLeft;
  DisplayPosition bottomRight;

  MapView({
    this.topLeft,
    this.bottomRight,
  });

  factory MapView.fromJson(Map<String, dynamic> json) => MapView(
    topLeft: DisplayPosition.fromJson(json["TopLeft"]),
    bottomRight: DisplayPosition.fromJson(json["BottomRight"]),
  );

  Map<String, dynamic> toJson() => {
    "TopLeft": topLeft.toJson(),
    "BottomRight": bottomRight.toJson(),
  };
}

class MatchQuality {
  double state;
  double city;
  List<double> street;
  int houseNumber;

  MatchQuality({
    this.state,
    this.city,
    this.houseNumber,
  });

  factory MatchQuality.fromJson(Map<String, dynamic> json) => MatchQuality(
    state: json["State"],
    city: json["City"],
    houseNumber: json["HouseNumber"],
  );

  Map<String, dynamic> toJson() => {
    "State": state,
    "City": city,
    "Street": List<dynamic>.from(street.map((x) => x)),
    "HouseNumber": houseNumber,
  };
}
