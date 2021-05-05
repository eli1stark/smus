import 'package:flutter/material.dart';

import '../../../../helpers/unix_time_to_time_ago.dart';

class StoryTime extends StatelessWidget {
  const StoryTime({
    Key? key,
    required this.createdAt,
  }) : super(key: key);

  final int createdAt;

  @override
  Widget build(BuildContext context) {
    return Text(
      unixTimeToTimeAgo(createdAt),
      style: const TextStyle(
        fontSize: 12.0,
        color: Colors.black54,
      ),
    );
  }
}
