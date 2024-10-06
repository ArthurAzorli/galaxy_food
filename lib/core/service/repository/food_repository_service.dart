import 'dart:convert';

import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/food.dart';
import '../../utils/exception/repository_exception.dart';

class FoodRepositoryService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/food";

  static Future<List<Food>> getOf(String idRestaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$idRestaurant");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((food){
        return Food.fromJson(food);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Food> get(String idRestaurant, String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$idRestaurant/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){
      return Food.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

}