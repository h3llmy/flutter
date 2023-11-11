import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/utils/secureStorage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  final Widget? authorize;
  final Widget? notAuthorize;
  const SplashScreen({super.key, this.authorize, this.notAuthorize});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SecureStorage storage = SecureStorage();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      checkAuthToken();
    });
    super.initState();
  }

  Future<dynamic> redirectNext() {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.authorize!),
        (route) => false);
  }

  Future<dynamic> redirectBack() {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.notAuthorize!),
        (route) => false);
  }

  void checkAuthToken() async {
    String? authToken = await storage.read('token');
    if (authToken != null && authToken.isNotEmpty) {
      if (!JwtDecoder.isExpired(authToken)) {
        redirectNext();
      } else {
        redirectBack();
      }
    } else {
      redirectBack();
    }
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
