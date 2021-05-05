import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
