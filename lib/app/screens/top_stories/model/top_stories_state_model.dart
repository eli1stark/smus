import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../shared/plugins/story/model/story_model.dart';

part 'top_stories_state_model.freezed.dart';

@freezed
class TopStoriesStateModel with _$TopStoriesStateModel {
  factory TopStoriesStateModel({
    required int storiesFetched,
    required List<int> storiesIds,
    required List<StoryModel> stories,
    TopStoriesStateStatus? status,
    String? error,
  }) = _TopStoriesStateModel;
}

enum TopStoriesStateStatus {
  success,
  fetchStoriesIdsFailure,
  fetchStoriesFailure,
  nothingToLoad,
}
