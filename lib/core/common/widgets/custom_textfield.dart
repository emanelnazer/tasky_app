import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final MyValidator validator;

  TextFormFieldWidget({
    required this.controller,
    required this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          overflow: TextOverflow.ellipsis,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff454A4F),
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: outlineInputBorder(
          color: const Color(0xffBABABA),
          radius: 10,
          width: 1,
        ),
        focusedBorder: outlineInputBorder(
          color: const Color(0xff5F33E1),
          radius: 10,
          width: 1,
        ),
        errorBorder: outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
        focusedErrorBorder: outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
      ),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
    );
  }

  OutlineInputBorder outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
