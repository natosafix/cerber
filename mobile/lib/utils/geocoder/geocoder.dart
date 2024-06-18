import 'package:project/utils/geocoder/coords.dart';

abstract class Geocoder {
  Future<Coords?> getCoordinates({
    required String city,
    required String address,
  });
}
