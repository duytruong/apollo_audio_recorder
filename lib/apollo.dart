import 'package:apollo/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApolloApp extends StatefulWidget {
  @override
  _ApolloAppState createState() => _ApolloAppState();
}

class _ApolloAppState extends State<ApolloApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.amber, //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apollo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}
