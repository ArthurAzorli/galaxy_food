import 'dart:convert';
import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/buy.dart';
import '../../utils/exception/repository_exception.dart';

class BuyRepositoryService {

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/buy";

  static Future<Buy> create(Buy buy) async {
    final endpointUri = Uri.parse("$kApiRequest/create");

    final response = await http.post(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
      body: jsonEncode(buy.toJson())
    );

    if (response.statusCode == 201){
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<List<Buy>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

    final response = await http.get(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
    );

    if (response.statusCode == 302){

      List<Map<String, dynamic>> buysJson = jsonDecode(response.bodyBytes.toUTF8);
      return buysJson.map((buy){
        return Buy.fromJson(buy);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Buy> get(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id");

    final response = await http.get(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
    );

    if (response.statusCode == 302){
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }
}