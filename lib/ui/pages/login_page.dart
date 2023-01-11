import 'package:ForDev/ui/components/header.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child:
    Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(),
          Container(margin: EdgeInsets.only(left: 16, right: 16), child: Text('Login'.toUpperCase(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3)),
          Container(margin: EdgeInsets.only(left: 16, right: 16), child: Form(child: Column(children: [
            TextFormField(decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email)), keyboardType: TextInputType.emailAddress),
            TextFormField(decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock)),keyboardType: TextInputType.text),
            Container(margin: EdgeInsets.only(top: 20), child: MaterialButton(onPressed: () { print('tapped'); }, child: Text('Entrar'.toUpperCase()), color: Colors.grey)),
            TextButton.icon(onPressed: () { print('tapped'); }, icon: Icon(Icons.person, color: Theme.of(context).primaryColor,), label: Text('Criar conta'), )
          ])))
        ]))
    );
  }
}