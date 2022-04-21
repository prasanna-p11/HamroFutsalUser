import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.hint = "",
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
  }) : super(key: key);

  final String hint;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixIcon ?? Container(),
            ],
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            color: Color(0xff9c9c9c),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
