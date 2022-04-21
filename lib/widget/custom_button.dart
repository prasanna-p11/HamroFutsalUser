import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.fontSize = 17,
    this.backgroundColor = const Color(0xff165a6f),
  }) : super(key: key);
  final Function onPressed;
  final String title;
  final double fontSize;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w500,
          ),
          softWrap: false,
        ),
      ),
    );
  }
}
