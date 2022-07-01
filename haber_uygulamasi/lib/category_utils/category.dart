import 'package:haber_uygulamasi/model/newsModel.dart';

class Utils {
  static List<Category> getCategory() {
    return [
      Category(categoryName: 'Business'),
      Category(categoryName: 'Entertainment'),
      Category(categoryName: 'Health'),
      Category(categoryName: 'Science'),
      Category(categoryName: 'Sports'),
      Category(categoryName: 'Technology'),
    ];
  }
}
