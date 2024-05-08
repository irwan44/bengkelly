import 'dart:convert';

import 'package:bengkelly_apps/credential/login%20page.dart';
import 'package:bengkelly_apps/credential/verif_otp_page.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../providers/auth.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({Key? key}) : super(key: key);

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  dynamic result;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: _buildBody(),
        ),
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
                "Lupa Password?",
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
                "Jangan khawatir! Ini terjadi. Silakan masukkan\nalamat email yang tertaut dengan akun Anda.",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Nunito',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomTextFormField(
              controller: emailController,
              hintText: "Masukkan Email",
              showCursor: true,
              cursorColor: Colors.black,
              validator: validateEmail,
              hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              textInputType: TextInputType.text,
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: ButtonSubmitWidget(
              onPressed: () => sendCode(context),
              title: "Send Code",
              bgColor: MyColors.appPrimaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: MyColors.appPrimaryColor,
              loading: isLoading,
            ),
          ),
          _buildRegisterButton(),
          const SizedBox(height: 45),
        ],
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

  Widget _buildRegisterButton() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: RichText(
          text: TextSpan(
            text: 'Sudah punya akun?',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: ' Login Sekarang',
                style: TextStyle(
                    color: MyColors.appPrimaryColor,
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value){
    if(value!.isEmpty){
      return "Email is Required";
    }else{
      return null;
    }
  }

  Future<void> sendCode(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint('valid');
      try {
        dismissTextFieldFocus();

        _showLoading();

        var res = await auth.sendOTP(emailController.text);

        result = json.decode(res);
        if(result['status'] == true){
          showSnackBar(
            'Kode sudah terkirim!',
            SnackBarType.succes,
            SUCCESS_IC,
            context,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VerifyOTPPage(email: emailController.text),
          ));
        }
        _dismissLoading();
      } catch (error, stackTrace) {
        _dismissLoading();
        showSnackBar(
          '$error',
          SnackBarType.error,
          ERROR_IC,
          context,
        );
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
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
