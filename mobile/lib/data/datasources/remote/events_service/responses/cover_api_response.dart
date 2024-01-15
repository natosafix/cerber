import 'package:json_annotation/json_annotation.dart';

part 'cover_api_response.g.dart';

@JsonSerializable(createToJson: false)
class CoverApiResponse {
  final int id;
  final String name;
  final String path;

  CoverApiResponse({
    required this.id,
    required this.name,
    required this.path,
  });

  factory CoverApiResponse.fromJson(Map<String, dynamic> json) => _$CoverApiResponseFromJson(json);
}
