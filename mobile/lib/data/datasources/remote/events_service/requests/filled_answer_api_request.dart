import 'package:json_annotation/json_annotation.dart';

part 'filled_answer_api_request.g.dart';

@JsonSerializable(createFactory: false)
class FilledAnswerApiRequest {
  final int questionId;
  final List<String> content;

  FilledAnswerApiRequest({
    required this.questionId,
    required this.content,
  });

  Map<String, dynamic> toJson() => _$FilledAnswerApiRequestToJson(this);
}
