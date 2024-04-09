import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';

class customTextField extends StatefulWidget {
  final IconData? icon;
  final bool isPassword;
  final bool hideText;
  final String? hint;
  const customTextField({
    Key? key,
    required this.userFieldController,
    this.icon,
    this.hideText = false,
    this.isPassword = false,
    this.hint,
  }) : super(key: key);

  final TextEditingController userFieldController;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<customTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.userFieldController,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: primaryColor),
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
