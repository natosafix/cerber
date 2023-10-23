import 'package:json_annotation/json_annotation.dart';

part 'log_in_request.g.dart';

@JsonSerializable()
class LogInRequest {
  final String email;
  final String password;

  LogInRequest({
    required this.email,
    required this.password,
  });

  factory LogInRequest.fromJson(Map<String, dynamic> json) => _$LogInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogInRequestToJson(this);
}
