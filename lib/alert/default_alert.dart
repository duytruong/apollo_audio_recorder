import 'package:flutter/material.dart';

class DefaultAlert {
  BuildContext context;
  String title;
  String content;

  DefaultAlert({this.context, this.title, this.content});

  show() async => await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Text(title),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        content: Text(content),
      ));
}
