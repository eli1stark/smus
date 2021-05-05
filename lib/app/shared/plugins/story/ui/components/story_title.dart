import 'package:flutter/material.dart';

class StoryTitle extends StatelessWidget {
  const StoryTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}
