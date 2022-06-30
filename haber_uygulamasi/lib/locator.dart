import 'package:get_it/get_it.dart';
import 'package:haber_uygulamasi/repository/news_repository.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(NewsRepository);
}
