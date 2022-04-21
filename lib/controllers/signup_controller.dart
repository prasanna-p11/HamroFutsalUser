import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/utils/baseurl.dart';
import 'package:hamro_futsal/utils/custom_snackbar.dart';
import 'package:hamro_futsal/widget/loader.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  late TextEditingController nameController,
      contactController,
      addressController,
      emailController,
      passwordController,
      confirmPasswordController;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();

    nameController.dispose();
    contactController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  checkSignup() {
    if (nameController.text.isEmpty) {
      customSnackbar('*Name', 'Please enter your name.', 'error');
    } else if (contactController.text.isEmpty) {
      customSnackbar('*Contact', 'Please enter your contact.', 'error');
    } else if (addressController.text.isEmpty) {
      customSnackbar('*Address', 'Please enter your address.', 'error');
    } else if (emailController.text.isEmpty) {
      customSnackbar('*Email', 'Please enter your email.', 'error');
    } else if (GetUtils.isEmail(emailController.text) == false) {
      customSnackbar('*Email', 'Please enter valid email.', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackbar('*Password', 'Please enter your password.', 'error');
    } else if (confirmPasswordController.text != passwordController.text) {
      customSnackbar('*Confirm Password', 'Password doesnot match!', 'error');
    } else {
      Get.showOverlay(
          asyncFunction: () => signup(), loadingWidget: const Loader());
    }
  }

  signup() async {
    var response = await http.post(Uri.parse(baseurl + 'signup.php'), body: {
      'name': nameController.text,
      'contact': contactController.text,
      'address': addressController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      Get.offAllNamed(GetRoutes.login);
    } else {
      customSnackbar('Sign up failed!', res['message'], 'error');
    }
  }
}
