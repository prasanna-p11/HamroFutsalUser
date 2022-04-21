import 'package:get/get.dart';
import 'package:hamro_futsal/screens/auth/login_screen.dart';
import 'package:hamro_futsal/screens/auth/signup_screen.dart';
import 'package:hamro_futsal/screens/auth/splash_screen.dart';
import 'package:hamro_futsal/screens/entry_screen.dart';
import 'package:hamro_futsal/screens/home/futsal_desc.dart';

class GetRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String entry = '/entry';
  static const String home = '/home';
  static const String futsalDesc = '/futsalDesc';
  static const String profile = '/profile';
  static const String bookings = '/bookings';

  static List<GetPage> routes = [
    GetPage(name: GetRoutes.splash, page: () => SplashScreen()),
    GetPage(name: GetRoutes.login, page: () => LoginScreen()),
    GetPage(name: GetRoutes.signup, page: () => SignupScreen()),
    GetPage(name: GetRoutes.entry, page: () => EntryScreen()),
    GetPage(name: GetRoutes.futsalDesc, page: () => FutsalDesc()),
  ];
}
