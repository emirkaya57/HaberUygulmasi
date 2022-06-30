import 'package:haber_uygulamasi/model/newsModel.dart';

class Utils {
  static List<Category> getCategory() {
    return [
      Category(categoryName: 'business'),
      Category(categoryName: 'entertainment'),
      Category(categoryName: 'health'),
      Category(categoryName: 'science'),
      Category(categoryName: 'sports'),
      Category(categoryName: 'technology'),
    ];
  }
}
