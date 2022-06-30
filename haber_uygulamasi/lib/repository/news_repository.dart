import 'package:haber_uygulamasi/services/api_services.dart';

import '../model/newsModel.dart';

class NewsRepository {
  Future<List<Article>?> fetchNews(String categoryName) async {
    var result = ApiServices.getInstance().getNews(categoryName);
    return result;
  }
}
