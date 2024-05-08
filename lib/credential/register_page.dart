import 'package:bengkelly_apps/credential/car_register_page.dart';
import 'package:bengkelly_apps/model/register_model.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/button_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHide = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          child: _buildBody(),
        ),

    );
  }

  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Halo! Daftar untuk\nmemulai",
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
          _buildButton(),
          // _buildSSO(),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.fromLTRB(15, 0, 20, 0),
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

  Widget _buildButton() {
    return Column(
      children: [
        const SizedBox(height: 25),
        ButtonSubmitWidget(
          onPressed: usernameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  confirmPassController.text.isNotEmpty
              ? () {
                  if (_formKey.currentState!.validate()) {
                    // No any error in validation
                    _formKey.currentState!.save();

                    debugPrint('valid');

                    try {
                      dismissTextFieldFocus();

                      var registerData = RegisterModel(
                        userName: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPassController.text,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CarRegisterPage(registerModel: registerData),
                        ),
                      );
                    } catch (error, stackTrace) {
                      debugPrint(error.toString());
                      debugPrint(stackTrace.toString());
                    }
                  }
                }
              : () {
                  showSnackBar(
                    'Lengkapi Form Berikut',
                    SnackBarType.warning,
                    WARNING_IC,
                    context,
                  );
                  debugPrint("No Null");
                },
          title: "Next",
          bgColor: usernameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  confirmPassController.text.isNotEmpty
              ? MyColors.appPrimaryColor
              : MyColors.greyButton,
          textColor: Colors.white,
          width: MediaQuery.of(context).size.width / 1.3,
          height: 60,
          borderSide: usernameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  confirmPassController.text.isNotEmpty
              ? MyColors.appPrimaryColor
              : MyColors.greyButton,
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
              //     "Daftar Dengan",
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
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFormCard() {
    return Column(
      children: [
        const SizedBox(height: 51),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextFormField(
            controller: usernameController,
            hintText: "Nama Lengkap",
            cursorColor: Colors.black,
            showCursor: true,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            validator: validateUsername,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextFormField(
            controller: emailController,
            hintText: "Email",
            cursorColor: Colors.black,
            showCursor: true,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
        ),
        // const SizedBox(height: 15),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: CustomTextFormField(
        //     controller: addressController,
        //     hintText: "Alamat",
        //     cursorColor: Colors.black,
        //     showCursor: true,
        //     hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
        //     textInputType: TextInputType.emailAddress,
        //   ),
        // ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextFormField(
            controller: passwordController,
            hintText: "Password",
            cursorColor: Colors.black,
            showCursor: true,
            validator: validatePassword,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextFormField(
            controller: confirmPassController,
            hintText: "Confirm Password",
            cursorColor: Colors.black,
            validator: confirmValidatePassword,
            showCursor: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
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

  // Widget _buildSSO() {
  //   return Center(
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 55,
  //           width: 94,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(color: Colors.grey.shade300),
  //           ),
  //           child: Center(
  //             child: Image.asset(
  //               FB_IC,
  //               width: 25,
  //               height: 25,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 10),
  //         Container(
  //           height: 55,
  //           width: 95,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(color: Colors.grey.shade300),
  //           ),
  //           child: Center(
  //             child: Image.asset(
  //               GOOGLE_IC,
  //               width: 25,
  //               height: 25,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 10),
  //         Container(
  //           height: 55,
  //           width: 95,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(color: Colors.grey.shade300),
  //           ),
  //           child: Center(
  //             child: Image.asset(
  //               APPLE_IC,
  //               width: 25,
  //               height: 25,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRegisterButton() {
    return Align(
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
                },
            )
          ],
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email is Required";
    } else {
      return null;
    }
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Username is Required";
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
