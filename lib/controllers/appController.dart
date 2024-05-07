import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuscaController {
  TextEditingController textController = TextEditingController();
  int _pagina = 0;

  Future<List<dynamic>> apiController(String query, [int pagina = 0]) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/search/$query&start=${pagina * 10}'));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao buscar resultados');
    }
  }

  Future<List<dynamic>> performSearch(String query, [bool nextPagina = false]) async {
    try {
      if (nextPagina) {
        _pagina++;
      } else {
        _pagina = 0;
      }
      var resultados = await apiController(query, _pagina);

      return resultados;
      } catch (e) {
      throw Exception('Erro ao buscar resultados');
    }
  }
}