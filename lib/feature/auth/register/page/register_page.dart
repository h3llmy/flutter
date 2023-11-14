import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/register/fetch_data/fetch_register.dart';
import 'package:flutter_application_1/feature/auth/register_otp/page/register_otp_page.dart';
import 'package:flutter_application_1/feature/auth/register/type/register_response.dart';
import 'package:flutter_application_1/global/utils/future_builder_error_handler.dart';
import 'package:flutter_application_1/global/utils/secure_storage.dart';
import 'package:flutter_application_1/global/widgets/show_error_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isLoading = false;
  final SecureStorage storage = SecureStorage();

  void _login(context) async {
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (_isLoading == false) {
      try {
        setState(() {
          _isLoading = true;
          _emailError = null;
          _usernameError = null;
          _passwordError = null;
          _confirmPasswordError = null;
        });
        RegisterResponse response =
            await register(email, username, password, confirmPassword);
        // await storage.write('registerToken', response.token);
        // await Navigator.pushNamed(context, '/home');
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterOtpPage(token: response.token),
            ));
      } catch (e) {
        dynamic errorObject = errorHanler(e);
        if (errorObject['message'] == "error validation") {
          setState(() {
            _emailError = errorObject['path']['body']['email'];
            _usernameError = errorObject['path']['body']['username'];
            _passwordError = errorObject['path']['body']['password'];
            _confirmPasswordError =
                errorObject['path']['body']['confirmPassword'];
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
                child: registerForm(),
              ),
      ),
    );
  }

  Widget registerForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: _emailError,
          ),
          autofocus: true,
        ),
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            errorText: _usernameError,
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: _passwordError,
          ),
          obscureText: true,
        ),
        TextField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            errorText: _confirmPasswordError,
          ),
          obscureText: true,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              "Already Have an Accout?",
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
            child: const Text(
              'Register',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
