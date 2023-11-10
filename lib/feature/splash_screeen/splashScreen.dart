import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/utils/secureStorage.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SecureStorage storage = SecureStorage();
  @override
  void initState() async {
    Future.delayed(const Duration(seconds: 2), () {
      // String? isLogined = await storage.read('refreshToken');
      // print(isLogined);
      // if (isLogined.toString().isNotEmpty) {}
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome To Flutter",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
