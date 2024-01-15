import 'package:json_annotation/json_annotation.dart';
import 'package:project/data/datasources/remote/events_service/requests/filled_answer_api_request.dart';

part 'send_answers_api_request.g.dart';

@JsonSerializable(createFactory: false)
class SendAnswersApiRequest {
  final int ticketId;
  final List<FilledAnswerApiRequest> answers;

  SendAnswersApiRequest({
    required this.ticketId,
    required this.answers,
  });
  
  Map<String, dynamic> toJson() => _$SendAnswersApiRequestToJson(this);
}
