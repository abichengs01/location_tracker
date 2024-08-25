import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_layout.dart';

class SingleColorButton extends StatelessWidget {
  final double width;
  final double fontSize;
  final double height;
  final String text;
  final Color color;
  final Color textColor;
  final Function()? function;
  final bool border;

  const SingleColorButton({
    Key? key,
    required this.width,
    this.height = 45,
    required this.text,
    required this.function,
    this.color = AppColor.primary,
    this.textColor = AppColor.white,
    this.border = false,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: border ? null : color,
        shape: RoundedRectangleBorder(
          side: border
              ? const BorderSide(color: AppColor.primary)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(
            AppLayout.cornerRadius,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppLayout.cornerRadius,
          ),
        ),
        child: InkWell(
          onTap: function,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: border ? AppColor.primary: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
