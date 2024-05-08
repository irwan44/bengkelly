import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bengkelly_apps/credential/register_page.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';

import 'credential/login page.dart';

class WelcomeLogin2 extends StatelessWidget {
  const WelcomeLogin2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(''),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
          systemNavigationBarColor:  Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BACKGROUND_WELCOME),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        spreadRadius: 6,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        LOGO,
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      ButtonSubmitWidget(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              const LoginPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation =
                                animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                              const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        title: "Login",
                        bgColor: MyColors.appPrimaryColor,
                        textColor: Colors.white,
                        width: 200,
                        height: 60,
                        borderSide: MyColors.appPrimaryColor,
                      ),
                      const SizedBox(height: 20),
                      ButtonSubmitWidget(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              const RegisterPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation =
                                animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                              const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        title: "Register",
                        bgColor: Colors.white,
                        textColor: Colors.black,
                        width: 200,
                        height: 60,
                        borderSide: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
