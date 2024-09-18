import 'dart:convert';

import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;

import '../domain/client.dart';
import '../utils/exception/repository_exception.dart';

class SessionService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}";

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
      return jsonDecode(response.bodyBytes.toUTF8)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
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
      return jsonDecode(response.bodyBytes.toUTF8)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
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
      if (jsonDecode(response.bodyBytes.toUTF8)["type"] == "client") {
        return await ClientRepositoryService.get(jsonDecode(response.bodyBytes.toUTF8)["user"]);
      }
      throw RepositoryException(
          status: 401,
          message: "Você não está logado em uma conta de Cliente",
          timestamp: DateTime.now()
      );
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }
}