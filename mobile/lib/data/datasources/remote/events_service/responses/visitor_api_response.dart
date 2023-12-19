import 'package:json_annotation/json_annotation.dart';
import 'package:project/data/datasources/remote/events_service/responses/answer_api_response.dart';
import 'package:project/data/datasources/remote/events_service/responses/ticket_api_response.dart';

part 'visitor_api_response.g.dart';

@JsonSerializable(createToJson: false)
class VisitorApiResponse {
  @JsonKey(name: 'customer')
  final String id;

  final List<AnswerApiResponse> answers;
  final TicketApiResponse ticket;

  VisitorApiResponse({
    required this.id,
    required this.answers,
    required this.ticket,
  });

  factory VisitorApiResponse.fromJson(Map<String, dynamic> json) => _$VisitorApiResponseFromJson(json);
}
