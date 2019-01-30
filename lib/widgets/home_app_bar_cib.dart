import 'package:apollo/alert/default_alert.dart';
import 'package:apollo/alert/no_permissions_alert.dart';
import 'package:apollo/util/permission_request.dart';
import 'package:apollo/util/recorder_launcher.dart';
import 'package:apollo/widgets/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAppBarCIB extends StatelessWidget {
  final VoidCallback onStopRecordingCallback;

  HomeAppBarCIB({this.onStopRecordingCallback});

  @override
  Widget build(BuildContext context) => CircleIconButton(
        highlightColor: Theme.of(context).highlightColor,
        splashColor: Theme.of(context).splashColor,
        diameter: 100,
        iconColor: Theme.of(context).iconTheme.color,
        iconData: Icons.mic_none,
        iconSize: 30,
        primaryColor: Theme.of(context).buttonColor,
        onTap: () async {
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
                    content: 'An error occured while requesting permissions')
                .show();
          }
        },
      );
}
