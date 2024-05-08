import 'dart:async';
import 'dart:convert';

import 'package:bengkelly_apps/credential/login page.dart';
import 'package:bengkelly_apps/customers/xroot/component/location_alert.dart';
import 'package:bengkelly_apps/customers/xroot/component/notification_alert.dart';
import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:bengkelly_apps/providers/auth.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/welcome_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'customers/home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  double backgroundOpacity = 0.6; // Opacity untuk latar belakang

  @override
  void initState() {
    super.initState();
    getOAuthData();
    // startLaunching();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(''),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
        toolbarHeight: 0,
      ),
      body: Center(
        child: Stack(
          children: [
            // Gambar latar belakang dengan opacity
            Opacity(
              opacity: backgroundOpacity,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(BACKGROUND_WELCOME),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    LOGO,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isLoading) // Tampilkan indikator loading jika isLoading true
                    CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method untuk mendapatkan data OAuth
  Future<void> getOAuthData() async {
    var permissionLocation = await Permission.location.isGranted;
    var permissionNotification = await Permission.notification.isGranted;
    var token = await auth.getToken();

    if (token != null) {
      if (permissionLocation && permissionNotification) {
        Navigator.of(context).pushReplacement(
          _createRoute(const TabPageCustomer()),
        );
      } else if (!permissionLocation || !permissionNotification) {
        Navigator.of(context).pushReplacement(
          _createRoute(
            !permissionLocation
                ? const LocationAlertPage()
                : const NotificationAlertPage(),
          ),
        );
      }
    } else {
      startLaunching();
    }
  }

  // Method untuk memulai launching
  Future<dynamic> startLaunching() async {
    var duration = const Duration(seconds: 0);
    await Future.delayed(duration); // Tunggu beberapa detik

    String? token = await auth.getToken();
    if (token != null) {
      // Token ditemukan, arahkan ke halaman beranda (home page)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TabPageCustomer()),
      );
    } else {
      // Token tidak ditemukan, arahkan ke halaman welcome login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeLogin2()),
      );
    }
  }

  // Fungsi untuk membuat rute kustom dengan transisi slide ke bawah
  Route _createRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -1.0); // Mulai dari atas
        var end = Offset.zero; // Akhir di tengah
        var curve = Curves.ease; // Kurva transisi
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

final auth = Auth();
