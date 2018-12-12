import 'package:try_angle/models/JsonResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async' show Future;

class Requester {
  static const API_KEY = "eeKlLouM8b4Y2EDbgbjalKDAcjnl04ul";
  static const ENDPOINT =
      'https://api.giphy.com/v1/gifs/random?api_key=&tag=work&rating=PG';

  Future<JsonResponse> fetchData() async {
    final response = await http.get(ENDPOINT, headers: {"api_key": API_KEY});
    if (response.statusCode == 200) {
      return JsonResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
