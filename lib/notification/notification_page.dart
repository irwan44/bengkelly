import 'package:bengkelly_apps/notification/component/tab_page_notification.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final String? notif;

  const NotificationPage({super.key, this.notif});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: const [
        SizedBox(height: 20),
        Expanded(child: TabPageNotification()),
      ],
    );
  }



  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Notification',
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
      // actions: [
      //
      // ],
    );
  }
}
