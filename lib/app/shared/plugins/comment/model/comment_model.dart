import 'package:flutter/foundation.dart';

@immutable
class CommentModel {
  const CommentModel({
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

  final int? parentId;
  final List<int>? commentIds;
  final bool? isDead;
  final bool? isDeleted;
  final String? text;
  final String? author;
  final int? time;
  final int id;
  final String type;
}
