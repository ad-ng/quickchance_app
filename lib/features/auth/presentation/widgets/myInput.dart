import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  final String hintText;
  final Icon suffixIcon;
  final bool isPassword;
  final TextEditingController textEditingController;
  const MyInput({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.isPassword,
    required this.textEditingController,
  });

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  bool hidePassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: TextField(
        obscureText: hidePassword,
        cursorColor: Colors.white,
        controller: widget.textEditingController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: widget.suffixIcon,
          suffixIcon:
              (widget.isPassword)
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon:
                        (hidePassword)
                            ? Icon(Icons.remove_red_eye, color: Colors.white)
                            : Icon(
                              Icons.visibility_off_sharp,
                              color: Colors.white,
                            ),
                  )
                  : SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.black,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
