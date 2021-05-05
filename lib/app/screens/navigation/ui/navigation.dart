import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/navigation_stpod.dart';
import 'components/bottom_navigation_bar/bottom_navigation_menu.dart';
import 'components/screens.dart';

class Navigation extends HookWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final navigation = useProvider(navigationStpod);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: screens[navigation.state.currentIndex],
      ),
      bottomNavigationBar: const BottomNavigationMenu(),
    );
  }
}
