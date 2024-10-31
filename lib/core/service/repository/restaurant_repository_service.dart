import 'dart:convert';

import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/address.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class RestaurantRepositoryService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/restaurant";

  static Future<List<Restaurant>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){
      List json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((restaurant){
        return Restaurant.fromJson(restaurant);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> get(String id, {Address? address}) async {
    var url = "$kApiRequest/get/$id";

    if(address != null) url += "?address=$address";

    final endpointUri = Uri.parse(url);

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){
      return Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<List<Restaurant>> search(String text, {Address? address}) async {
    var url = "$kApiRequest/search?text=$text";

    if(address != null) url += "&address=$address";

    final endpointUri = Uri.parse(url);

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){

      List json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((restaurant){
        return Restaurant.fromJson(restaurant);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> score(String idRestaurant, String idClient, double score) async {
    var url = "$kApiRequest/score/$idRestaurant/$idClient?score=$score";

    final endpointUri = Uri.parse(url);

    final response = await http.put(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    print(response.body);

    if (response.statusCode == 202){
      return Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }
}