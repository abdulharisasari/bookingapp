import 'package:bookingapp/main/index.dart';
import 'package:bookingapp/routers/arguments.dart';
import 'package:bookingapp/routers/constants.dart';
import 'package:flutter/material.dart';

import '../main/root.dart';
import '../page/detail/index.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var uri = Uri.parse(settings.name ?? '');
    debugPrint('uri $uri');
    debugPrint('setName ${settings.name}');

    switch (uri.path) {
      case rootRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Root(),
        );
      case mainRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_)=> MainPage()
        );
      case detailRoute:
      final argument = settings.arguments is DetailArgument ? settings.arguments as DetailArgument : null;
        if (argument == null) return null;
        return MaterialPageRoute(

          settings: settings,
          builder: (_)=> DetailPage(detailArgument: argument));
      default:
        return null;
    }
  }
}