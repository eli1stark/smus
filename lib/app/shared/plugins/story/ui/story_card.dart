import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../shared/components/spacers.dart';
import '../model/story_model.dart';
import 'components/story_author.dart';
import 'components/story_counter.dart';
import 'components/story_time.dart';
import 'components/story_title.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final StoryModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoryTitle(
              title: model.title ?? 'unknown',
            ),
            SpaceH5(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StoryCounter(
                  count: model.score ?? 0,
                  icon: FontAwesomeIcons.chevronUp,
                ),
                SpaceW10(),
                StoryCounter(
                  count: model.totalComments ?? 0,
                  icon: FontAwesomeIcons.comment,
                ),
                SpaceW10(),
                StoryAuthor(
                  author: model.author ?? 'unknown',
                ),
                const Spacer(),
                StoryTime(
                  createdAt: model.createdAt ?? 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
