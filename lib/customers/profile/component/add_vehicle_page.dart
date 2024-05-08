import 'dart:convert';

import 'package:bengkelly_apps/customers/profile/component/setting_vehicle_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../../model/merk_type.dart';
import '../../../model/merk_vehicle.dart';
import '../../../providers/api.dart';
import '../../../providers/common_data.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/dropdown_widget.dart';
import '../../../widget/formfield_widget.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController policeNumberController = TextEditingController();

  // SearchableDropdownController merk = SearchableDropdownController();
  // TextEditingController brandController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.white,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Tambah Kendaraan',
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
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: _buildFormCard(),
    );
  }

  Widget _buildFormCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------ Nomor Polisi ------
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 16, bottom: 5),
          child: Text(
            'No. Polisi',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
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

        // ------ Merk ------
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Merk',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            // top: 16.0,
          ),
          child: CustomDropDown(
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

        // ------ Tipe ------
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Tipe',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            // top: 16.0,
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

        // ------ Kategori Kendaraan ------
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Kategori Kendaraan',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16.0,
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
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Transmisi Kendaraan',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16.0,
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

        // ----- Tahun ----
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Tahun',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16,
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

        // ---- Warna ----
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 12, bottom: 5),
          child: Text(
            'Warna',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // top: 16,
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
        _buildCreate(),
      ],
    );
  }

  Widget _buildCreate() {
    return Padding(
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingsVehiclePage()));
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
