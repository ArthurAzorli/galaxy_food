import 'dart:convert';

import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:http/http.dart' as http;

import '../domain/client.dart';
import '../utils/exception/repository_exception.dart';

class SessionService{

  static const String kApiRequest = "https://arthurazorli.github.io/GalaxyFoodServer";

  static Future<bool> login({required String user, required String password}) async {
    final endpointUri = Uri.parse("$kApiRequest/client/login");

    final json = {
      "login": user,
      "password": password
    };

    final response = await http.post(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
      body: jsonEncode(json)
    );

    if (response.statusCode == 200){
      return jsonDecode(response.body)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<bool> logout() async {
    final endpointUri = Uri.parse("$kApiRequest/user/logout");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200){
      return jsonDecode(response.body)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<Client> getUser() async {
    final endpointUri = Uri.parse("$kApiRequest/user/session");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200){
      if (jsonDecode(response.body)["type"] == "client") {
        return await ClientRepositoryService.get(jsonDecode(response.body)["user"]);
      }
      throw RepositoryException(
          code: 401,
          message: "Você não está logado em uma conta de Cliente",
          timestamp: DateTime.now()
      );
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }
}