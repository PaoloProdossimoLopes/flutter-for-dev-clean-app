
import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(height: 50, margin: EdgeInsets.only(top: 50, bottom: 10), child: Image(height: 50, image: AssetImage('lib/ui/assets/logo.png'), color: Colors.white),),
      height: 150, margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark
              ]
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))
      ),
    );
  }
}
