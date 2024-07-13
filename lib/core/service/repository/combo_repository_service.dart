import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/combo.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class ComboRepositoryService{

  static const String kApiRequest = "https://arthurazorli.github.io/GalaxyFoodServer/combo";

  static Future<List<Combo>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((combo){
        return Combo.fromJson(combo);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
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

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((combo){
        return Combo.fromJson(combo);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
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
      return Combo.fromJson(jsonDecode(response.body));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

}