import 'dart:math';

import 'package:flutter/material.dart';

class Recording extends StatefulWidget {
  final String title;
  final DateTime creationDate;
  final MaterialColor avatarBackground =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final Icon avatarIcon = Icon(
    Icons.play_arrow,
    color: Colors.white,
  );

  Recording({
    @required this.title,
    @required this.creationDate,
  });

  @override
  _RecordingState createState() {
    return new _RecordingState();
  }
}

class _RecordingState extends State<Recording> {
  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.creationDate.toString()),
        leading: CircleAvatar(
          backgroundColor: widget.avatarBackground,
          child: widget.avatarIcon,
        ),
        onTap: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Tap'),
          ));
        },
      );
}
