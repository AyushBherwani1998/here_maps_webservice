<p align="center">
  <a href="https://developer.here.com/">
    <img alt="Here" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/HERE_logo.svg/1200px-HERE_logo.svg.png" width="100" />
  </a>
</p>
This package contains a set of high-level functions and classes that make it easy to use Here RESTful web services that serve different purposes – from search, to geocoding, to routing[Coming Soon]. It's platform-independent, and can also be used in the browser.

## Available Methods

1. `exploreNearbyPlaces` <br> Based on a `lat` & `lon`, returns places nearby and sort the results by distance

2. `geoCodingAutoComplete` <br> Get better search suggestions for your addresses with fewer keystrokes. The `geoCodingAutoComplete` retrieves a complete address and an ID. You can subsequently use the `geoCoder` to geocode the address based on the ID and thus obtain the geographic coordinates of the address.

3. `geoCoder` <br> Submit the name of a known landmark to request the corresponding geocoordinates. 
