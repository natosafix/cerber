// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionApiResponse _$QuestionApiResponseFromJson(Map<String, dynamic> json) =>
    QuestionApiResponse(
      id: json['id'] as int,
      type: $enumDecode(_$QuestionTypeResponseEnumMap, json['type']),
      content: json['content'] as String,
      required: json['required'] as bool,
    );

const _$QuestionTypeResponseEnumMap = {
  QuestionTypeResponse.text: 0,
  QuestionTypeResponse.radio: 1,
  QuestionTypeResponse.checkbox: 2,
};
