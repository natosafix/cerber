// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventApiResponse _$EventApiResponseFromJson(Map<String, dynamic> json) =>
    EventApiResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      from: DateTime.parse(json['from'] as String),
      to: DateTime.parse(json['to'] as String),
      cover: CoverApiResponse.fromJson(json['cover'] as Map<String, dynamic>),
      cryptoKey: json['cryptoKey'] as String,
    );
