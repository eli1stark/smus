import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/screens/navigation/ui/navigation.dart';

void main() {
  runApp(
    ProviderScope(
      child: HackerNews(),
    ),
  );
}

class HackerNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Navigation.routeName,
      routes: {
        Navigation.routeName: (context) => Navigation(),
      },
    );
  }
}
