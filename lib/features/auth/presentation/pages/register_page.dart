import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickchance_app/features/auth/presentation/widgets/myInput.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Center(child: Image.asset('././lib/images/logo.png', height: 60)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'Hi There !',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
          ),
          Text(
            'fill in form to register',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          MyInput(
            hintText: 'username',
            suffixIcon: Icon(Icons.person, color: Colors.white),
            isPassword: false,
            textEditingController: username,
          ),
          MyInput(
            hintText: 'email',
            suffixIcon: Icon(Icons.email, color: Colors.white),
            isPassword: false,
            textEditingController: email,
          ),
          MyInput(
            hintText: 'phone number',
            suffixIcon: Icon(Icons.phone, color: Colors.white),
            isPassword: false,
            textEditingController: phoneNumber,
          ),
          MyInput(
            hintText: 'password',
            suffixIcon: Icon(Icons.lock, color: Colors.white),
            isPassword: true,
            textEditingController: password,
          ),
          MyInput(
            hintText: 'confirm password',
            suffixIcon: Icon(Icons.lock, color: Colors.white),
            isPassword: true,
            textEditingController: confirmPassword,
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = !isLoading;
              });
              if (isLoading) {
                if (email.text.isEmpty ||
                    password.text.isEmpty ||
                    username.text.isEmpty ||
                    password.text != confirmPassword.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'email, password or username can\'t be empty and passwords must match',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                  setState(() {
                    isLoading = !isLoading;
                  });
                }
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
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
              ),
            ),
          ),
          SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already Have An Account?',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => context.pushNamed('login'),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
