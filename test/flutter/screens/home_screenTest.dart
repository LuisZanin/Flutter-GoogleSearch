import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:googlenav/controllers/appController.dart';
import 'package:googlenav/screens/home_screen.dart';


void main() {
  testWidgets('Testando o título da Interface', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(buscaController: BuscaController()),
    ));

    expect(find.text('Atak Searcher'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Testando se o campo de texto aceita caracteres', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(buscaController: BuscaController()),
    ));


    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'teste');

    expect(find.text('teste'), findsOneWidget);
  });

}
