import 'dart:convert';
import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;

import '../../domain/address.dart';
import '../../domain/client.dart';
import '../../domain/phone.dart';
import '../../utils/exception/repository_exception.dart';

class ClientRepositoryService {

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/client";

  static Future<Client> create(Client client) async {
    final endpointUri = Uri.parse("$kApiRequest/create");

    final response = await http.post(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(client.toJson())
    );

    print("${response.statusCode} - ${response.bodyBytes.toUTF8}");

    if (response.statusCode == 201){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
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
    final endpointUri = Uri.parse("$kApiRequest/update");

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
    final endpointUri = Uri.parse("$kApiRequest/changepassword");

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
    final endpointUri = Uri.parse("$kApiRequest/addphone");

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
    final endpointUri = Uri.parse("$kApiRequest/addaddress");

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
    final endpointUri = Uri.parse("$kApiRequest/remphone/$id");

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
    final endpointUri = Uri.parse("$kApiRequest/remaddress/$id");

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

  static Future<bool> delete() async {
    final endpointUri = Uri.parse("$kApiRequest/delete");

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
}