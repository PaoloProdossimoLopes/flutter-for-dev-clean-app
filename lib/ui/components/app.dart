
import 'package:ForDev/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    final theme = ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
      accentColor: primaryColor,
      backgroundColor: Colors.white
    );

    return MaterialApp(
        title: '4DEV',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: LoginPage()
    );
  }
}