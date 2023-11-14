import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/login/type/login_response.dart';
import 'package:flutter_application_1/feature/auth/login/fetch_data/fetch_login.dart';
import 'package:flutter_application_1/global/utils/future_builder_error_handler.dart';
import 'package:flutter_application_1/global/utils/secure_storage.dart';
import 'package:flutter_application_1/global/widgets/show_error_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  bool _isLoading = false;
  SecureStorage storage = SecureStorage();

  void _login(context) async {
    String username = usernameController.text;
    String password = passwordController.text;
    if (_isLoading == false) {
      try {
        setState(() {
          _isLoading = true;
          _passwordError = null;
          _usernameError = null;
        });
        LoginResponse response = await login(username, password);
        await storage.write('token', response.refreshToken);
        await Navigator.pushNamed(context, '/home');
      } catch (e) {
        dynamic errorObject = errorHanler(e);
        if (errorObject['message'] == "error validation") {
          setState(() {
            _usernameError = errorObject['path']['body']['username'];
            _passwordError = errorObject['path']['body']['password'];
          });
        } else {
          return showErrorDialog(context, errorObject['message']);
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading == true
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: loginForm(),
              ),
      ),
    );
  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text(
              "Don't Have an Accout?",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            onPressed: () {
              _login(context);
            },
            child: const Text('Login',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }
}
