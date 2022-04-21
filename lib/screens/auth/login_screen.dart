import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/login_controller.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/widget/custom_button.dart';
import 'package:hamro_futsal/widget/custom_textform.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

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
            child: GetBuilder<LoginController>(builder: (controller) {
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
                          'Welcome!',
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
                                    'Login',
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
                                    hint: 'Email',
                                    prefixIcon:
                                        const FaIcon(FontAwesomeIcons.envelope),
                                    controller: controller.emailController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hint: 'Password',
                                    prefixIcon:
                                        const FaIcon(FontAwesomeIcons.key),
                                    obscureText: true,
                                    controller: controller.passwordController,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                      onPressed: () {
                                        controller.checkLogin();
                                      },
                                      title: 'Login'),
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
                                          text: 'Don\'t have an account? ',
                                        ),
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.toNamed(GetRoutes.signup);
                                            },
                                          text: 'Sign Up',
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
