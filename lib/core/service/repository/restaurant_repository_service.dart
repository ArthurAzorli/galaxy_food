import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/address.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class RestaurantRepositoryService{

  static const String kApiRequest = "https://arthurazorli.github.io/GalaxyFoodServer/restaurant";

  static Future<List<Restaurant>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((restaurant){
        return Restaurant.fromJson(restaurant);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
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
    );

    if (response.statusCode == 302){
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
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
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((restaurant){
        return Restaurant.fromJson(restaurant);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }
}