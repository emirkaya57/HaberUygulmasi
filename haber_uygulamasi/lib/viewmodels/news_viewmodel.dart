import 'package:flutter/widgets.dart';
import 'package:haber_uygulamasi/repository/news_repository.dart';

import '../locator.dart';
import '../model/newsModel.dart';

class NewsViewModel extends ChangeNotifier {
  List<Article>? newsList;

  Future<List<Article>?> listenNewsList() async => newsList;

  Future<List<Article>?> fetchNews(String categoryName) async {
    try {
      notifyListeners();
      newsList = await locator<NewsRepository>().fetchNews(categoryName);
      if (newsList == null || newsList!.isEmpty) {
        throw Exception('Veri yok.');
      }
      return newsList;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
    return null;
  }
}
