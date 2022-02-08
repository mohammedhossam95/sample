import 'package:sample_app/ui/home/home_screen.dart';
import 'package:sample_app/ui/splash_screen/splash_screen.dart';
import 'package:sample_app/utils/strings.dart';

class AppRoutes {
  static final routes = {
    splashRoute: (context) => const SplashScreen(),
    intialRoute: (context) => const MyHomePage(),
    homeRoute: (context) => const HomeScreen(),
  };
}
