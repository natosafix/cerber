// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionApiResponse _$QuestionApiResponseFromJson(Map<String, dynamic> json) =>
    QuestionApiResponse(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$QuestionTypeResponseEnumMap, json['type']),
      title: json['title'] as String,
      required: json['required'] as bool,
      answerChoices: (json['answerChoices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

const _$QuestionTypeResponseEnumMap = {
  QuestionTypeResponse.oneLineText: 0,
  QuestionTypeResponse.multiLineText: 1,
  QuestionTypeResponse.radio: 2,
  QuestionTypeResponse.checkbox: 3,
};
