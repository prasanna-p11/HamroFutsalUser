import 'package:get/get.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/utils/shared_prefs.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), checkUserLogin);
  }

  checkUserLogin() async {
    var usr = await SharedPrefs().getUser();
    if (usr != null) {
      Get.offAllNamed(GetRoutes.entry);
    } else {
      Get.offAllNamed(GetRoutes.login);
    }
  }
}
