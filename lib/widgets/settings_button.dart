import 'package:apollo/page/settings.dart';
import 'package:apollo/transition/slide_left_transition.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.settings),
        onPressed: () => Navigator.push(
              context,
              SlideLeftRoute(
                widget: SettingsPage(),
              ),
            ),
      );
}
