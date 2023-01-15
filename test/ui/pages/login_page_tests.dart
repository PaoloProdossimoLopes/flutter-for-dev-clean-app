import 'package:ForDev/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('load with correct state', (WidgetTester tester) async {
    final sut = MaterialApp(home: LoginPage());
    await tester.pumpWidget(sut);
    
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Password'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);
    
    final button = tester.widget<MaterialButton>(find.byType(MaterialButton));
    expect(button.onPressed, null);
  });
}
