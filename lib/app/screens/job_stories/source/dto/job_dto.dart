import 'package:json_annotation/json_annotation.dart';

import '../../model/job_model.dart';

part 'job_dto.g.dart';

@JsonSerializable()
class JobDto {
  JobDto({
    this.commentIds,
    this.text,
    this.title,
    this.url,
    this.author,
    this.time,
    this.isDead,
    this.isDeleted,
    required this.id,
    required this.type,
  });

  factory JobDto.fromJson(Map<String, dynamic> json) => _$JobDtoFromJson(json);

  factory JobDto.fromModel(JobModel model) {
    return JobDto(
      commentIds: model.commentIds,
      text: model.text,
      title: model.title,
      url: model.url,
      author: model.author,
      time: model.time,
      isDead: model.isDead,
      isDeleted: model.isDeleted,
      id: model.id,
      type: model.type,
    );
  }

  Map<String, dynamic> toJson() => _$JobDtoToJson(this);

  JobModel toModel() {
    return JobModel(
      commentIds: commentIds,
      text: text,
      title: title,
      url: url,
      author: author,
      time: time,
      isDead: isDead,
      isDeleted: isDeleted,
      id: id,
      type: type,
    );
  }

  final List<int>? commentIds;
  final String? text;
  final String? title;
  final String? url;
  final String? author;
  final int? time;
  final bool? isDead;
  final bool? isDeleted;
  final int id;
  final String type;
}
