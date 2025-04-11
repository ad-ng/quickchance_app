import 'package:flutter/material.dart';
import 'package:quickchance_app/features/login/presentation/widgets/myInput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(child: Image.asset('././lib/images/logo.png', height: 60)),
          Text(
            'Hello Again !',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
          ),
          Text(
            'log into your account',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          MyInput(),
        ],
      ),
    );
  }
}
