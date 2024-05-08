import 'package:bengkelly_apps/customers/booking/component/bottom_sheet_time.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../widget/button_widget.dart';

class BottomSheetSchedule extends StatefulWidget {
  final TextEditingController controller;
  final Function(String selectedDate, String time, String clock) setRangeTime;

  const BottomSheetSchedule({
    Key? key,
    required this.controller,
    required this.setRangeTime,
  }) : super(key: key);

  @override
  State<BottomSheetSchedule> createState() => _BottomSheetScheduleState();
}

class _BottomSheetScheduleState extends State<BottomSheetSchedule> {
  // bool isDatePicker = false;
  DateTime currentStartDate = DateTime.now(), currentEndDate = DateTime.now();
  String selectedDate = '';
  String? dateCount;
  String? range;
  String? rangeCount;

  @override
  void initState() {
    super.initState();

    currentStartDate = DateTime.now().subtract(const Duration(days: 4));
    currentEndDate = DateTime.now().add(const Duration(days: 3));
    selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    dateCount = '';
    range = '';
    rangeCount = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
                  'Pilih Jadwal',
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
              child: Text(
                selectedDate,
                style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Nunito',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _buildDatePicker(),
            const SizedBox(
              height: 7,
            ),
            Center(
              child: ButtonSubmitWidget(
                onPressed: _setRangeDate,
                title: "Pilih Jadwal",
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

  Widget _buildDatePicker() {
    return SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      headerStyle: const DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
          color: Colors.black,
        ),
      ),
      selectionShape: DateRangePickerSelectionShape.circle,
      selectionRadius: 50,
      view: DateRangePickerView.month,
      showNavigationArrow: true,
      yearCellStyle: const DateRangePickerYearCellStyle(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
        todayTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
        todayCellDecoration: BoxDecoration(
          color: Color(0xFFD7E1FE),
        ),
      ),
      selectionColor: const Color(0xFFD7E1FE),
      selectionTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Nunito',
      ),
      todayHighlightColor: Colors.grey,
      monthCellStyle:  DateRangePickerMonthCellStyle(
        todayCellDecoration: BoxDecoration(
          color: Colors.red.shade300,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
      ),
      monthViewSettings: const DateRangePickerMonthViewSettings(
        dayFormat: 'EEE',
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Nunito',
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _setRangeDate() {
    if (selectedDate == '') {
      setState(() {
        selectedDate =
            DateFormat('dd/MM/yyyy').format(currentStartDate).toString();
      });
    }
    // print(range);

    setState(() {
      // widget.onPickedDate(range, '');
      widget.controller.text = selectedDate;
      Navigator.pop(context);
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        builder: (_) => BottomSheetTime(
          controller: widget.controller,
          selectedDate: selectedDate,
          setTimeRange: widget.setRangeTime,
        ),
      );
    });
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        // 2019-04-29
        range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString();
      } else if (args.value is DateTime) {
        selectedDate = DateFormat('dd/MM/yyyy').format(args.value).toString();
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
      } else {
        rangeCount = args.value.length.toString();
      }
    });
  }
}
