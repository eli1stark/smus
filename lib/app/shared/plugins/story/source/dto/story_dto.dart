import 'package:json_annotation/json_annotation.dart';

import '../../model/story_model.dart';

part 'story_dto.g.dart';

@JsonSerializable()
class StoryDto {
  const StoryDto({
    this.isDeleted,
    this.author,
    this.createdAt,
    this.isDead,
    this.commentIds,
    this.totalComments,
    this.score,
    this.title,
    this.url,
    required this.id,
    required this.type,
  });

  factory StoryDto.fromJson(Map<String, dynamic> json) =>
      _$StoryDtoFromJson(json);

  factory StoryDto.fromModel(StoryModel model) {
    return StoryDto(
      isDeleted: model.isDeleted,
      author: model.author,
      createdAt: model.createdAt,
      isDead: model.isDead,
      commentIds: model.commentIds,
      totalComments: model.totalComments,
      score: model.score,
      title: model.title,
      url: model.url,
      id: model.id,
      type: model.type,
    );
  }

  Map<String, dynamic> toJson() => _$StoryDtoToJson(this);

  StoryModel toModel() {
    return StoryModel(
      title: title,
      author: author,
      url: url,
      createdAt: createdAt,
      score: score,
      totalComments: totalComments,
      commentIds: commentIds,
      isDead: isDead,
      isDeleted: isDeleted,
      id: id,
      type: type,
    );
  }

  @JsonKey(name: 'deleted')
  final bool? isDeleted;
  @JsonKey(name: 'by')
  final String? author;
  @JsonKey(name: 'time')
  final int? createdAt;
  @JsonKey(name: 'dead')
  final bool? isDead;
  final List<int>? commentIds;
  @JsonKey(name: 'descendants')
  final int? totalComments;
  final int? score;
  final String? title;
  final String? url;
  final int id;
  final String type;
}
