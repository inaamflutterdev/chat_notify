import 'package:chat_notify/services/auth/auth_service.dart';
import 'package:chat_notify/widgets/login_widgets/my_textfield.dart';
import 'package:chat_notify/widgets/login_widgets/my_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confmpassController = TextEditingController();
  final void Function()? onTap;
  SignUpPage({required this.onTap, super.key});

  void signUp(BuildContext context) {
    // get auth Service
    final auth = AuthService();
    // if passwords match
    if (passController.text == confmpassController.text) {
      try {
        auth.signUpWithEmailPassword(
          emailController.text,
          passController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    // if passwords don't match
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
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
                "Let's create an account for you",
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
                height: screenHeight * 0.02,
              ),
              MyTextField(
                hintText: 'Confirm Password',
                hide: true,
                controller: confmpassController,
              ),
              SizedBox(
                height: screenHeight * 0.035,
              ),
              MyButton(
                buttonText: 'Sign Up',
                onTap: () => signUp(context),
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
                      "Already have an account? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      "Login",
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
      ),
    );
  }
}
