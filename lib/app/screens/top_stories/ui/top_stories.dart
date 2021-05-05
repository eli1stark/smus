import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/components/error_text.dart';
import '../../../../shared/components/loaders.dart';
import '../../../shared/plugins/story/ui/story_card.dart';
import '../model/top_stories_state_model.dart';
import '../state/providers/top_stories_notipod.dart';
import '../state/repositories/top_stories_frep.dart';

class TopStories extends HookWidget {
  const TopStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final frep = useProvider(topStoriesFrep);
    final data = useProvider(topStoriesNotipod);

    return frep.when(
      data: (_) {
        if (data.status == TopStoriesStateStatus.success) {
          // todo refactor and add infinite scrolling
          return ListView(
            children: [
              for (var i in data.stories) ...[
                StoryCard(model: i),
              ]
            ],
          );
        } else if (data.status == TopStoriesStateStatus.fetchStoriesFailure) {
          return Text(data.error.toString());
        } else if (data.status ==
            TopStoriesStateStatus.fetchStoriesIdsFailure) {
          return Text(data.error.toString());
        } else if (data.status == TopStoriesStateStatus.nothingToLoad) {
          return const Text('Nothing to load!');
        } else {
          return const SizedBox();
        }
      },
      loading: () => Loader(),
      error: (o, st) => ErrorText(o.toString()),
    );
  }
}
