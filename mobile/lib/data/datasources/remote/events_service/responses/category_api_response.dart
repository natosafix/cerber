import 'package:json_annotation/json_annotation.dart';

part 'category_api_response.g.dart';

@JsonSerializable(createToJson: false)
class CategoryApiResponse {
  final int id;
  final String name;

  CategoryApiResponse({
    required this.id,
    required this.name,
  });

  factory CategoryApiResponse.fromJson(Map<String, dynamic> json) => _$CategoryApiResponseFromJson(json);
}
