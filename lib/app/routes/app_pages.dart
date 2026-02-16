import 'package:get/get.dart';
import 'package:indian_hoax_news/app/modules/home/views/splash_view.dart';

import '/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.SPLASH, page: () => SplashView()),
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
  ];
}
