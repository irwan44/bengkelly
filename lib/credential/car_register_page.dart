import 'dart:convert';

import 'package:bengkelly_apps/credential/login%20page.dart';
import 'package:bengkelly_apps/model/merk_type.dart';
import 'package:bengkelly_apps/model/merk_vehicle.dart';
import 'package:bengkelly_apps/model/register_model.dart';
import 'package:bengkelly_apps/providers/api.dart';
import 'package:bengkelly_apps/providers/auth.dart';
import 'package:bengkelly_apps/providers/common_data.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:bengkelly_apps/widget/dropdown_widget.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_theme.dart';
import '../utils/constants.dart';

class CarRegisterPage extends StatefulWidget {
  final RegisterModel registerModel;

  const CarRegisterPage({
    Key? key,
    required this.registerModel,
  }) : super(key: key);

  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController policeNumberController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // SearchableDropdownController tipe = SearchableDropdownController();
  String? _selectedUnit;
  String? _selectedTransmission;
  String? _selectedMerk;
  String? _selectedTypeMerk;
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
    return  Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
          systemNavigationBarColor:  Colors.white,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
      ),
        body: Form(
          key: _formKey,
          child: _buildBody(),
        ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Halo! Daftar untuk\nmemulai",
                  style: TextStyle(
                    color: MyColors.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            _buildFormCard(),
            const SizedBox(height: 25),
            Center(
              child: ButtonSubmitWidget(
                onPressed: () => validateRegister(context),
                title: "Register",
                bgColor: MyColors.appPrimaryColor,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                borderSide: MyColors.appPrimaryColor,
                loading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateRegister(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint('valid');
      try {
        dismissTextFieldFocus();
        _showLoading();

        var res = await auth.register(
          widget.registerModel,
          policeNumberController.text,
          phoneNumberController.text,
          _selectedMerk!,
          _selectedTypeMerk!,
          _selectedUnit!,
          _selectedTransmission!,
          yearController.text,
          colorController.text,
        );

        var result = json.decode(res);
        if (result['status'] == true) {
          showSnackBar(
            'Berhasil Registrasi',
            SnackBarType.succes,
            SUCCESS_IC,
            context,
          );

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
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

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.fromLTRB(30, 36, 0, 0),
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
    );
  }

  Widget _buildFormCard() {
    return Column(
      children: [
        const SizedBox(height: 51),

        // ------ Number Polices ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
        const SizedBox(height: 15),

        // ------ Number HandPhone ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextFormField(
            controller: phoneNumberController,
            textCapitalization: TextCapitalization.characters,
            hintText: "Nomor Handphone",
            showCursor: true,
            cursorColor: Colors.black,
            validator: validateNoPolice,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 15),
        // ------ Merk ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              // SearchableDropdown.future(
              //   hintText: const Text(
              //     "Merk",
              //     style: TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              //   ),
              //   trailingIcon: const Icon(
              //     Icons.keyboard_arrow_down_outlined,
              //     size: 30,
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
              //   controller: merk,
              //   futureRequest: () async {
              //     // final paginatedList = getMerk();
              //     return merkVehicle?.data
              //         ?.map(
              //           (e) => SearchableDropdownMenuItem(
              //         value: e.id,
              //         label: e.nameMerk ?? '',
              //         child: Text(e.nameMerk ?? ''),
              //       ),
              //     )
              //         .toList();
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedTypeMerk = null;
              //       _selectedMerk = value.toString();
              //       getTypeByMerk(value.toString());
              //       // idLocation = value.id;
              //
              //       debugPrint(_selectedMerk);
              //     });
              //   },
              // ),
              CustomDropDown(
            hintText: 'Merk',
            value: _selectedMerk,
            onChange: (value) {
              setState(() {
                // tipe.clear();
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
        const SizedBox(height: 15),

        // // ------ Merk Type ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
          //   onChange: (value){
          //     setState(() {
          //       _selectedTypeMerk = value.toString();
          //       debugPrint(_selectedTypeMerk);
          //     });
          //   },
          //   item: merkType?.data?.asMap().entries.map((entry) {
          //     TypeVehicle item = entry.value;
          //     return DropdownMenuItem(
          //       value:
          //       '${item.id}', // Using a combination of id and index
          //       child: Text(
          //         "${item.nameType}",
          //         style: const TextStyle(color: Colors.black),
          //       ),
          //     );
          //   }).toList() ??
          //       [],
          // ),
        ),
        const SizedBox(height: 15),
        // ------ Vehicle Category ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
        const SizedBox(height: 15),

        // ------ Vehicle Transmission ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
        const SizedBox(height: 15),

        // ------ Year ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
        const SizedBox(height: 15),

        // ------ Color ------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextFormField(
            controller: colorController,
            textCapitalization: TextCapitalization.characters,
            hintText: "Warna",
            showCursor: true,
            cursorColor: Colors.black,
            validator: validateColor,
            hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 15),
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

  String? validateNoPhone(String? value) {
    if (value!.isEmpty) {
      return "Nomor HandPhone is Required";
    } else if (value.length >= 12) {
      return 'Nomor Phone Not Enough';
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

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }
}
