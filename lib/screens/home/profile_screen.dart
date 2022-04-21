import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/user_controller.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/utils/baseurl.dart';
import 'package:hamro_futsal/utils/shared_prefs.dart';
import 'package:hamro_futsal/widget/custom_button.dart';
import 'package:hamro_futsal/widget/custom_textform.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<UserController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'My Profile',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: controller.user.image == ''
                                      ? NetworkImage(
                                          'https://ui-avatars.com/api/?background=random&name=' +
                                              controller.user.name!,
                                        )
                                      : NetworkImage(
                                          baseurl + controller.user.image!,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black)),
                                child: const FaIcon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    controller.user.name!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.user.contact!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.user.address!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    onPressed: () {
                      showDialog(
                          context: (context),
                          builder: (context) {
                            return Dialog(
                              child: EditProfile(
                                nameController: controller.nameController,
                                contactController: controller.contactController,
                                addressController: controller.addressController,
                                onEdit: () {
                                  controller.editUser(context);
                                },
                              ),
                            );
                          });
                    },
                    title: 'Edit Profile',
                    backgroundColor: const Color(0xff166F28),
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return const Dialog(child: ChangePassword());
                              });
                        },
                        title: 'Change Password',
                        fontSize: 15,
                        backgroundColor: const Color(0xffD5952A),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                        onPressed: () {
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Logout?'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await SharedPrefs().removeUser();
                                          Get.offAllNamed(GetRoutes.splash);
                                        },
                                        child: const Text('Confirm'))
                                  ],
                                );
                              });
                        },
                        title: 'Logout',
                        fontSize: 15,
                        backgroundColor: const Color(0xffFF0707),
                      )
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: 'Old Password',
            obscureText: true,
            controller: controller.oldPasswordController,
            prefixIcon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: 'New Password',
            obscureText: true,
            controller: controller.newPasswordController,
            prefixIcon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hint: 'Confirm Password',
            obscureText: true,
            controller: controller.confirmPasswordController,
            prefixIcon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              title: 'Change',
              onPressed: () {
                controller.changePassword(context);
              }),
        ]),
      );
    });
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({
    Key? key,
    required this.nameController,
    required this.contactController,
    required this.addressController,
    required this.onEdit,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController contactController;
  final TextEditingController addressController;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.person),
                hint: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 10),
              const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CustomTextFormField(
                  prefixIcon: const FaIcon(FontAwesomeIcons.phoneAlt),
                  hint: 'Contact',
                  controller: contactController),
              const SizedBox(height: 10),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CustomTextFormField(
                prefixIcon: const FaIcon(FontAwesomeIcons.addressBook),
                hint: 'Address',
                controller: addressController,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      onEdit();
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
