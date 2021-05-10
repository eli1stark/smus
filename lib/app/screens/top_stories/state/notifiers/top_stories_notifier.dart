import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/plugins/story/model/story_model.dart';
import '../../../../shared/plugins/story/source/repository/story_repository.dart';
import '../../model/top_stories_state_model.dart';

class TopStoriesNotifier extends StateNotifier<TopStoriesStateModel> {
  TopStoriesNotifier()
      : super(
          const TopStoriesStateModel(
            storiesFetched: 0,
            storiesIds: [],
            stories: [],
          ),
        );

  Future<void> fetchStories([int amount = 20]) async {
    final repository = StoryRepository();

    final fetched = state.storiesFetched;
    final storiesIds = state.storiesIds;
    final stories = List<StoryModel>.from(state.stories);

    for (var i = fetched; i < fetched + amount; i++) {
      if (i >= storiesIds.length) {
        updateStories(stories);
        updateStatus(TopStoriesStateStatus.nothingToLoad);
        break;
      } else {
        final story = await repository.storyById(storiesIds[i]);

        final value = story.value;

        if (value is StoryModel) {
          stories.add(value);
          updateStatus(TopStoriesStateStatus.success);
        } else {
          updateError('$value');
          updateStatus(TopStoriesStateStatus.fetchStoriesFailure);
        }
      }
    }

    if (state.status == TopStoriesStateStatus.success) {
      updateStories(stories);
    }
  }

  void updateStoriesIds(List<int> storiesIds) {
    state = state.copyWith(storiesIds: storiesIds);
  }

  void updateStatus(TopStoriesStateStatus status) {
    state = state.copyWith(status: status);
  }

  void updateError(String text) {
    state = state.copyWith(error: text);
  }

  void updateStories(List<StoryModel> stories) {
    state = state.copyWith(
      stories: stories,
      storiesFetched: stories.length,
    );
  }
}
