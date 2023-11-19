// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_visitors_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVisitorsRequest _$GetVisitorsRequestFromJson(Map<String, dynamic> json) =>
    GetVisitorsRequest(
      eventId: json['eventId'] as String,
      offset: json['offset'] as int,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$GetVisitorsRequestToJson(GetVisitorsRequest instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'offset': instance.offset,
      'limit': instance.limit,
    };
