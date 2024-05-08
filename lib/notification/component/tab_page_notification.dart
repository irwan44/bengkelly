import 'package:bengkelly_apps/notification/component/all_notification.dart';
import 'package:bengkelly_apps/notification/component/not_read_notification.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/my_colors.dart';

class TabPageNotification extends StatefulWidget {
  const TabPageNotification({super.key});

  @override
  State<TabPageNotification> createState() => _TabPageNotificationState();
}

class _TabPageNotificationState extends State<TabPageNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            _buildTabBar(),
            const Expanded(
              child: TabBarView(
                children: [
                  AllNotificationPage(),
                  NotReadNotification()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Material(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              color: Colors.transparent,
              child: TabBar(
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                unselectedLabelColor: const Color(0xFF8391A1),
                labelColor: MyColors.appPrimaryColor,
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyColors.blueOpacity,
                ),
                tabs: [
                  Tab(
                    child: Container(
                      height: 40,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: MyColors.blueOpacity, width: 1),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Semua",
                          style: TextStyle(fontSize: 12, fontFamily: 'Nunito'),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 45,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: MyColors.blueOpacity, width: 1),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Belum Dibaca",
                          style: TextStyle(fontSize: 12, fontFamily: 'Nunito'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 20,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 5, right: 20),
              child: Row(
                children: const [
                  Text(
                    'Sort',
                    style: TextStyle(fontSize: 15, fontFamily: 'Nunito'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ImageIcon(
                    AssetImage(IC_SORT),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
