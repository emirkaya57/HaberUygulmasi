import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:haber_uygulamasi/model/newsModel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();

  static ApiServices? _apiServices;

  static ApiServices getInstance() => _apiServices ??= ApiServices._();

  Future<List<Article>?> getNews(String categoryName) async {
    String api =
        'https://newsapi.org/v2/top-headlines?country=tr&category=$categoryName&apiKey=8dc5040e74934888b1d9c6a0467cef33';
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      debugPrint(responseJson.toString());
      NewsModel newsModel = NewsModel.fromJson(responseJson);
      return newsModel.articles;
    } else {
      return null;
    }
  }
}
