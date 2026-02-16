import 'package:get/get.dart';
import 'package:indian_hoax_news/controller/news_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }
}