import 'dart:async';
import 'dart:convert';

import 'package:bengkelly_apps/credential/new_password_page.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../providers/auth.dart';
import '../utils/constants.dart';

class VerifyOTPPage extends StatefulWidget {
  final String? email;

  const VerifyOTPPage({Key? key, this.email}) : super(key: key);

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  int length = 4;
  Color borderColor = const Color(0xFF35C2C1);
  Color errorColor = const Color.fromRGBO(255, 234, 238, 1);
  Color fillColor = const Color.fromRGBO(222, 231, 240, .57);
  bool showError = false;

  bool isLoading = false;
  dynamic result;
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 60;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingSeconds == 0) {
        _timer?.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 35),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Verifikasi OTP",
                style: TextStyle(
                  color: MyColors.appPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Masukkan kode verifikasi yang baru saja kami\nkirimkan ke alamat email Anda.",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Nunito',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: _buildOTP(),
          ),
          const SizedBox(height: 25),
          Center(
            child: ButtonSubmitWidget(
              onPressed: () => verifyOTP(context),
              title: "Verify",
              bgColor: MyColors.appPrimaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: MyColors.appPrimaryColor,
              loading: isLoading,
            ),
          ),
          _buildSendOTPButton(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildOTP() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Pinput(
          length: length,
          controller: pinController,
          focusNode: focusNode,
          validator: validateOTP,
          defaultPinTheme: PinTheme(
            width: 70,
            height: 60,
            textStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
          ),
          onCompleted: (pin) {
            setState(() => showError = pin != '5555');
          },
          focusedPinTheme: PinTheme(
            height: 68,
            width: 64,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
            ),
          ),
          errorPinTheme: PinTheme(
            decoration: BoxDecoration(
              color: errorColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.fromLTRB(30, 36, 0, 0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSendOTPButton() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: RichText(
          text: TextSpan(
            text: 'Belum dapat kode OTP?',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: _remainingSeconds == 0
                    ? ' Kirim Ulang'
                    : ' $_remainingSeconds detik',
                style: TextStyle(
                    color: MyColors.appPrimaryColor,
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      _remainingSeconds == 0 ? () => sendCode(context) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateOTP(String? value) {
    if (value!.isEmpty) {
      return "Field is Required";
    } else if (value.length < 4) {
      return "OTP less than 4 digit";
    } else {
      return null;
    }
  }

  Future<void> sendCode(BuildContext context) async {
    try {
      var res = await auth.sendOTP(widget.email);

      result = json.decode(res);
      showSnackBar(
        'Kode sudah terkirim!',
        SnackBarType.succes,
        SUCCESS_IC,
        context,
      );
    } catch (error, stackTrace) {
      showSnackBar(
        result['message'],
        SnackBarType.error,
        ERROR_IC,
        context,
      );
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
  }

  Future<void> verifyOTP(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint('valid');

      try {
        dismissTextFieldFocus();

        _showLoading();
        var res = await auth.verifyOTP(pinController.text);

        result = json.decode(res);

        if (result['status'] == true) {
          showSnackBar(
            '${result['message']}!',
            SnackBarType.succes,
            SUCCESS_IC,
            context,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewPasswordPage(email: widget.email),
          ));
        }
        _dismissLoading();
      } catch (error, stackTrace) {
        _dismissLoading();
        showSnackBar(
          'Kode OTP tidak valid',
          SnackBarType.error,
          ERROR_IC,
          context,
        );
        debugPrint(stackTrace.toString());
        debugPrint(error.toString());
      }
    }
  }

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }
}
