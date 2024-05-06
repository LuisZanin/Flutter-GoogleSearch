import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuscaController {
  TextEditingController textController = TextEditingController();

  Future<List<dynamic>> ApiController(String query) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/search/$query'));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao buscar resultados');
    }
  }

  Future<List<dynamic>> performSearch(String query) async {
    try {
      var resultados = await ApiController(query);
      var resultadosComTitulo = resultados
          .where((resultado) => resultado['titulo'] != null && resultado['titulo'].trim().isNotEmpty).toList();
      return resultadosComTitulo;
    } catch (e) {
      throw Exception('Erro ao buscar resultados');
    }
  }
}