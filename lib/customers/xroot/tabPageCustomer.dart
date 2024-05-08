import 'package:bengkelly_apps/customers/booking/booking_page.dart';
import 'package:bengkelly_apps/customers/emergency_service/emergency_service_page.dart';
import 'package:bengkelly_apps/customers/history/history_page.dart';
import 'package:bengkelly_apps/customers/news/news_page.dart';
import 'package:bengkelly_apps/customers/profile/profile_page.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import '../home/home_page.dart';

class TabPageCustomer extends StatefulWidget {
  final int tabIndex;
  final String? address;
  const TabPageCustomer({
    Key? key,
    this.tabIndex = 0, this.address,
  }) : super(key: key);

  @override
  State<TabPageCustomer> createState() => _TabPageCustomerState();
}

class _TabPageCustomerState extends State<TabPageCustomer> {
  DateTime currentBackPressTime = DateTime.now();
  Widget currentPage = const HomePage();

  int currentTab = 0;

  bool isExpanded = false;

  List<Map<String, dynamic>> phoneNumbers = [
    {
      "phone": "+622317000685",
      "address": "Call Center Jabar",
    },
    {
      "phone": "+622433002390",
      "address": "Call Center Jateng",
    },
    {
      "phone": "+623160003860",
      "address": "Call Center Jatim",
    },
    {
      "phone": "+622150808195",
      "address": "Customer Care",
    },
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    currentTab = widget.tabIndex;
    if (currentTab == 0) {
      currentPage = HomePage(address: widget.address);
    } else if (currentTab == 1) {
      currentPage =  NewsPage();
    } else if (currentTab == 2) {
      currentPage = const BookingPage();
    } else if (currentTab == 3) {
      currentPage = const HistoryPage();
    } else {
      currentPage = const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: [
            PageStorage(
              bucket: bucket,
              child: currentPage,
            ),
            // const DraggableFabWidget(),
            DraggableFab(
              initPosition: const Offset(300, 580),
              child: Container(
                margin: const EdgeInsets.all(0),
                height: 75,
                width: 75,
                child: FloatingActionButton(
                  heroTag: 'Draggable',
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmergencyServicePage(),
                      ),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  child: Image.asset(FLOATING_EMERGENCY),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          heroTag: 'floating',
          elevation: 0,
          foregroundColor: Colors.transparent,
          backgroundColor: const Color(0xFFC93131),
          onPressed: () {
            setState(() {
              currentPage = const BookingPage();
              currentTab = 2;
            });
          },
          child: Image.asset(
            IC_BOOKING,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _launchPhoneCall(String phoneNumber) async {
    String uri = 'tel:$phoneNumber';
    try {
      await launch(uri);
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      color: MyColors.appPrimaryColor,
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Container(
          height: 80,
          margin: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: MaterialButton(
                      elevation: 0,
                      // padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: currentTab == 0
                              ? const Color(0xFFD7E1FE)
                              : MyColors.appPrimaryColor,
                        ),
                      ),
                      color: currentTab == 0
                          ? const Color(0xFFD7E1FE)
                          : MyColors.appPrimaryColor,
                      onPressed: () {
                        setState(() {
                          currentPage = HomePage(address: widget.address);
                          currentTab = 0;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IC_HOME,
                            color: currentTab == 0
                                ? MyColors.appPrimaryColor
                                : Colors.white,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 10,
                              color: currentTab == 0
                                  ? MyColors.appPrimaryColor
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: MaterialButton(
                      elevation: 0,
                      // padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                            color: currentTab == 1
                                ? const Color(0xFFD7E1FE)
                                : MyColors.appPrimaryColor),
                      ),
                      color: currentTab == 1
                          ? const Color(0xFFD7E1FE)
                          : MyColors.appPrimaryColor,
                      onPressed: () {
                        setState(() {
                          currentPage = NewsPage();
                          currentTab = 1;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IC_NEWS,
                            color: currentTab == 1
                                ? MyColors.appPrimaryColor
                                : Colors.white,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'News',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 10,
                              color: currentTab == 1
                                  ? MyColors.appPrimaryColor
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 14,
                      right: 5,
                      bottom: 14,
                    ),
                    child: MaterialButton(
                      elevation: 0,
                      // padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                            color: currentTab == 3
                                ? const Color(0xFFD7E1FE)
                                : MyColors.appPrimaryColor),
                      ),
                      color: currentTab == 3
                          ? const Color(0xFFD7E1FE)
                          : MyColors.appPrimaryColor,
                      onPressed: () {
                        setState(() {
                          currentPage = const HistoryPage();
                          currentTab = 3;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IC_HISTORY,
                            color: currentTab == 3
                                ? MyColors.appPrimaryColor
                                : Colors.white,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'History',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 10,
                              color: currentTab == 3
                                  ? MyColors.appPrimaryColor
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    child: MaterialButton(
                      elevation: 0,
                      // padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                            color: currentTab == 4
                                ? const Color(0xFFD7E1FE)
                                : MyColors.appPrimaryColor),
                      ),
                      color: currentTab == 4
                          ? const Color(0xFFD7E1FE)
                          : MyColors.appPrimaryColor,
                      onPressed: () {
                        setState(() {
                          currentPage = const ProfilePage();
                          currentTab = 4;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IC_PROFILE,
                            color: currentTab == 4
                                ? MyColors.appPrimaryColor
                                : Colors.white,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 10,
                              color: currentTab == 4
                                  ? MyColors.appPrimaryColor
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
