import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('O Teste faz requisição HTTP para a Api e espera status 200', () async {

    var response = await http.get(
      Uri.parse('http://localhost:3000/search/Maringá&start=0'),
    ).timeout(const Duration(seconds: 15));

    expect(response.statusCode, 200);
  });
}