import 'dart:async';

import 'package:bookingapp/routers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    );
    Timer(Duration(seconds: 3), () {
      _init();
    });
  }

  void _init() async {
    Navigator.pushNamedAndRemoveUntil(context, mainRoute, (p) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: Center(child: CircularProgressIndicator()));
  }
}
