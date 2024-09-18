import 'dart:convert';

import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/combo.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class ComboRepositoryService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/combo";

  static Future<List<Combo>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((combo){
        return Combo.fromJson(combo);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<List<Combo>> getOf(Restaurant restaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/get/restaurant/${restaurant.id}");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((combo){
        return Combo.fromJson(combo);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Combo> get(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){
      return Combo.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

}