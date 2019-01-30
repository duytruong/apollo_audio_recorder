import 'package:flutter/material.dart';

class NoPermissionsAlert {
  BuildContext context;

  NoPermissionsAlert({this.context});

  show() async => await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text('Ops'),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
            content: Text('We need your permissions to work with you :('),
          ));
}
