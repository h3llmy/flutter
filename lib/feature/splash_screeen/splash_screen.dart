import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/utils/secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  final Widget? authorized;
  final Widget? unauthorized;
  const SplashScreen({super.key, this.authorized, this.unauthorized});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage storage = SecureStorage();

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
        MaterialPageRoute(builder: (context) => widget.authorized!),
        (route) => true);
  }

  Future<dynamic> redirectBack() {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.unauthorized!),
        (route) => true);
  }

  void checkAuthToken() async {
    String? authToken = await storage.read('token');
    if (authToken != null && authToken.isNotEmpty) {
      if (JwtDecoder.isExpired(authToken)) {
        redirectBack();
      } else {
        redirectNext();
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
