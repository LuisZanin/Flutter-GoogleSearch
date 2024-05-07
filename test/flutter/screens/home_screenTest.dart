import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:googlenav/screens/home_screen.dart';


void main() {
  testWidgets('Testando o título da Interface', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Atak Searcher'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Testando se o campo de texto aceita caracteres', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'teste');

    expect(find.text('teste'), findsOneWidget);
  });

}