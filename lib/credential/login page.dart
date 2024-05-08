import 'dart:convert';

import 'package:bengkelly_apps/credential/forget_password_page.dart';
import 'package:bengkelly_apps/credential/register_page.dart';
import 'package:bengkelly_apps/customers/xroot/component/location_alert.dart';
import 'package:bengkelly_apps/customers/xroot/component/notification_alert.dart';
import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:bengkelly_apps/providers/auth.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants.dart';
import '../utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHide = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
          systemNavigationBarColor:  Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(15, 7, 0, 7),
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
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _buildBody(),
      ),

    );
  }

  Widget _buildBody() {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 28),
      child: Column(
        children: [
          // _buildAppBar(context),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Selamat Datang!",
                style: TextStyle(
                  color: MyColors.appPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: _buildFormCard(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgetPassPage()));
                },
                child: const Text(
                  "Lupa Password?",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 16, fontFamily: 'Nunito'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ButtonSubmitWidget(
            onPressed: () => validateLoginAndSubmit(context),
            title: "Login",
            bgColor: MyColors.appPrimaryColor,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width / 1.3,
            height: 60,
            borderSide: MyColors.appPrimaryColor,
            loading: isLoading,
          ),
          const SizedBox(height: 25),
          Container(
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Divider(
                    color: Colors.grey.withOpacity(0.2),
                    thickness: 1,
                  ),
                ),
                // const Flexible(
                //   flex: 1,
                //   child: Text(
                //     "Login Dengan",
                //     style: TextStyle(
                //         color: Color(0xFFBDBDBD),
                //         fontSize: 14,
                //         fontFamily: 'Nunito'),
                //   ),
                // ),
                // Flexible(
                //   flex: 1,
                //   child: Divider(
                //     color: Colors.grey.withOpacity(0.2),
                //     thickness: 1,
                //   ),
                // ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // _buildSSO(),
          // const SizedBox(
          //   height: 40,
          // ),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  /// Section Widget
  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return CustomAppBar(
  //     context: context,
  //     leadingWidth: 80,
  //     height: 80,
  //     leading: Container(
  //       margin: const EdgeInsets.fromLTRB(15, 36, 20, 0),
  //       decoration: BoxDecoration(
  //         shape: BoxShape.rectangle,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(color: Colors.grey.shade300),
  //       ),
  //       child: InkWell(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: const Icon(
  //           Icons.arrow_back_ios_new,
  //           color: Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFormCard() {
    return Column(
      children: [
        const SizedBox(height: 51),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextFormField(
            controller: emailController,
            hintText: "Masukkan Email",
            showCursor: true,
            cursorColor: Colors.black,
            textInputType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextFormField(
            controller: passwordController,
            hintText: "Masukkan Password",
            showCursor: true,
            cursorColor: Colors.black,
            textInputType: TextInputType.text,
            validator: validatePassword,
            obscureText: isHide ? false : true,
            suffix: InkWell(
              onTap: () {
                setState(() {
                  isHide = !isHide;
                });
              },
              child: isHide
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
      ],
    );
  }

  Widget _buildSSO() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 55,
          width: 95,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Image.asset(
              FB_IC,
              width: 25,
              height: 25,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 55,
          width: 95,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Image.asset(
              GOOGLE_IC,
              width: 25,
              height: 25,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 55,
          width: 95,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Image.asset(
              APPLE_IC,
              width: 25,
              height: 25,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return RichText(
      text: TextSpan(
        text: 'Belum punya akun?',
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: ' Register Sekarang',
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
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }

  Future<void> validateLoginAndSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // No any error in validation
      _formKey.currentState!.save();

      debugPrint('valid');
      try {
        dismissTextFieldFocus();

        _showLoading();

        var res = await auth.login(
          emailController.text,
          passwordController.text,
        );

        var result = json.decode(res);

        if (result['status'] == true) {
          showSnackBar(
            'Berhasil Login',
            SnackBarType.succes,
            SUCCESS_IC,
            context,
          );
          // final activationLocation = await getStorage(ACTIVATION_LOCATION);
          var permissionLocation = await Permission.location.isGranted;
          var permissionNotification = await Permission.notification.isGranted;
          if (permissionLocation && permissionNotification) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) => const TabPageCustomer(),
            ), (Route<dynamic> route) => false);
          } else if (!permissionLocation || !permissionNotification) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                if (!permissionLocation) {
                  return const LocationAlertPage();
                } else {
                  return const NotificationAlertPage();
                }
              },
            ), (Route<dynamic> route) => false);
          }
        }
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
        // await reportError(error, stackTrace);
      }
    }
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const TabPageCustomer(),
    // ));
  }

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email is Required";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Required";
    } else if (!(value.length > 3)) {
      return "Password should contains more then 3 character";
    }
    return null;
  }
}
