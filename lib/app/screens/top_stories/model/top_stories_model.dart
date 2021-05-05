import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class TopStoriesModel {
  const TopStoriesModel({
    required this.storyIds,
  });

  final List<int> storyIds;
}
