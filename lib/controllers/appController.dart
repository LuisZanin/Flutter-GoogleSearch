import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuscaController {
  TextEditingController textController = TextEditingController();
  int _pagina = 0;

  Future<List<Map<String, dynamic>>> apiController(String query, [int pagina = 1]) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/search/$query?start=$pagina'));

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> performSearch(String query, [bool nextPage = false]) async {
    try {
      if (nextPage) {
        _pagina++;
      } else {
        _pagina = 0;
      }
      var resultados = await apiController(query, _pagina);

      return resultados;
    } catch (e) {
      return [];
    }
  }
}
