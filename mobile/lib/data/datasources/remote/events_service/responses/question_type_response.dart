import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'type')
enum QuestionTypeResponse {
  text(0),
  radio(1),
  checkbox(2);

  const QuestionTypeResponse(this.type);
  final int type;
}
