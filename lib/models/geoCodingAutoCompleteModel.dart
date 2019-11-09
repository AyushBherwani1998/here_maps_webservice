import 'dart:convert';

GeoCodingAutoComplete geoCodingAutoCompleteFromJson(String str) => GeoCodingAutoComplete.fromJson(json.decode(str));

String geoCodingAutoCompleteToJson(GeoCodingAutoComplete data) => json.encode(data.toJson());

class GeoCodingAutoComplete {
  List<Suggestion> suggestions;

  GeoCodingAutoComplete({
    this.suggestions,
  });

  factory GeoCodingAutoComplete.fromJson(Map<String, dynamic> json) => GeoCodingAutoComplete(
    suggestions: List<Suggestion>.from(json["suggestions"]?.map((x) => Suggestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
  };
}

class Suggestion {
  String label;
  String language;
  String countryCode;
  String locationId;
  Address address;
  String matchLevel;

  Suggestion({
    this.label,
    this.language,
    this.countryCode,
    this.locationId,
    this.address,
    this.matchLevel,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
    label: json["label"],
    language: json["language"],
    countryCode: json["countryCode"],
    locationId: json["locationId"],
    address: Address.fromJson(json["address"]),
    matchLevel: json["matchLevel"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "language": language,
    "countryCode": countryCode,
    "locationId": locationId,
    "address": address.toJson(),
    "matchLevel": matchLevel,
  };
}

class Address {
  String country;
  String state;
  String county;
  String city;
  String postalCode;

  Address({
    this.country,
    this.state,
    this.county,
    this.city,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"],
    state: json["state"],
    county: json["county"] == null ? null : json["county"],
    city: json["city"] == null ? null : json["city"],
    postalCode: json["postalCode"] == null ? null : json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "state": state,
    "county": county == null ? null : county,
    "city": city == null ? null : city,
    "postalCode": postalCode == null ? null : postalCode,
  };
}