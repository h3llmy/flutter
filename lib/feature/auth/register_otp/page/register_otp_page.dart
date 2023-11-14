import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/register_otp/fetch_data/fetch_resend_otp.dart';
import 'package:flutter_application_1/feature/auth/register_otp/fetch_data/fetch_send_otp.dart';
import 'package:flutter_application_1/feature/auth/register_otp/type/resend_otp_response.dart';
import 'package:flutter_application_1/feature/auth/register_otp/type/send_otp_response.dart';
import 'package:flutter_application_1/global/utils/future_builder_error_handler.dart';
import 'package:flutter_application_1/global/utils/secure_storage.dart';
import 'package:flutter_application_1/global/widgets/show_error_dialog.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class RegisterOtpPage extends StatefulWidget {
  final String token;
  const RegisterOtpPage({Key? key, required this.token}) : super(key: key);

  @override
  State<RegisterOtpPage> createState() => _RegisterOtpPageState();
}

class _RegisterOtpPageState extends State<RegisterOtpPage> {
  bool _isLoading = false;
  final SecureStorage storage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: _isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : resendOtpForm());
  }

  Widget resendOtpForm() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(maxWidth: 500),
            child: OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              outlineBorderRadius: 50,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: const Color.fromARGB(156, 198, 198, 198),
                focusBorderColor: const Color.fromARGB(156, 204, 204, 204),
              ),
              onCompleted: (otp) {
                updateStatus(context, otp);
              },
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: InkWell(
              onTap: () {
                resendNewOtp(context);
              },
              child: const Text(
                "Resend Otp",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resendNewOtp(context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final ResendOtpResponse response = await resendOtp(widget.token);
      showErrorDialog(context, "New Otp Has Beed Sended");
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterOtpPage(token: response.token),
          ));
    } catch (e) {
      dynamic errorObject = errorHanler(e);
      showErrorDialog(context, errorObject['message']);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void updateStatus(context, String otp) async {
    try {
      setState(() {
        _isLoading = true;
      });
      SendOtpResponse response = await sendOtp(widget.token, otp);
      await storage.write("token", response.refreshToken);
      await Navigator.pushNamed(context, '/home');
    } catch (e) {
      dynamic errorObject = errorHanler(e);
      showErrorDialog(context, errorObject['message']);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
