import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashScreen = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 180,
                width: 180,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Hamro Futsal',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 35,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              ),
              const Text(
                'All Out, All Game, All Season',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
