import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickchance_app/features/auth/data/model/login_model.dart';
import 'package:quickchance_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:quickchance_app/features/auth/presentation/widgets/myInput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!, style: TextStyle(fontSize: 20)),
            ),
          );
        }
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.response.username!,
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(child: Image.asset('././lib/images/logo.png', height: 60)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Hello Again !',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
              Text(
                'log into your account',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              MyInput(
                hintText: 'Enter Email',
                suffixIcon: Icon(Icons.email_outlined, color: Colors.white),
                isPassword: false,
                textEditingController: email,
              ),

              MyInput(
                hintText: 'Enter Password',
                suffixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                isPassword: true,
                textEditingController: password,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (email.text.isEmpty && password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'email or password can\'t be empty',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  }
                  BlocProvider.of<AuthCubit>(context).login(
                    LoginModel(email: email.text, password: password.text),
                  );
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
                    child: Text(
                      'Log in',
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
                    'Don\'t Have An Account?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
