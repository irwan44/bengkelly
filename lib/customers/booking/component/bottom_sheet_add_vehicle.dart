import 'dart:convert';

import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:bengkelly_apps/widget/dropdown_widget.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../model/get_vehicle.dart';
import '../../../model/merk_type.dart';
import '../../../model/merk_vehicle.dart';
import '../../../providers/api.dart';
import '../../../providers/common_data.dart';
import '../../../utils/app_theme.dart';

class BottomSheetAddVehicle extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<ScaffoldMessengerState> scaffoldContext;
  Vehicle? vehicleType;

  BottomSheetAddVehicle({
    Key? key,
    required this.controller,
    required this.scaffoldContext,
    this.vehicleType,
  }) : super(key: key);

  @override
  State<BottomSheetAddVehicle> createState() => _BottomSheetAddVehicleState();
}

class _BottomSheetAddVehicleState extends State<BottomSheetAddVehicle> {
  TextEditingController policeNumberController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedUnit;
  String? _selectedMerk;
  String? _selectedTypeMerk;
  String? _selectedTransmission;
  MerkVehicle? merkVehicle;
  MerkType? merkType;
  bool isLoading = false;
  TypeVehicle? typeVehicle;

  @override
  void initState() {
    getMerk();
    super.initState();
  }

  Future<void> getMerk() async {
    final res = await api.getMerk();

    setState(() {
      merkVehicle = res;
    });
  }

  Future<void> getTypeByMerk(String value) async {
    final res = await api.getTypeMerk(value);

    setState(() {
      merkType = res;
    });
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
                  'Tambah Kendaraan',
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
            Form(
              key: _formKey,
              child: _buildFormCard(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 17,
              ),
              child: Center(
                child: ButtonSubmitWidget(
                  onPressed: () => _createVehicle(context),
                  title: "Simpan Kendaraan",
                  bgColor: MyColors.appPrimaryColor,
                  textColor: Colors.white,
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 60,
                  borderSide: MyColors.appPrimaryColor,
                  loading: isLoading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createVehicle(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint('valid');
      try {
        dismissTextFieldFocus();
        _showLoading();

        var res = await api.createVehicle(
          policeNumberController.text,
          int.tryParse(_selectedMerk!),
          int.tryParse(_selectedTypeMerk!),
          colorController.text,
          yearController.text,
          _selectedUnit,
          _selectedTransmission,
        );
        var result = json.decode(res);

        if (result['status'] == true) {
          Navigator.pop(context);
          showSnackBar(
            'Berhasil Tambah Kendaraan',
            SnackBarType.succes,
            SUCCESS_IC,
            context,
          );
        }
      } catch (error, stackTrace) {
        _dismissLoading();
        showSnackBar(
          '$error',
          SnackBarType.error,
          ERROR_IC,
          context,
        );

        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
      }
    }
  }

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }

  Widget _buildFormCard() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            top: 16.0,
          ),
          child: CustomTextFormField(
            controller: policeNumberController,
            textCapitalization: TextCapitalization.characters,
            hintText: "Nomor Polisi",
            showCursor: true,
            cursorColor: Colors.black,
            validator: validateNoPolice,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            top: 16.0,
          ),
          child:
          CustomDropDown(
            hintText: 'Merk',
            value: _selectedMerk,
            onChange: (value) {
              setState(() {
                _selectedTypeMerk = null;
                _selectedMerk = value.toString();
                getTypeByMerk(value.toString());
                debugPrint(_selectedMerk);
              });
            },
            item: merkVehicle?.data?.asMap().entries.map((entry) {
                  Merk item = entry.value;
                  return DropdownMenuItem(
                    value: '${item.id}', // Using a combination of id and index
                    child: Text(
                      "${item.nameMerk}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 16.0,
            ),
            child: DropdownSearch<TypeVehicle>(
              popupProps: const PopupProps<TypeVehicle>.menu(
                showSelectedItems: false,
                showSearchBox: true,
                // disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: merkType?.data ?? [],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  // labelText: "Menu mode",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primaryContainer,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primaryContainer,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primaryContainer,
                      width: 1,
                    ),
                  ),
                  hintText: "Tipe",
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _selectedTypeMerk = val?.id.toString();
                });
              },
              selectedItem: typeVehicle,
              itemAsString: (TypeVehicle? item) => item?.nameType ?? "",
            ),
            // CustomDropDown(
            //   hintText: 'Tipe',
            //   value: _selectedTypeMerk,
            //   onChange: (value) {
            //     setState(() {
            //       _selectedTypeMerk = value.toString();
            //       debugPrint(_selectedTypeMerk);
            //     });
            //   },
            //   item: merkType?.data?.asMap().entries.map((entry) {
            //         TypeVehicle item = entry.value;
            //         return DropdownMenuItem(
            //           value: '${item.id}', // Using a combination of id and index
            //           child: Text(
            //             "${item.nameType}",
            //             style: const TextStyle(color: Colors.black),
            //           ),
            //         );
            //       }).toList() ??
            //       [],
            // ),
            ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            right: 30.0,
            left: 30.0,
          ),
          child: CustomDropDown(
            value: _selectedUnit,
            hintText: 'Kategori Kendaraan',
            onChange: (value) {
              setState(() {
                _selectedUnit = value.toString();
                debugPrint(_selectedUnit);
              });
            },
            item: categoryVehicle.map((category) {
              return DropdownMenuItem(
                value: category['category_name'],
                child: Text(
                  category['category_name'],
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        // ------ Vehicle Transmission ------
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            right: 30.0,
            left: 30.0,
          ),
          child: CustomDropDown(
            value: _selectedTransmission,
            hintText: 'Transmisi Kendaraan',
            onChange: (value) {
              setState(() {
                _selectedTransmission = value.toString();
                debugPrint(_selectedTransmission);
              });
            },
            item: transmissionVehicle.map((category) {
              return DropdownMenuItem(
                value: category['transmission'],
                child: Text(
                  category['transmission'],
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 30,
            right: 30,
          ),
          child: CustomTextFormField(
            controller: yearController,
            hintText: "Tahun",
            showCursor: true,
            cursorColor: Colors.black,
            validator: validateYears,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 30,
            right: 30,
          ),
          child: CustomTextFormField(
            controller: colorController,
            hintText: "Warna",
            showCursor: true,
            textCapitalization: TextCapitalization.characters,
            cursorColor: Colors.black,
            validator: validateColor,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
          ),
        ),
      ],
    );
  }

  String? validateNoPolice(String? value) {
    if (value!.isEmpty) {
      return "Nomor HandPhone is Required";
    } else {
      return null;
    }
  }

  String? validateYears(String? value) {
    if (value!.isEmpty) {
      return "Tahun is Required";
    } else {
      return null;
    }
  }

  String? validateColor(String? value) {
    if (value!.isEmpty) {
      return "Warna is Required";
    } else {
      return null;
    }
  }
}
