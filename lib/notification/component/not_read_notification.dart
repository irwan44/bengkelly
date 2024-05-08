import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/my_colors.dart';

class NotReadNotification extends StatefulWidget {
  const NotReadNotification({super.key});

  @override
  State<NotReadNotification> createState() => _NotReadNotificationState();
}

class _NotReadNotificationState extends State<NotReadNotification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: SizedBox(
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  tileColor: const Color(0xFFF7F8F9),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      IC_NOTIF_SUCCESS,
                      height: 65,
                    ),
                  ),
                  title: Text(
                    'Your Purchasing Succes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: MyColors.appPrimaryColor,
                    ),
                  ),
                  subtitle: Text(
                    '2 Minutes Ago...',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColors.grey,
                      fontFamily: 'Nunito',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');
  }
}
