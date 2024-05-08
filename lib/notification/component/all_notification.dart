import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';

class AllNotificationPage extends StatefulWidget {
  const AllNotificationPage({super.key});

  @override
  State<AllNotificationPage> createState() => _AllNotificationPageState();
}

class _AllNotificationPageState extends State<AllNotificationPage> {
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
