import 'package:json_annotation/json_annotation.dart';

import '../../model/comment_model.dart';

part 'comment_dto.g.dart';

@JsonSerializable()
class CommentDto {
  CommentDto({
    this.parentId,
    this.commentIds,
    this.isDead,
    this.isDeleted,
    this.text,
    this.author,
    this.time,
    required this.id,
    required this.type,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  factory CommentDto.fromModel(CommentModel model) {
    return CommentDto(
      parentId: model.parentId,
      commentIds: model.commentIds,
      isDead: model.isDead,
      isDeleted: model.isDeleted,
      text: model.text,
      author: model.author,
      time: model.time,
      id: model.id,
      type: model.type,
    );
  }

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);

  CommentModel toModel() {
    return CommentModel(
      parentId: parentId,
      commentIds: commentIds,
      isDead: isDead,
      isDeleted: isDeleted,
      text: text,
      author: author,
      time: time,
      id: id,
      type: type,
    );
  }

  @JsonKey(name: 'parent')
  final int? parentId;
  @JsonKey(name: 'kids')
  final List<int>? commentIds;
  @JsonKey(name: 'dead')
  final bool? isDead;
  @JsonKey(name: 'deleted')
  final bool? isDeleted;
  final String? text;
  @JsonKey(name: 'by')
  final String? author;
  final int? time;
  final int id;
  final String type;
}
