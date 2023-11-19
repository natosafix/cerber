import 'package:json_annotation/json_annotation.dart';

part 'get_visitors_request.g.dart';

@JsonSerializable()
class GetVisitorsRequest {
  final String eventId;
  final int offset;
  final int limit;

  GetVisitorsRequest({
    required this.eventId,
    required this.offset,
    required this.limit,
  });

  factory GetVisitorsRequest.fromJson(Map<String, dynamic> json) => _$GetVisitorsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetVisitorsRequestToJson(this);
}
