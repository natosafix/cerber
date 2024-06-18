import 'package:json_annotation/json_annotation.dart';

part 'ticket_api_response.g.dart';

@JsonSerializable(createToJson: false)
class TicketApiResponse {
  final int id;
  final int price;
  final String name;

  TicketApiResponse({
    required this.id,
    required this.price,
    required this.name,
  });

  factory TicketApiResponse.fromJson(Map<String, dynamic> json) => _$TicketApiResponseFromJson(json);
}
