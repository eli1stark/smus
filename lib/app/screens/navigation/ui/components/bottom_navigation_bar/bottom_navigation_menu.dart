import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bottom_navigation_item.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.white,
      child: Row(
        children: const [
          BottomNavigationItem(
            index: 0,
            icon: FontAwesomeIcons.rocket,
          ),
          BottomNavigationItem(
            index: 1,
            icon: FontAwesomeIcons.newspaper,
          ),
          BottomNavigationItem(
            index: 2,
            icon: FontAwesomeIcons.eye,
          ),
          BottomNavigationItem(
            index: 3,
            icon: FontAwesomeIcons.briefcase,
          ),
          BottomNavigationItem(
            index: 4,
            icon: FontAwesomeIcons.bullhorn,
          ),
        ],
      ),
    );
  }
}
