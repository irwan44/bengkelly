import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/my_colors.dart';

class NotReadMessage extends StatefulWidget {
  const NotReadMessage({super.key});

  @override
  State<NotReadMessage> createState() => _NotReadMessageState();
}

class _NotReadMessageState extends State<NotReadMessage> {
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
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              shrinkWrap: true,
              itemCount: 2,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  contentPadding: const EdgeInsets.all(5),
                  tileColor: MyColors.blueOpacity,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  trailing: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 10,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      IC_CONTACT,
                      height: 55,
                    ),
                  ),
                  title: const Text(
                    'Greg Micah',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Nunito',
                        color: Colors.black),
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
