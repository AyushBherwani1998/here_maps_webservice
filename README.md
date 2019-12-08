<p align="center">
  <a href="https://developer.here.com/">
    <img alt="Here" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/HERE_logo.svg/1200px-HERE_logo.svg.png" width="100" />
  </a>
</p>

## About 

`here_maps_webservice` provides Here Maps Web Services API wrapper that serve different purposes from search, to geocoding.

## Usage

Add `here_maps_webservice`as a dependency in your pubspec.yaml
```YAML
 dependencies:
  flutter:
    sdk: flutter
  here_maps_webservice: any
```
Run `flutter pub get` in the terminal and import `import 'package:here_maps_webservice/here_maps.dart'`

## Availabel APIs
- [Geocoding](https://developer.here.com/documentation/geocoder/dev_guide/topics/quick-start-geocode.html)
- [Reverse Geocoding](https://developer.here.com/documentation/geocoder/dev_guide/topics/resource-reverse-geocode.html)
- [Geocoding Autocomplete](https://developer.here.com/documentation/geocoder-autocomplete/dev_guide/topics/quick-start-get-suggestions.html)
- [Explore Nearby Places](https://developer.here.com/documentation/examples/rest/places/explore-nearby-places)
- [Explore Popular Places](https://developer.here.com/documentation/examples/rest/places/explore-popular-places)


## Generate App ID and App Code
Go to https://developer.here.com/ and create a new account if you don't have one. Create a new project and select Freemium Plan.
Under the REST & XYZ HUB API/CLI section of your project, click on Generate App ID and App Code.

## Example

##### Nearby Places
```DART
    import 'package:here_maps_webservice/here_maps.dart';
    import 'package:location/location.dart' as l; 
    import 'package:flutter/services.dart';
    
    var currentLocation;
    var location = new l.Location();
    List<dynamic> _nearbyPlaces=[]; 

    try {
      currentLocation = await location.getLocation();
      }on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
    
    HereMaps(appId: "yourAppId", appCode: "youAppCode")
          .exploreNearbyPlaces( lat: currentLocation.latitude, lon: currentLocation.longitude,offset: 10)
          .then((response) {
              setState(() {
                  _nearbyPlaces.addAll(response['results']['items']);
              });
          });

```

##### Populare Places
```DART
    import 'package:here_maps_webservice/here_maps.dart';
    import 'package:location/location.dart' as l; 
    import 'package:flutter/services.dart';
    
    var currentLocation;
    var location = new l.Location();
    List<dynamic> _explorePopularPlace = []; 

    try {
      currentLocation = await location.getLocation();
      }on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
    
    HereMaps(appId: "yourAppId", appCode: "youAppCode")
          .explorePopularPlaces(
              lat: currentLocation.latitude,
              lon: currentLocation.longitude,
              offset: 10)
          .then((response) {
        setState(() {
          _explorePopularPlace.addAll(response['results']['items']);
        });
      });

```

##### Geocoding Autocomplete
```DART
     import 'package:here_maps_webservice/here_maps.dart';
     
     List<dynamic> _suggestion = [];
     
     HereMaps(appId: "yourAppId", appCode: "youAppCode")
           .geoCodingAutoComplete(query: "YourQuery")
           .then((response) {
         setState(() {
           _suggestion.addAll(response['suggestions']);
         });
       });
```

##### Geocoding
```DART
    import 'package:here_maps_webservice/here_maps.dart';
    
    Map<String, dynamic> latLon = Map();
    
    HereMaps(appId: "yourAppId", appCode: "youAppCode")
        .geoCode(searchText: _searchController.text)
        .then((response) {
      setState(() {
        latLon = response['Response']['View'][0]['Result'][0]['Location']
            ['DisplayPosition'];
      });
    });
```

##### Reverse Geocoding
```DART
    import 'package:here_maps_webservice/here_maps.dart';
    import 'package:location/location.dart' as l; 
    import 'package:flutter/services.dart';
    
    var currentLocation;
    var location = new l.Location();

    try {
      currentLocation = await location.getLocation();
      }on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        print("Permission Dennied");
      }
    }
    
    Map<String,dynamic> response = HereMaps(appId: "yourAppId", appCode: "youAppCode")
      .reverseGeoCode(lat: currentLocation.latitude, lon: currentLocation.longitude)

```

## TODO
- Add all the parameters in the existing APIs
- Add tests
- Make Model class for exisitng APIs
- Add routing APIs

## Feature Requests and Issues
Please file feature requests and bugs at the [issue tracker](https://github.com/AyushBherwani1998/here_maps_webservice/issues)

## Contributing
We would love to see you contribute to here_maps_webservice. Do check out our [Contributing Guidelines](https://github.com/AyushBherwani1998/here_maps_webservice/blob/master/CONTRIBUTING.md).
