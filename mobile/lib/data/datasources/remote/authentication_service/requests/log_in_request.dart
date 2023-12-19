import 'package:json_annotation/json_annotation.dart';

part 'log_in_request.g.dart';

@JsonSerializable(createFactory: false)
class LogInRequest {
  LogInRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$LogInRequestToJson(this);
}
