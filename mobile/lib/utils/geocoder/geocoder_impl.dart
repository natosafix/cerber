import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/utils/geocoder/coords.dart';
import 'package:project/utils/geocoder/geocoder.dart';

class GeocoderImpl extends Geocoder {
  static const _url = 'https://api.geoapify.com/v1/geocode/search';

  static const _apiKey = '426c5dc58e08478e89cb82ac0fcc363f';

  final _dio = Dio();

  @override
  Future<Coords?> getCoordinates({
    required String city,
    required String address,
  }) async {
    try {
      final response = await _dio.get(
        _url,
        queryParameters: {
          'apiKey': _apiKey,
          'city': city,
          'street': address,
        },
      );

      final coordsList = response.data['features'][0]['geometry']['coordinates'];

      return Coords(
        latitude: coordsList[1] as double,
        longitude: coordsList[0] as double,
      );
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
