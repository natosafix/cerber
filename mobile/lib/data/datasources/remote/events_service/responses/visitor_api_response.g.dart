// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorApiResponse _$VisitorApiResponseFromJson(Map<String, dynamic> json) =>
    VisitorApiResponse(
      id: json['customer'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerApiResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticket:
          TicketApiResponse.fromJson(json['ticket'] as Map<String, dynamic>),
    );
