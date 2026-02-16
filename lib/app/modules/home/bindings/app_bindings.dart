import 'package:get/get.dart';
import 'package:indian_hoax_news/controller/news_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NewsController>(NewsController(), permanent: true);
  }
}
