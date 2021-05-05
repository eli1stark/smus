import '../../model/top_stories_model.dart';

// We don't need @JsonSerializable
// since we are reciving List<dynamic>
class TopStoriesDto {
  TopStoriesDto({
    required this.storyIds,
  });

  factory TopStoriesDto.fromList(List<dynamic> list) {
    return TopStoriesDto(
      storyIds: list.map((e) => e as int).toList(),
    );
  }

  TopStoriesModel toModel() {
    return TopStoriesModel(
      storyIds: storyIds,
    );
  }

  // We also don't need toJson and fromModel
  // since we won't be POSTing to the API
  // YAGNI

  final List<int> storyIds;
}
