import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class StoryModel {
  const StoryModel({
    this.title,
    this.author,
    this.url,
    this.createdAt,
    this.score,
    this.totalComments,
    this.commentIds,
    this.isDead,
    this.isDeleted,
    required this.id,
    required this.type,
  });

  final String? title;
  final String? author;
  final String? url;
  final int? createdAt;
  final int? score;
  final int? totalComments;
  final List<int>? commentIds;
  final bool? isDead;
  final bool? isDeleted;
  final int id;
  final String type;
}
