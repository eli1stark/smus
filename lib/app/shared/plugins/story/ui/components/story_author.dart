import 'package:flutter/material.dart';

class StoryAuthor extends StatelessWidget {
  const StoryAuthor({
    Key? key,
    required this.author,
  }) : super(key: key);

  final String author;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Posted by ',
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.black54,
        ),
        children: [
          TextSpan(
            text: author,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
