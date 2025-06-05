import 'package:flutter/material.dart';
import '../user/login.dart';
import '../user/register.dart';
import 'welcome_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          WelcomePage(
            title: "Kitap Dünyasına Hoşgeldiniz",
            onPressedCreate: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            onPressedLogin: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}