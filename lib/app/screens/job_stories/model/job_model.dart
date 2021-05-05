import 'package:flutter/foundation.dart';

@immutable
class JobModel {
  const JobModel({
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
