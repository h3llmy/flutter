import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/login/dto/login.dto.dart';
import 'package:flutter_application_1/feature/auth/login/fetchData/fetchLogin.dart';
import 'package:flutter_application_1/global/utils/futureBuilderErrorHandler.dart';
import 'package:flutter_application_1/global/utils/secureStorage.dart';
import 'package:flutter_application_1/global/widgets/showErrorDialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SecureStorage storage = SecureStorage();
  Future<LoginDto>? _futureLogin;
  String? _usernameError;
  String? _passwordError;

  void _login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    setState(() {
      _passwordError = null;
      _usernameError = null;
    });

    _futureLogin = login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Login Page'),
        ),
        body: buildFutureBuilder());
  }

  FutureBuilder<LoginDto> buildFutureBuilder() {
    return FutureBuilder<LoginDto>(
        future: _futureLogin,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                storage.write("token", snapshot.data!.refreshToken);
                Future.delayed(Duration.zero, () {
                  Navigator.pushNamed(context, "/home");
                });
              } else if (snapshot.hasError) {
                final errorObject = futureBuilderHanler(snapshot.error);
                if (errorObject["message"] == "error validation") {
                  _usernameError = errorObject["path"]["body"]["username"];
                  _passwordError = errorObject["path"]["body"]["password"];
                } else {
                  showErrorDialog(context, errorObject["message"]);
                }
              }
            default:
              return createLoginForm();
          }
          return createLoginForm();
        });
  }

  Center createLoginForm() {
    return Center(
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
                child: const Text('Login',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
