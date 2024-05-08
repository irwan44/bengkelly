import 'dart:convert';

import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../providers/auth.dart';
import '../../../utils/constants.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/formfield_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHidePassword = false;
  bool hidePassword = false;
  bool isHideConfirmPassword = false;
  bool isLoading = false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isAllReceipt = true;

  @override
  void dispose() {
    currentPasswordController.clear();
    passwordController.clear();
    confirmPassController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Form(
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
          _buildFormCard(),
          const SizedBox(height: 25),
          Center(
            child: ButtonSubmitWidget(
              onPressed: changePassword,
              title: "Simpan Password",
              bgColor: MyColors.appPrimaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: MyColors.appPrimaryColor,
              loading: isLoading,
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     showModalBottomSheet(
          //       context: context,
          //       isScrollControlled: true,
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(36),
          //           topRight: Radius.circular(36),
          //         ),
          //       ),
          //       builder: (_) => const LanguageBottomSheetPage(),
          //     );
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Padding(
          //         padding: EdgeInsets.only(left: 30.0, top: 25, bottom: 5),
          //         child: Text(
          //           'Language',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.grey,
          //             fontFamily: 'Nunito',
          //             fontSize: 18,
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding:
          //             const EdgeInsets.only(right: 30.0, top: 20, bottom: 5),
          //         child: Container(
          //           padding: const EdgeInsets.only(
          //             left: 16,
          //             right: 16,
          //             top: 3,
          //             bottom: 3,
          //           ),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.rectangle,
          //             border: Border.all(
          //               color: MyColors.greyLanguage,
          //             ),
          //           ),
          //           child: const Text(
          //             'Language',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: Colors.grey,
          //               fontFamily: 'Nunito',
          //               fontSize: 18,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Current Password',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16,
            left: 30,
            right: 30,
          ),
          child: CustomTextFormField(
            controller: currentPasswordController,
            hintText: "Current Password",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            showCursor: true,
            cursorColor: Colors.black,
            validator: validateCurrentPassword,
            textInputType: TextInputType.text,
            obscureText: hidePassword ? false : true,
            suffix: InkWell(
              onTap: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              child: hidePassword
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
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'New Password',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16,
            left: 30,
            right: 30,
          ),
          child: CustomTextFormField(
            controller: passwordController,
            hintText: "New Password",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            showCursor: true,
            cursorColor: Colors.black,
            validator: validateNewPassword,
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
        // const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Retype New Password',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16,
            left: 30,
            right: 30,
          ),
          child: CustomTextFormField(
            controller: confirmPassController,
            hintText: "Retype New Password",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            showCursor: true,
            cursorColor: Colors.black,
            validator: confirmValidatePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputType: TextInputType.text,
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.transparent,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Pengaturan',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
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
    );
  }

  Future<void> changePassword() async {
    if (_formKey.currentState!.validate()) {
      // No any error in validation
      _formKey.currentState!.save();

      debugPrint('valid');
      try {
        dismissTextFieldFocus();

        _showLoading();

        var res = await auth.changePassword(
          currentPasswordController.text,
          passwordController.text,
          confirmPassController.text,
        );

        var result = json.decode(res);

        if (result['status'] == true) {
          showSnackBar(
            'Berhasil Ubah Password',
            SnackBarType.succes,
            SUCCESS_IC,
            context,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TabPageCustomer(
                tabIndex: 4,
              ),
            ),
          );

          currentPasswordController.clear();
          passwordController.clear();
          confirmPassController.clear();
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
      }
    }
  }

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }

  String? validateCurrentPassword(String? value) {
    if (value!.isEmpty) {
      return "New password is Required";
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value!.isEmpty) {
      return "New password is Required";
    } else if (!(value.length > 3)) {
      return "New password should contains more then 3 character";
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
