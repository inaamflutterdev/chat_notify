import 'package:chat_notify/widgets/login_widgets/my_textfield.dart';
import 'package:chat_notify/widgets/login_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final void Function()? onTap;
  LoginPage({required this.onTap, super.key});

  void login() {}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              size: screenHeight * 0.1,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Text(
              "Welcome back, you have been missed!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: screenWidth * 0.05),
            ),
            SizedBox(
              height: screenHeight * 0.035,
            ),
            MyTextField(
              hintText: 'Email',
              hide: false,
              controller: emailController,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            MyTextField(
              hintText: 'Password',
              hide: true,
              controller: passController,
            ),
            SizedBox(
              height: screenHeight * 0.035,
            ),
            MyButton(
              buttonText: 'Login',
              onTap: login,
            ),
            SizedBox(
              height: screenHeight * 0.035,
            ),
            GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
