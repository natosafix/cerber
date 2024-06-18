// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerApiResponse _$AnswerApiResponseFromJson(Map<String, dynamic> json) =>
    AnswerApiResponse(
      id: (json['id'] as num).toInt(),
      content:
          (json['content'] as List<dynamic>).map((e) => e as String).toList(),
      questionId: (json['questionId'] as num).toInt(),
    );
