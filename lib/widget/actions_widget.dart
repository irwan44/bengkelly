// import 'package:bengkelly_apps/message/message_page.dart';
import 'package:bengkelly_apps/notification/notification_page.dart';
import 'package:flutter/material.dart';
import '../customers/profile/component/help_center_page.dart';
import '../utils/constants.dart';
import '../utils/my_colors.dart';

class ActionWidget extends StatefulWidget {
  const ActionWidget({
    super.key,
  });

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  bool isClicked = false;

  @override
  void initState() {
    debugPrint('initState');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 35,
          width: 35,
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HelpCenterPage(),
                ),
              );
            },
            icon: Image.asset(
              IC_CHAT,
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const NotificationPage(),
        //             ),
        //           );
        //         },
        //         icon: Icon(
        //           Icons.notifications_none,
        //           size: 25,
        //           color: MyColors.appPrimaryColor,
        //         ),
        //       ),
        //       Visibility(
        //         child: Positioned(
        //           right: 17,
        //           top: 21,
        //           child: Container(
        //             // padding: const EdgeInsets.all(2),
        //             decoration: BoxDecoration(
        //               color: const Color(0xFFC93131),
        //               borderRadius: BorderRadius.circular(6),
        //             ),
        //             constraints: const BoxConstraints(
        //               minWidth: 7,
        //               minHeight: 7,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
