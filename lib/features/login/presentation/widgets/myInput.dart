import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  const MyInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.black,
          hintText: 'Enter Names',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
