import 'package:json_annotation/json_annotation.dart';

part 'log_in_response.g.dart';

@JsonSerializable(createToJson: false)
class LogInResponse {
  LogInResponse({
    required this.token,
    required this.expiration,
  });

  final String token;
  final DateTime expiration;
  
  factory LogInResponse.fromJson(Map<String, dynamic> json) => _$LogInResponseFromJson(json);
}
