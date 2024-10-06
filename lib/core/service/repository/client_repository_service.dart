import 'dart:convert';
import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/address.dart';
import '../../domain/client.dart';
import '../../domain/phone.dart';
import '../../utils/exception/repository_exception.dart';

class ClientRepositoryService {

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/client";

  static Future<bool> login({required String user, required String password}) async {
    final endpointUri = Uri.parse("$kApiRequest/login");

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
      final jsonResponse = jsonDecode(response.bodyBytes.toUTF8);
      final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();

      prefs.setString("user", jsonResponse["data"]);
      return jsonResponse["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<void> logout() async{
    final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
    prefs.remove("user");
  }

  static Future<Client> getUser() async {
    final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
    final idUser = prefs.getString("user");
    if (idUser == null) throw RepositoryException(status: 404, message:  "Você está Deslogado!");
    return ClientRepositoryService.get(idUser);
  }

  static Future<String> getUserID() async {
    final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
    final idUser = prefs.getString("user");
    if (idUser == null) throw RepositoryException(status: 404, message:  "Você está Deslogado!");
    return idUser;
  }

  static Future<Client> create(Client client) async {
    final endpointUri = Uri.parse("$kApiRequest/create");

    final response = await http.post(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(client.toJson())
    );

    if (response.statusCode == 201){
      final client = Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
      final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
      prefs.setString("user", client.id!);
      return client;
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Client> get(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Client> update(Client client) async {
    final endpointUri = Uri.parse("$kApiRequest/update/${client.id}");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(client.toJson())
    );

    if (response.statusCode == 202){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<bool> changePassword({required String oldPassword, required String newPassword}) async {
    final idClient = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/changepassword/$idClient");

    final json = {
      "oldPassword" : oldPassword,
      "newPassword" : newPassword
    };

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(json)
    );

    if (response.statusCode == 202){
      return jsonDecode(response.bodyBytes.toUTF8)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Client> addPhone(Phone phone) async {
    final idClient = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/addphone/$idClient");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(phone.toJson())
    );

    if (response.statusCode == 201){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Client> addAddress(Address address) async {
    final idClient = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/addaddress/$idClient");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(address.toJson())
    );

    if (response.statusCode == 201){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Client> remPhone(String id) async {
    final idClient = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/remphone/$idClient/$id");

    final response = await http.delete(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Client> remAddress(String id) async {
    final idClient = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/remaddress/$idClient/$id");

    final response = await http.delete(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<bool> delete({required String user, required String password}) async {
    final endpointUri = Uri.parse("$kApiRequest/delete");

    final json = {
      "login": user,
      "password": password
    };

    final response = await http.delete(
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
}