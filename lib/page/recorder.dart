import 'dart:async';
import 'dart:io';
import 'package:apollo/values/colors.dart';
import 'package:apollo/widgets/circle_icon_button.dart';
import 'package:apollo/widgets/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class RecorderPage extends StatefulWidget {
  final VoidCallback onStopRecordingCallback;

  RecorderPage({@required this.onStopRecordingCallback});

  @override
  _RecorderPageState createState() => _RecorderPageState();
}

class _RecorderPageState extends State<RecorderPage> {


  StreamSubscription<RecordStatus> _recorderSubscription;

  FlutterSound _flutterSound = new FlutterSound();

  bool _isRecording = false;

  IconData get _buttonIconData => _isRecording ? Icons.stop : Icons.play_arrow;

  _startStopButtonClicked() =>
      setState(() {
        if (_isRecording)
          _stopRecording();
        else
          _startRecording();
      });

  _startRecording() async {
    Directory appDocDirectory = await getExternalStorageDirectory();
    var dir = await Directory("${appDocDirectory.path}/apollo/recordings")
        .create(recursive: true);
    var file = File('${dir.path}/apollo_recording_${DateTime
        .now()
        .millisecondsSinceEpoch}.mp3');
    String path = await _flutterSound.startRecorder(file.path);
    print('startRecorder: $path');
    _recorderSubscription = _flutterSound.onRecorderStateChanged.listen((e) {
      DateTime date =
      new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      String txt = date.toString();
    });
    setState(() => _isRecording = true);
  }

  _stopRecording() async {
    String result = await _flutterSound.stopRecorder();
    print('stopRecorder: $result');

    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
    setState(() => _isRecording = false);
    widget.onStopRecordingCallback();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: _buildAppBar(),
        body: _buildBodyContainer(),
      );

  AppBar _buildAppBar() =>
      AppBar(
        actions: [
          SettingsButton(),
        ],
        elevation: 0,
      );

  Container _buildBodyContainer() =>
      Container(
        decoration: BoxDecoration(gradient: gradientBackground),
        child: Center(
          child: _buildStartStopHeroButton(),
        ),
      );

  Hero _buildStartStopHeroButton() =>
      Hero(
        tag: 'buttonHero',
        child: _buildStartStopButton(),
      );

  CircleIconButton _buildStartStopButton() =>
      CircleIconButton(
        highlightColor: Theme
            .of(context)
            .highlightColor,
        splashColor: Theme
            .of(context)
            .splashColor,
        diameter: 200,
        iconColor: Theme
            .of(context)
            .iconTheme
            .color,
        iconData: _buttonIconData,
        iconSize: 60,
        primaryColor: Theme
            .of(context)
            .buttonColor,
        onTap: _startStopButtonClicked,
      );
}
