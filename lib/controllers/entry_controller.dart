import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/futsal_controller.dart';
import 'package:hamro_futsal/screens/home/booking_screen.dart';
import 'package:hamro_futsal/screens/home/home_screen.dart';
import 'package:hamro_futsal/screens/home/profile_screen.dart';

class EntryController extends GetxController {
  int selectedBottomIndex = 0;

  @override
  void onInit() {
    super.onInit();
    Get.put(FutsalController());
  }

  List<Widget> body = [
    HomeScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];
  List<String> title = const [
    'Home',
    'Bookings',
    'Profile',
  ];
}
