import 'package:flutter/material.dart';
import 'package:quickchance_app/features/auth/presentation/widgets/myInput.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Current Password:', style: TextStyle(fontSize: 18)),
          ),
          MyInput(
            hintText: 'enter current password',
            suffixIcon: Icon(Icons.lock),
            isPassword: true,
            textEditingController: currentPasswordController,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('New Password:', style: TextStyle(fontSize: 18)),
          ),
          MyInput(
            hintText: 'new password',
            suffixIcon: Icon(Icons.lock),
            isPassword: true,
            textEditingController: newPasswordController,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Confirm Password:', style: TextStyle(fontSize: 18)),
          ),
          MyInput(
            hintText: 'confirm password',
            suffixIcon: Icon(Icons.lock),
            isPassword: true,
            textEditingController: confirmPasswordController,
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              if (isLoading) {
                if (newPasswordController.text.isEmpty !=
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text(
                          'New Password mismatches with Confirm Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else {}
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child:
                    (isLoading)
                        ? CircularProgressIndicator.adaptive()
                        : Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
