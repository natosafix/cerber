import 'package:json_annotation/json_annotation.dart';

part 'log_in_request.g.dart';

@JsonSerializable(createFactory: false)
class LogInRequest {
  LogInRequest({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LogInRequestToJson(this);
}
