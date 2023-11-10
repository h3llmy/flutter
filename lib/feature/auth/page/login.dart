import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/utils/fetch.dart';
import 'package:flutter_application_1/global/utils/secureStorage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  bool _isLoading = false;

  _showErrorDialog(Map<String, dynamic> body) {
    if (body['message'] == 'error validation') {
      setState(() {
        _usernameError = body['path']['body']['username'];
        _passwordError = body['path']['body']['password'];
      });
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(body['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    SecureStorage storage = SecureStorage();

    if (_isLoading == false) {
      setState(() {
        _isLoading = true;
        _passwordError = null;
        _usernameError = null;
      });

      final response = await post(
          'auth/login', {"username": username, "password": password});

      Map<String, dynamic> body = jsonDecode(response.body);

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        await storage.write('credential', body['refreshToken']);
        _navigateToHome();
      } else {
        _showErrorDialog(body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  errorText: _usernameError,
                ),
                autofocus: true,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordError,
                ),
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(_isLoading == false ? 'Login' : 'Loading...',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
