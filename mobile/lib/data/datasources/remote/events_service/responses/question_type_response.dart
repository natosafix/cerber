import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'type')
enum QuestionTypeResponse {
  oneLineText(0),
  multiLineText(1),
  radio(2),
  checkbox(3);

  const QuestionTypeResponse(this.type);
  final int type;
}
