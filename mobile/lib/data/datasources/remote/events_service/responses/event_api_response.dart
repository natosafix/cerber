import 'package:json_annotation/json_annotation.dart';
import 'package:project/data/datasources/remote/events_service/responses/cover_api_response.dart';

part 'event_api_response.g.dart';

@JsonSerializable(createToJson: false)
class EventApiResponse {
  final int id;
  final String name;
  final String description;
  final String city;
  final String address;
  final DateTime from;
  final DateTime to;
  final CoverApiResponse? cover;
  final String cryptoKey;

  EventApiResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.from,
    required this.to,
    required this.cover,
    required this.cryptoKey,
  });

  factory EventApiResponse.fromJson(Map<String, dynamic> json) => _$EventApiResponseFromJson(json);
}
