import 'package:bengkelly_apps/customers/booking/component/bottom_sheet_schedule.dart';
import 'package:bengkelly_apps/customers/booking/component/bottom_sheet_service.dart';
import 'package:bengkelly_apps/customers/booking/component/bottom_sheet_vehicle.dart';
import 'package:bengkelly_apps/customers/booking/detail_booking.dart';
import 'package:bengkelly_apps/model/get_service.dart';
import 'package:bengkelly_apps/model/get_vehicle.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../providers/api.dart';
import '../../utils/constants.dart';
import '../../widget/actions_widget.dart';
import '../../widget/button_widget.dart';
import '../../widget/formfield_widget.dart';
import 'component/bottom_sheet_location.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController serviceTypeController = TextEditingController();

  TextEditingController locationMapsController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController complaintController = TextEditingController();
  String datePick = '';
  String timePick = '';
  String timeWithExtension = '';
  int? idVehicle;
  int? idLocation;
  Vehicle? vehicleType;
  Service? serviceType;

  @override
  void initState() {
    getVehicle();
    super.initState();
  }

  Future<void> getVehicle() async {
    var vehicle = await api.getMerkVehicles();
    if (vehicle != null) {
      setState(() {
        vehicleTypeController = TextEditingController(
            text: '${vehicle.merks?.namaMerk} - ${vehicle.tipes?[0].namaTipe}');
        vehicleType = vehicle;
      });
    }
  }

  @override
  void dispose() {
    vehicleTypeController.dispose();
    serviceTypeController.dispose();
    locationMapsController.dispose();
    scheduleController.dispose();
    complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        right: 30,
        left: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jenis Kendaraan',
            style: TextStyle(
              fontSize: 12,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextFormField(
            controller: vehicleTypeController,
            hintText: "Jenis Kendaran",
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            readOnly: true,
            validator: validateForm,
            suffix: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: MyColors.blackMenu,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                builder: (_) => BottomSheetVehicleType(
                  controller: vehicleTypeController,
                  vehicleType: vehicleType,
                  idVehicle: idVehicle,
                  isSelectedVehicle: (Vehicle? selectedVehicle) {
                    setState(() {
                      vehicleTypeController = TextEditingController(
                          text:
                              '${selectedVehicle?.merks?.namaMerk} - ${selectedVehicle?.tipes?[0].namaTipe}');
                      // idVehicle = selectedVehicle?.id;
                      vehicleType = selectedVehicle;
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Lokasi Bengkelly',
            style: TextStyle(
              fontSize: 12,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // SearchableDropdown.future(
          //   hintText: const Text(
          //     "Lokasi Bengkelly",
          //     style: TextStyle(fontSize: 16, fontFamily: 'Nunito'),
          //   ),
          //   trailingIcon: Icon(
          //     Icons.location_on,
          //     size: 20,
          //     color: MyColors.greySeeAll,
          //   ),
          //   hasTrailingClearIcon: false,
          //   dialogOffset: 2,
          //   backgroundDecoration: (child) {
          //     return InputDecorator(
          //       decoration: InputDecoration(
          //         isDense: true,
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: theme.colorScheme.primaryContainer,
          //             width: 1,
          //           ),
          //         ),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: theme.colorScheme.primaryContainer,
          //             width: 1,
          //           ),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: theme.colorScheme.primaryContainer,
          //             width: 1,
          //           ),
          //         ),
          //       ),
          //       child: child,
          //     );
          //   },
          //   controller: locationController,
          //   futureRequest: () async {
          //     final paginatedList = await api.getLokasi();
          //     return paginatedList.data
          //         ?.map(
          //           (e) => SearchableDropdownMenuItem(
          //             value: Lokasi(id: e.id, nama: e.nama, alamat: e.alamat),
          //             label: e.alamat ?? '',
          //             child: Text(e.nama ?? ''),
          //           ),
          //         )
          //         .toList();
          //   },
          //   onChanged: (value) {
          //     setState(() {
          //       if (value is Lokasi) {
          //         locationController.searchText = value.nama ?? '';
          //         idLocation = value.id;
          //       }
          //     });
          //   },
          // ),
          CustomTextFormField(
            controller: locationMapsController,
            hintText: "Lokasi Bengkelly",
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            readOnly: true,
            suffix: Icon(
              Icons.location_on,
              size: 20,
              color: MyColors.greySeeAll,
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomSheetLocation(
                      controller: locationMapsController,
                      onSelected: (String locationRestArea, int? idLocations) {
                        setState(() {
                          locationMapsController.text = locationRestArea;
                          idLocation = idLocations;
                        });
                      }),
                ),
              );
              // if(res != null){
              //   locationMapsController.text = res;
              // }
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(36),
              //       topRight: Radius.circular(36),
              //     ),
              //   ),
              //   builder: (_) => BottomSheetLocation(
              //     controller: locationMapsController,
              //   ),
              // );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Pilih Jadwal',
            style: TextStyle(
              fontSize: 12,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextFormField(
            controller: scheduleController,
            hintText: "Pilih Jadwal",
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            readOnly: true,
            validator: validateForm,
            suffix: Icon(
              Icons.calendar_month_outlined,
              size: 20,
              color: MyColors.greySeeAll,
            ),
            onTap: () {
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
                builder: (_) => BottomSheetSchedule(
                    controller: scheduleController,
                    setRangeTime: (
                      String selectedDate,
                      String time,
                      String clock,
                    ) {
                      setState(() {
                        scheduleController.text = selectedDate + time;

                        datePick = selectedDate;
                        timePick = clock;
                        timeWithExtension = time;
                        debugPrint(clock);
                        debugPrint(selectedDate);
                      });
                    }),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Jenis Servis',
            style: TextStyle(
              fontSize: 12,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextFormField(
            controller: serviceTypeController,
            hintText: "Jenis Servis",
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            readOnly: true,
            validator: validateForm,
            suffix: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: MyColors.blackMenu,
            ),
            onTap: () {
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
                builder: (_) => BottomSheetService(
                  controller: serviceTypeController,
                  isSelectedService: (Service? isSelectedService) {
                    setState(() {
                      serviceTypeController.text =
                          isSelectedService?.namaJenissvc ?? '';
                      serviceType = isSelectedService;
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Keluhan (Opsional)',
            style: TextStyle(
              fontSize: 12,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextFormField(
            controller: complaintController,
            hintText: "Keluhan (Opsional)",
            maxLines: 4,
            cursorColor: Colors.black,
            showCursor: true,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ButtonSubmitWidget(
              onPressed: vehicleTypeController.text != '' &&
                      locationMapsController.text != '' &&
                      scheduleController.text.isNotEmpty &&
                      serviceTypeController.text.isNotEmpty
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailBookingPage(
                            vehicleType: vehicleType,
                            serviceType: serviceType,
                            timePick: timePick,
                            timeWithExtension: timeWithExtension,
                            datePick: datePick,
                            keluhan: complaintController.text,
                            location: locationMapsController.text,
                            idLocation: idLocation,
                          ),
                        ),
                      );
                    }
                  : () {
                      showSnackBar(
                        'Lengkapi Form Berikut',
                        SnackBarType.warning,
                        WARNING_IC,
                        context,
                      );
                      debugPrint("No Null");
                    },
              title: "BOOKING SEKARANG",
              bgColor: vehicleTypeController.text != '' &&
                      locationMapsController.text != '' &&
                      scheduleController.text.isNotEmpty &&
                      serviceTypeController.text.isNotEmpty
                  ? MyColors.appPrimaryColor
                  : MyColors.greyButton,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: vehicleTypeController.text != '' &&
                      locationMapsController.text != '' &&
                      scheduleController.text.isNotEmpty &&
                      serviceTypeController.text.isNotEmpty
                  ? MyColors.appPrimaryColor
                  : MyColors.greyButton,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: MyColors.appPrimaryColor,
      ),
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Booking',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),

      // actions: [
      //
      // ],
    );
  }

  String? validateForm(String? value) {
    if (value!.isEmpty) {
      return "Field is Required";
    } else {
      return null;
    }
  }
}
