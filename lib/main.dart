import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/login/page/login.dart';
import 'package:flutter_application_1/feature/home/page/home.dart';
import 'package:flutter_application_1/feature/splash_screeen/splashScreen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      routes: {
        '/': (context) => const SplashScreen(
              authorize: HomePage(),
              notAuthorize: LoginPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
