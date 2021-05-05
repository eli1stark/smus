import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/top_stories_state_model.dart';
import '../notifiers/top_stories_notifier.dart';

final topStoriesNotipod =
    StateNotifierProvider<TopStoriesNotifier, TopStoriesStateModel>((ref) {
  return TopStoriesNotifier();
});
