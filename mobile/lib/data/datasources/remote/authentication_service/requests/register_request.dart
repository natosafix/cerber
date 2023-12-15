import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable(createFactory: false)
class RegisterRequest {
  RegisterRequest({
    required this.username,
    required this.password,
    required this.email,
  });

  final String username;
  final String password;
  final String email;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
