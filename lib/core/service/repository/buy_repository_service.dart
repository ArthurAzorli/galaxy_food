import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:galaxy_food/core/service/repository/repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/buy.dart';
import '../../utils/exception/repository_exception.dart';

class BuyRepositoryService {

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/buy";

  static Future<Buy> create(Buy buy) async {
    final idClient = await ClientRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/create/$idClient");

    var a = jsonEncode(buy.toJson());
    print(a);
    final response = await http.post(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
      body: a
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 201){
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<List<Buy>> getAll() async {
    final idClient = await ClientRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/get/$idClient?typeUser=client");

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

      List buysJson = jsonDecode(response.bodyBytes.toUTF8);
      return buysJson.map((buy){
        return Buy.fromJson(buy);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Buy> get(String id) async {
    final idClient = await ClientRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/get/$idClient/$id?typeUser=client");

    final response = await http.get(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
    );

    if (response.statusCode == 200){
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Buy> cancel(String id) async {
    final idClient = await ClientRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/cancel/$idClient/$id");

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

    if (response.statusCode == 200){
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<int> getCountBuy(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id?typeUser=restaurant");

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

      List buysJson = jsonDecode(response.bodyBytes.toUTF8);
      return buysJson.map((buy){
        return Buy.fromJson(buy);
      }).toList().length;

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }
}