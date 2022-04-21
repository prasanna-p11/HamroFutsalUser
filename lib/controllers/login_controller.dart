import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/model/user.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/utils/baseurl.dart';
import 'package:hamro_futsal/utils/custom_snackbar.dart';
import 'package:hamro_futsal/utils/shared_prefs.dart';
import 'package:hamro_futsal/widget/loader.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  checkLogin() {
    if (emailController.text.isEmpty) {
      customSnackbar('*Email', 'Please enter your email.', 'error');
    } else if (GetUtils.isEmail(emailController.text) == false) {
      customSnackbar('*Email', 'Please enter valid email.', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackbar('*Password', 'Please enter your password.', 'error');
    } else {
      Get.showOverlay(
          asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }

  login() async {
    var response = await http.post(Uri.parse(baseurl + 'login.php'), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      User user = User.fromJson(res['data']);
      await SharedPrefs().storeUser(json.encode(user));
      Get.offAllNamed(GetRoutes.entry);
    } else {
      customSnackbar('Login up failed!', res['message'][0], 'error');
    }
  }
}
