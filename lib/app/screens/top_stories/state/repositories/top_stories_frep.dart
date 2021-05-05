import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/top_stories_model.dart';
import '../../model/top_stories_state_model.dart';
import '../../source/repository/top_stories_repository.dart';
import '../providers/top_stories_notipod.dart';

final topStoriesFrep = FutureProvider<void>((ref) async {
  final repository = TopStoriesRepository();

  final notifier = ref.watch(topStoriesNotipod.notifier);

  final result = await repository.topStoriesIds();

  final value = result.value;

  if (value is TopStoriesModel) {
    notifier.updateStoriesIds(value.storyIds);
    notifier.updateStatus(TopStoriesStateStatus.success);
  } else {
    notifier.updateError('$value');
    notifier.updateStatus(TopStoriesStateStatus.fetchStoriesIdsFailure);
  }

  await notifier.fetchStories();
});
