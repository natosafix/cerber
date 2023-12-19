import 'package:json_annotation/json_annotation.dart';

part 'answer_api_response.g.dart';

@JsonSerializable(createToJson: false)
class AnswerApiResponse {
  final int id;
  final String content;
  final int questionId;

  AnswerApiResponse({
    required this.id,
    required this.content,
    required this.questionId,
  });

  factory AnswerApiResponse.fromJson(Map<String, dynamic> json) => _$AnswerApiResponseFromJson(json);
}
