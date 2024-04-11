import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/views/customtext.dart';
import 'package:my_app/views/navigation_bar.dart';

class CustomButton extends StatelessWidget {
  final Color labelColor;
  final String labelButton;
  final VoidCallback action;
  const CustomButton({
    super.key,
    this.labelColor = appbartextColor,
    required this.labelButton,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
       action();
      },
      // ignore: sort_child_properties_last
      child: customtitleText(label: labelButton, labelColor: labelColor),
      style: ElevatedButton.styleFrom(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: orangeColor,
          elevation: 10,
          padding: const EdgeInsets.all(15),
          shadowColor: blackColor),
    );
  }
}
