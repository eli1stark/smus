import 'package:json_annotation/json_annotation.dart';

import '../../model/post_model.dart';

part 'post_dto.g.dart';

@JsonSerializable()
class PostDto {
  PostDto({
    required this.username,
    required this.number,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  PostModel toModel() {
    return PostModel(
      username: username,
      number: number,
    );
  }

  final String username;
  final String number;
}
