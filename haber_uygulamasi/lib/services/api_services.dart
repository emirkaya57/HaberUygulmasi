import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:haber_uygulamasi/model/newsModel.dart';
import 'package:http/http.dart' as http;

class ApiServices{
 
 
 static Future<List<Article>?> getNews()async{
   String api = 'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=8dc5040e74934888b1d9c6a0467cef33';
   var response = await http.get(Uri.parse(api));
    if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      debugPrint(responseJson.toString());
      NewsModel newsModel = NewsModel.fromJson(responseJson);
      return newsModel.articles;
    }else{
      return null;
    }
    
  }
}