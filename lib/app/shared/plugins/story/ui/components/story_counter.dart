import 'package:flutter/material.dart';

import '../../../../../../shared/components/spacers.dart';

class StoryCounter extends StatelessWidget {
  const StoryCounter({
    Key? key,
    required this.count,
    required this.icon,
  }) : super(key: key);

  final int count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 14.0,
          color: Colors.black54,
        ),
        SpaceW5(),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
