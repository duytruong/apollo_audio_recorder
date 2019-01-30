
import 'package:apollo/page/recorder.dart';
import 'package:flutter/material.dart';

class RecorderLauncher {
  static launch(BuildContext context, VoidCallback onStopRecordingCallback) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecorderPage(
            onStopRecordingCallback: onStopRecordingCallback,
          )));
}