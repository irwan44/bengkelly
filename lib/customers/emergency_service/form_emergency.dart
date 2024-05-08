import 'package:bengkelly_apps/customers/emergency_service/detail_emergency_service.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';

import '../../model/get_vehicle.dart';
import '../../providers/api.dart';
import '../../utils/my_colors.dart';
import '../../widget/formfield_widget.dart';
import '../booking/component/bottom_sheet_vehicle.dart';

class FormEmergency extends StatefulWidget {
  final int? idCabang;
  final String? lokasi;

  const FormEmergency({super.key, this.idCabang, this.lokasi});

  @override
  State<FormEmergency> createState() => _FormEmergencyState();
}

class _FormEmergencyState extends State<FormEmergency> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController complaintController = TextEditingController();
  int? idVehicle;

  // int? idLocation;
  Vehicle? vehicleType;

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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 80,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
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
      title: Text(
        'Emergency Service',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
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
            'Anda telah memilih lokasi bengkelly di : ',
            style: TextStyle(
              fontSize: 14,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${widget.lokasi}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Jenis Kendaraan',
            style: TextStyle(
              fontSize: 14,
              color: MyColors.blackMenu,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(
            height: 10,
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
            'Keluhan (Opsional)',
            style: TextStyle(
              fontSize: 14,
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailEmergencyService(
                      idCabang: widget.idCabang,
                      keluhan: complaintController.text,
                      vehicle: vehicleType,
                    ),
                  ),
                );
              },
              title: "Emergency Service",
              bgColor: Colors.red,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: Colors.red,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
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
