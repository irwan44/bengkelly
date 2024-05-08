import 'dart:convert';

import 'package:bengkelly_apps/customers/profile/component/add_vehicle_page.dart';
import 'package:bengkelly_apps/model/get_vehicle.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/vehicle_type/vehicle_bloc.dart';
import '../../../utils/general_function.dart';
import '../../../widget/button_widget.dart';

class SettingsVehiclePage extends StatefulWidget {
  const SettingsVehiclePage({super.key});

  @override
  State<SettingsVehiclePage> createState() => _SettingsVehiclePageState();
}

class _SettingsVehiclePageState extends State<SettingsVehiclePage> {
  VehicleBloc vehicleBloc = VehicleBloc();
  int? idVehicle;
  String? vehicle;

  @override
  void initState() {
    vehicleBloc.add(VehicleFetch());
    getIdVehicle();
    super.initState();
  }

  @override
  void dispose() {
    vehicleBloc.close();
    super.dispose();
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
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: ButtonSubmitWidget(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddVehiclePage(),
              ),
            );
          },
          title: "Tambah Kendaran",
          bgColor: MyColors.appPrimaryColor,
          textColor: Colors.white,
          width: MediaQuery.of(context).size.width / 1.3,
          height: 60,
          iconData: Icons.add_circle,
          borderSide: MyColors.appPrimaryColor,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
       systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor:  Colors.white,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Kendaraan',
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
    return BlocBuilder(
      bloc: vehicleBloc,
      builder: (context, state) {
        if (state is VehicleFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is VehicleLoaded) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.dataService.data?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 13),
                child: ListTile(
                  trailing: Visibility(
                    visible: idVehicle == state.dataService.data?[index].id,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15, right: 16),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 21,
                      ),
                    ),
                  ),
                  tileColor: idVehicle == state.dataService.data?[index].id
                      ? MyColors.blueOpacity
                      : null,
                  onTap: () {
                    setState(() {
                      idVehicle = state.dataService.data?[index].id;
                      vehicle =
                          '${state.dataService.data?[index].merks?.namaMerk} - ${state.dataService.data?[index].tipes?[0].namaTipe}';
                      saveVehicle(idVehicle, state.dataService.data?[index]);
                    });
                  },
                  contentPadding: const EdgeInsets.all(10),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '${state.dataService.data?[index].merks?.namaMerk} - ${state.dataService.data?[index].tipes?[0].namaTipe}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.dataService.data?[index].noPolisi}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            color: MyColors.greySeeAll,
                          ),
                        ),
                        Text(
                          '${state.dataService.data?[index].warna ?? '-'} - Tahun ${state.dataService.data?[index].tahun ?? '-'}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            color: MyColors.greySeeAll,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        }
        return buildShimmerListVehicle();
      },
    );
  }

  Future<void> saveVehicle(int? idVehicle, Vehicle? value) async {
    await putId(VEHICLE_ID, idVehicle);
    await putMerk(VEHICLE, jsonEncode(value));
  }

  Future<void> getIdVehicle() async {
    var id = await getId(VEHICLE_ID);

    if (id != null) {
      setState(() {
        idVehicle = id;
      });
    }
  }
}
