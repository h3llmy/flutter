import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/login/page/login_page.dart';
import 'package:flutter_application_1/feature/auth/register/page/register_page.dart';
import 'package:flutter_application_1/feature/home/page/home.dart';
import 'package:flutter_application_1/feature/splash_screeen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Auth',
      routes: {
        // '/': (context) => const RegisterOtpPage(token: "mantap"),
        '/': (context) => const SplashScreen(
              authorized: HomePage(),
              unauthorized: LoginPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
