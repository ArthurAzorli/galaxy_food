import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/package.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class PackageRepositoryService{

  static const String kApiRequest = "https://arthurazorli.github.io/GalaxyFoodServer/package";

  static Future<List<Package>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((package){
        return Package.fromJson(package);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<List<Package>> getOf(Restaurant restaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/get/restaurant/${restaurant.id}");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> json = jsonDecode(response.body);
      return json.map((package){
        return Package.fromJson(package);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<Package> get(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){
      return Package.fromJson(jsonDecode(response.body));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

  static Future<Package> rootOf(Restaurant restaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/root/${restaurant.id}");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 302){
      return Package.fromJson(jsonDecode(response.body));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.body));
    }
  }

}