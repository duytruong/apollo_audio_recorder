import 'package:apollo/alert/default_alert.dart';
import 'package:apollo/alert/no_permissions_alert.dart';
import 'package:apollo/page/recorder.dart';
import 'package:apollo/util/permission_request.dart';
import 'package:apollo/util/recorder_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeFAB extends StatelessWidget {
  final VoidCallback onStopRecordingCallback;

  HomeFAB({this.onStopRecordingCallback});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () async {
          try {
            if (await PermissionRequest.handleRecordAudioPermission() &&
                await PermissionRequest.handleWriteExternalStoragePermission())
              RecorderLauncher.launch(context, onStopRecordingCallback);
            else
              await NoPermissionsAlert(context: context).show();
          } on PlatformException {
            await DefaultAlert(
                    context: context,
                    title: 'Ops',
                    content: 'An error occured when requesting permissions')
                .show();
          }
        },
        child: Icon(Icons.mic_none),
      );
}
