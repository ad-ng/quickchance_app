import 'package:flutter/material.dart';
import 'package:quickchance_app/features/auth/presentation/widgets/myInput.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile'), centerTitle: true),
      body: Column(
        children: [
          MyInput(
            hintText: 'username',
            suffixIcon: Icon(Icons.person),
            isPassword: false,
            textEditingController: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
