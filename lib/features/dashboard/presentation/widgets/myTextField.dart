import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController myController;
  final String labelText;
  const MyTextField({
    super.key,
    required this.myController,
    required this.labelText,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.myController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        labelText: widget.labelText,
      ),
    );
  }
}
