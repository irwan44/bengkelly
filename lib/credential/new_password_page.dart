import 'dart:convert';

import 'package:bengkelly_apps/providers/auth.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/widget/success_page.dart';
import 'package:bengkelly_apps/credential/login%20page.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/my_colors.dart';
import '../widget/formfield_widget.dart';

class NewPasswordPage extends StatefulWidget {
  final String? email;

  const NewPasswordPage({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHidePassword = false;
  bool isHideConfirmPassword = false;
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                "Password Baru",
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
                "Kata sandi baru Anda harus unik dari yang\ndigunakan sebelumnya.",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Nunito',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildFormCard(),
          const SizedBox(height: 25),
          Center(
            child: ButtonSubmitWidget(
              onPressed: () => resetPassword(context),
              title: "Reset Password",
              bgColor: MyColors.appPrimaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: MyColors.appPrimaryColor,
              loading: isLoading,
            ),
          ),
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

  Widget _buildFormCard() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextFormField(
            controller: passwordController,
            hintText: "New Password",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            showCursor: true,
            cursorColor: Colors.black,
            validator: validatePassword,
            textInputType: TextInputType.text,
            obscureText: isHidePassword ? false : true,
            suffix: InkWell(
              onTap: () {
                setState(() {
                  isHidePassword = !isHidePassword;
                });
              },
              child: isHidePassword
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextFormField(
            controller: confirmPassController,
            hintText: "Confirm New Password",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            showCursor: true,
            cursorColor: Colors.black,
            validator: confirmValidatePassword,
            textInputType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: isHideConfirmPassword ? false : true,
            suffix: InkWell(
              onTap: () {
                setState(() {
                  isHideConfirmPassword = !isHideConfirmPassword;
                });
              },
              child: isHideConfirmPassword
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint('valid');
      try {
        dismissTextFieldFocus();
        _showLoading();
        var res = await auth.resetPassword(
          widget.email,
          passwordController.text,
          confirmPassController.text,
        );
        var result = json.decode(res);
        if (result['status'] == true) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SuccessPage(
                imageData: SUCCESS_MARK,
                title: "Password Dirubah!",
                subtitle: "Password berhasil dirubah! Silakan login",
                titleButton: "Back To Login",
                classWidget: LoginPage(),
              ),
            ),
          );
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

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Required";
    } else if (!(value.length > 3)) {
      return "Password should contains more then 3 character";
    }
    return null;
  }

  String? confirmValidatePassword(String? value) {
    if (value!.isEmpty) {
      return "Confirm password is Required";
    } else if (!(value.length > 3)) {
      return "Confirm password should contains more then 3 character";
    } else if (!(value == passwordController.text)) {
      return "Confirm Password should be equal new password";
    }
    return null;
  }
}
