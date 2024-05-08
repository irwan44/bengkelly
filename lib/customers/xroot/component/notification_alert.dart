import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/box_storage.dart';

class NotificationAlertPage extends StatefulWidget {
  const NotificationAlertPage({Key? key}) : super(key: key);

  @override
  State<NotificationAlertPage> createState() => _NotificationAlertPageState();
}

class _NotificationAlertPageState extends State<NotificationAlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                IC_NOTIFICATION,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  'Aktifkan Akses\nNotifikasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  'Aktifkan notifikasi untuk menerima pembaruan\nwaktu nyata',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.1,
                  style: TextStyle(
                    color: MyColors.greySeeAll,
                    fontSize: 14,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: ButtonSubmitWidget(
                onPressed: _requestPermissionNotification,
                title: "Allow Notification",
                bgColor: MyColors.appPrimaryColor,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                borderSide: MyColors.appPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _requestPermissionNotification() async {
    var permission = Permission.notification;

    await permission.request();

    await putStorage(ACTIVATION_NOTIFICATION, 'true');
    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const TabPageCustomer()), (Route<dynamic> route) => false);
    });
  }
}
