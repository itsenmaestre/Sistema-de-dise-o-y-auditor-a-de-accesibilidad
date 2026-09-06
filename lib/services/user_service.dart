import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:servicios_modelo_ui/models/hair.dart';
import 'package:servicios_modelo_ui/models/users.dart';

class UserService {
  static const baseUrl = 'https://dummyjson.com';

  Future<List<User>> getUsers({int limit = 5}) async {
    final url = Uri.parse('$baseUrl/users?limit=$limit');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudo completar la consulta: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> jsonList = data['users'] as List<dynamic>;

    return jsonList
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> getHairColors() async {
    final url = Uri.parse('$baseUrl/users?limit=0&select=hair');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudo completo la consulta de color d ecabello: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> jsonList = data['users'];

    final colores = <String>{};
    for (final json in jsonList) {
      final hair = Hair.fromJson(json['hair']);
      if (hair.color.isNotEmpty) colores.add(hair.color);
    }

    return colores.toList()..sort();
  }

  Future<List<User>> getUsersByHairColor(String color) async {
    final valor = Uri.encodeComponent(color);
    final url = Uri.parse(
      '$baseUrl/users/filter?key=hair.color&value=$valor&limit=0',
    );
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudo completar la consulta filtarda por color: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> jsonList = data['users'];

    return jsonList.map((j) => User.fromJson(j)).toList();
  }

  Future<User> getUserById(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudo completar la consulta por ID: ${response.statusCode} -ID: $id',
      );
    }

    return User.fromJson(json.decode(response.body));
  }
}
