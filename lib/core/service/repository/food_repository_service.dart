import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/food.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class FoodRepositoryService{

  static const String kApiRequest = "https://arthurazorli.github.io/GalaxyFoodServer/food";

  static Future<List<Food>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((food){
        return Food.fromJson(food);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<List<Food>> getOf(Restaurant restaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/get/restaurant/${restaurant.id}");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((food){
        return Food.fromJson(food);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<Food> get(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){
      return Food.fromJson(jsonDecode(response.body));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

}