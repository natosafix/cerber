// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketApiResponse _$TicketApiResponseFromJson(Map<String, dynamic> json) =>
    TicketApiResponse(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      name: json['name'] as String,
    );
