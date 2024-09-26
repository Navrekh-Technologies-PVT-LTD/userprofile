import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MapController {
  ValueNotifier<String> currentCity = ValueNotifier<String>('');
  ValueNotifier<bool> isLoading =
      ValueNotifier<bool>(false); // Observable boolean for loading state
  final Dio _dio = Dio();
  static const String googleApiKey = 'AIzaSyCPjROznDovFzXCZpOu1WGdJ7pDUfqKj6A';

  MapController() {
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try to request permissions again
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> fetchCurrentLocationAndCity() async {
    try {
      isLoading.value = true; // Set loading state to true before fetching
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      await getCityFromLatLng(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; // Set loading state to false after fetching
    }
  }

  Future<void> getCityFromLatLng(double lat, double lng) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'latlng': '$lat,$lng',
          'key': googleApiKey,
        },
      );
      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results.isNotEmpty) {
          final addressComponents = results[0]['address_components'];
          for (var component in addressComponents) {
            final types = component['types'];
            if (types.contains('locality')) {
              currentCity.value = component['long_name'];
              break;
            }
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; // Ensure loading state is false after processing
    }
  }

  final String placesapiKey =
      ' AIzaSyCPjROznDovFzXCZpOu1WGdJ7pDUfqKj6A'; // Replace with your API key

  Future<List<String>> getPlaces(String query) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'
        '?input=$query'
        '&key=$placesapiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> places = [];
      for (var prediction in data['predictions']) {
        places.add(prediction['description']);
      }
      return places;
    } else {
      throw Exception('Failed to load places');
    }
  }
}
