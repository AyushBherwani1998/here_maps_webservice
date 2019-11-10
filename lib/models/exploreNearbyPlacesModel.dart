import 'dart:convert';

Places placesFromJson(String str) => Places.fromJson(json.decode(str));

String placesToJson(Places data) => json.encode(data.toJson());

class Places {
  Results results;
  Search search;

  Places({
    this.results,
    this.search,
  });

  factory Places.fromJson(Map<String, dynamic> json) => Places(
    results: Results.fromJson(json["results"]),
    search: Search.fromJson(json["search"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "search": search.toJson(),
  };
}

class Results {
  List<Item> items;

  Results({
    this.items,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  List<double> position;
  int distance;
  String title;
  double averageRating;
  Category category;
  String icon;
  String vicinity;
  List<dynamic> having;
  ItemType type;
  String href;
  String id;
  List<Tag> tags;
  List<String> chainIds;

  Item({
    this.position,
    this.distance,
    this.title,
    this.averageRating,
    this.category,
    this.icon,
    this.vicinity,
    this.having,
    this.type,
    this.href,
    this.id,
    this.tags,
    this.chainIds,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    position: List<double>.from(json["position"].map((x) => x.toDouble())),
    distance: json["distance"],
    title: json["title"],
    averageRating: json["averageRating"],
    category: Category.fromJson(json["category"]),
    icon: json["icon"],
    vicinity: json["vicinity"],
    having: List<dynamic>.from(json["having"].map((x) => x)),
    type: itemTypeValues.map[json["type"]],
    href: json["href"],
    id: json["id"],
    tags: json["tags"] == null ? null : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    chainIds: json["chainIds"] == null ? null : List<String>.from(json["chainIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "position": List<dynamic>.from(position.map((x) => x.toDouble())),
    "distance": distance,
    "title": title,
    "averageRating": averageRating,
    "category": category.toJson(),
    "icon": icon,
    "vicinity": vicinity,
    "having": List<dynamic>.from(having.map((x) => x)),
    "type": itemTypeValues.reverse[type],
    "href": href,
    "id": id,
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x.toJson())),
    "chainIds": chainIds == null ? null : List<dynamic>.from(chainIds.map((x) => x)),
  };
}

class Category {
  String id;
  String title;
  String href;
  CategoryType type;
  System system;

  Category({
    this.id,
    this.title,
    this.href,
    this.type,
    this.system,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    href: json["href"],
    type: categoryTypeValues.map[json["type"]],
    system: systemValues.map[json["system"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "href": href,
    "type": categoryTypeValues.reverse[type],
    "system": systemValues.reverse[system],
  };
}

enum System { PLACES }

final systemValues = EnumValues({
  "places": System.PLACES
});

enum CategoryType { URN_NLP_TYPES_CATEGORY }

final categoryTypeValues = EnumValues({
  "urn:nlp-types:category": CategoryType.URN_NLP_TYPES_CATEGORY
});

class Tag {
  String id;
  String title;
  String group;

  Tag({
    this.id,
    this.title,
    this.group,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    title: json["title"],
    group: json["group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "group": group,
  };
}

enum ItemType { URN_NLP_TYPES_PLACE }

final itemTypeValues = EnumValues({
  "urn:nlp-types:place": ItemType.URN_NLP_TYPES_PLACE
});

class Search {
  Context context;

  Search({
    this.context,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    context: Context.fromJson(json["context"]),
  );

  Map<String, dynamic> toJson() => {
    "context": context.toJson(),
  };
}

class Context {
  Location location;
  ItemType type;
  String href;

  Context({
    this.location,
    this.type,
    this.href,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
    location: Location.fromJson(json["location"]),
    type: itemTypeValues.map[json["type"]],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "type": itemTypeValues.reverse[type],
    "href": href,
  };
}

class Location {
  List<double> position;
  Address address;

  Location({
    this.position,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    position: List<double>.from(json["position"].map((x) => x.toDouble())),
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "position": List<dynamic>.from(position.map((x) => x)),
    "address": address.toJson(),
  };
}

class Address {
  String text;
  String house;
  String postalCode;
  String district;
  String city;
  String county;
  String stateCode;
  String country;
  String countryCode;

  Address({
    this.text,
    this.house,
    this.postalCode,
    this.district,
    this.city,
    this.county,
    this.stateCode,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    text: json["text"],
    house: json["house"],
    postalCode: json["postalCode"],
    district: json["district"],
    city: json["city"],
    county: json["county"],
    stateCode: json["stateCode"],
    country: json["country"],
    countryCode: json["countryCode"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "house": house,
    "postalCode": postalCode,
    "district": district,
    "city": city,
    "county": county,
    "stateCode": stateCode,
    "country": country,
    "countryCode": countryCode,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
