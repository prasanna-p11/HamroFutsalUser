import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/signup_controller.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/widget/custom_button.dart';
import 'package:hamro_futsal/widget/custom_textform.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-0.885, -0.941),
              end: Alignment(0.78, 0.971),
              colors: [Color(0xfff9f9f9), Color(0xff064f65)],
              stops: [0.0, 1.0],
            ),
            border: Border.all(width: 1.0, color: const Color(0xff707070)),
          ),
          child: SingleChildScrollView(
            child: GetBuilder<SignupController>(builder: (controller) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 140,
                    width: 140,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create an Account',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 35,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        ),
                        const Text(
                          'to Hamro Futsal.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0x99ffffff),
                            borderRadius: BorderRadius.circular(17.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 25,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    softWrap: false,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    hint: 'Full Name',
                                    prefixIcon:
                                        const FaIcon(FontAwesomeIcons.user),
                                    controller: controller.nameController,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                      hint: 'Email',
                                      prefixIcon: const FaIcon(
                                          FontAwesomeIcons.envelope),
                                      controller: controller.emailController),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    hint: 'Password',
                                    prefixIcon:
                                        const FaIcon(FontAwesomeIcons.key),
                                    obscureText: true,
                                    controller: controller.passwordController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hint: 'Confirm Password',
                                    prefixIcon:
                                        const FaIcon(FontAwesomeIcons.key),
                                    obscureText: true,
                                    controller:
                                        controller.confirmPasswordController,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    hint: 'Address',
                                    prefixIcon: const FaIcon(
                                        FontAwesomeIcons.addressBook),
                                    controller: controller.addressController,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    hint: 'Contact',
                                    prefixIcon:
                                        const FaIcon(FontAwesomeIcons.phoneAlt),
                                    controller: controller.contactController,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                      onPressed: () {
                                        controller.checkSignup();
                                      },
                                      title: 'Sign Up'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 17,
                                        color: Color(0xffffffff),
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Already have an account? ',
                                        ),
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.toNamed(GetRoutes.login);
                                            },
                                          text: 'Login',
                                          style: const TextStyle(
                                            color: Color(0xff070772),
                                          ),
                                        ),
                                      ],
                                    ),
                                    textHeightBehavior:
                                        const TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                    softWrap: false,
                                  )
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
