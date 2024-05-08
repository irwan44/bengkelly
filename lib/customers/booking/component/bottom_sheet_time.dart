import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import '../../../utils/my_colors.dart';

class BottomSheetTime extends StatefulWidget {
  final TextEditingController controller;
  final String selectedDate;
  final Function(String selectedDate, String time, String clock) setTimeRange;

  const BottomSheetTime({
    Key? key,
    required this.controller,
    required this.selectedDate,
    required this.setTimeRange,
  }) : super(key: key);

  @override
  State<BottomSheetTime> createState() => _BottomSheetTimeState();
}

class _BottomSheetTimeState extends State<BottomSheetTime> {
  TimeOfDay dateTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: MyColors.blackMenu,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                const Text(
                  'Pilih Jam',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Nunito',
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('a').format(
                        DateTime(2022, 1, 1, dateTime.hour, dateTime.minute)),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Nunito',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(53, 0, 53, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: TimePickerSpinner(
                  is24HourMode: false,
                  normalTextStyle: TextStyle(
                    fontSize: 18,
                    color: MyColors.greySeeAll,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  highlightedTextStyle: TextStyle(
                    fontSize: 18,
                    color: MyColors.blackMenu,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  spacing: 40,
                  isForce2Digits: true,
                  minutesInterval: 5,
                  itemHeight: 50,
                  itemWidth: 40,
                  onTimeChange: (time) {
                    setState(() {
                      dateTime = TimeOfDay.fromDateTime(time);
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Center(
              child: ButtonSubmitWidget(
                onPressed: () {
                  String time =
                      " ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${DateFormat('a').format(DateTime(2022, 1, 1, dateTime.hour, dateTime.minute))}";
                  // widget.controller.text = widget.selectedDate + time;
                  String clock = " ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                  widget.setTimeRange(widget.selectedDate, time, clock);
                  Navigator.pop(context);
                },
                title: "Pilih Jam",
                bgColor: MyColors.appPrimaryColor,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                borderSide: MyColors.appPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
    );
  }
}
