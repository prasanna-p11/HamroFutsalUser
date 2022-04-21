import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/entry_controller.dart';
import 'package:hamro_futsal/controllers/user_controller.dart';

class EntryScreen extends StatelessWidget {
  EntryScreen({Key? key}) : super(key: key);

  final entryController = Get.put(EntryController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EntryController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: BottomNavBar(
            selectedIndex: controller.selectedBottomIndex,
            onBottomChanged: (index) {
              controller.selectedBottomIndex = index;
              controller.update();
            }),
        body: controller.body[controller.selectedBottomIndex],
      );
    });
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key, required this.onBottomChanged, this.selectedIndex = 0})
      : super(key: key);

  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  final Function(int) onBottomChanged;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: backgroundColor,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: FontAwesomeIcons.home,
                  selected: selectedIndex == 0 ? true : false,
                  onPressed: () {
                    onBottomChanged(0);
                  }),
              IconBottomBar(
                  text: "Bookings",
                  icon: FontAwesomeIcons.tasks,
                  selected: selectedIndex == 1 ? true : false,
                  onPressed: () {
                    onBottomChanged(1);
                  }),
              IconBottomBar(
                  text: "Profile",
                  icon: FontAwesomeIcons.userAlt,
                  selected: selectedIndex == 2 ? true : false,
                  onPressed: () {
                    onBottomChanged(2);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff000000);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.black26,
          ),
        ),
      ],
    );
  }
}
