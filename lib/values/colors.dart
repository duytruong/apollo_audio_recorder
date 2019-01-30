import 'package:flutter/material.dart';

final gradientBackground = LinearGradient(
  // Where the linear gradient begins and ends
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.5, 0.7, 0.9],
  colors: [
    // Colors are easy thanks to Flutter's Colors class.
    Colors.amber[800],
    Colors.amber[700],
    Colors.amber[600],
    Colors.amber,
  ],
);