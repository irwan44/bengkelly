import 'package:bengkelly_apps/customers/xroot/component/notification_alert.dart';
import 'package:bengkelly_apps/utils/box_storage.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationAlertPage extends StatefulWidget {
  const LocationAlertPage({Key? key}) : super(key: key);

  @override
  State<LocationAlertPage> createState() => _LocationAlertPageState();
}

class _LocationAlertPageState extends State<LocationAlertPage> {
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
                IC_LOCATION_ALERT,
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
                  'Dimana lokasimu?',
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
                  'Untuk menemukan penyedia layanan Bengkelly\nterdekat',
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
                onPressed: _requestLocationPermission,
                title: "Allow Location Access",
                bgColor: MyColors.appPrimaryColor,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                borderSide: MyColors.appPrimaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: ButtonSubmitWidget(
                onPressed: () {},
                title: "Enter Location Manually",
                bgColor: Colors.white,
                textColor: MyColors.appPrimaryColor,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                borderSide: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _requestLocationPermission() async {
    var permission = Permission.location;
    await permission.request();
    await putStorage(ACTIVATION_LOCATION, 'true');

    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const NotificationAlertPage()), (Route<dynamic> route) => false);
    });
  }
}
