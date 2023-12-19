import 'package:json_annotation/json_annotation.dart';
import 'package:project/data/datasources/remote/events_service/responses/question_type_response.dart';

part 'question_api_response.g.dart';

@JsonSerializable(createToJson: false)
class QuestionApiResponse {
  final int id;
  final QuestionTypeResponse type;
  final String content;
  final bool required;

  QuestionApiResponse({
    required this.id,
    required this.type,
    required this.content,
    required this.required,
  });

  factory QuestionApiResponse.fromJson(Map<String, dynamic> json) => _$QuestionApiResponseFromJson(json);
}
