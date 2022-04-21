import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/model/user.dart';
import 'package:hamro_futsal/utils/baseurl.dart';
import 'package:hamro_futsal/utils/custom_snackbar.dart';
import 'package:hamro_futsal/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  User user = User.fromJson({
    'user_id': '',
    'name': '',
    'email': '',
    'contact': '',
    'address': '',
  });

  File? imageFile;
  File? cvFile;

  late TextEditingController nameController,
      contactController,
      addressController,
      oldPasswordController,
      newPasswordController,
      confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    getUser();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    contactController.dispose();
    addressController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  getUser() async {
    var usr = await SharedPrefs().getUser();

    user = User.fromJson(json.decode(usr));
    nameController.text = user.name!;
    contactController.text = user.contact!;
    addressController.text = user.address!;

    update();
  }

  pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      uploadProfilePic();
    }
  }

  uploadProfilePic() async {
    var url = Uri.parse(baseurl + 'edit_user_profile_pic.php');
    var request = http.MultipartRequest("POST", url);
    request.fields["userId"] = user.userId!;
    if (imageFile != null) {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      //add multipart to request
      request.files.add(pic);
    }
    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);
    if (res["success"]) {
      user.image = res["data"];
      await SharedPrefs().storeUser(json.encode(user));
      customSnackbar('Success', res["message"][0], 'success');
    } else {
      customSnackbar('Failed', res["message"][0], 'error');
    }

    update();
  }

  editUser(context) async {
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        contactController.text.isEmpty) {
      customSnackbar('Error', 'Please fill all the fields', 'error');

      nameController.text = user.name!;
      contactController.text = user.contact!;
      addressController.text = user.address!;
      update();
      return;
    }

    var response =
        await http.post(Uri.parse(baseurl + 'editprofile.php'), body: {
      'user_id': user.userId!,
      'name': nameController.text,
      'contact': contactController.text,
      'address': addressController.text,
    });

    var res = await json.decode(response.body);
    if (res['success']) {
      Navigator.pop(context);
      customSnackbar('Success', 'Profile updated successfully', 'success');

      user.name = nameController.text;
      user.contact = contactController.text;
      user.address = addressController.text;

      await SharedPrefs().storeUser(json.encode(user));
      getUser();
    } else {
      customSnackbar('Error', 'Something went wrong', 'error');
    }
  }

  changePassword(context) async {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      customSnackbar('Error', 'Please fill all the fields', 'error');
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      customSnackbar(
          'Error', 'New password and confirm password do not match', 'error');
      return;
    }

    var response =
        await http.post(Uri.parse(baseurl + 'changePassword.php'), body: {
      'id': user.userId!,
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
    });

    var res = await json.decode(response.body);
    if (res['success']) {
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      Navigator.pop(context);
      customSnackbar('Success', 'Password changed successfully', 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }
}
