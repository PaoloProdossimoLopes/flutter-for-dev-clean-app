
import 'package:ForDev/ui/pages/login_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '4DEV',
        debugShowCheckedModeBanner: false,
        home: LoginPage()
    );
  }
}