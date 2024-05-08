import 'package:bengkelly_apps/bloc/vehicle_type/vehicle_bloc.dart';
import 'package:bengkelly_apps/customers/booking/component/bottom_sheet_add_vehicle.dart';
import 'package:bengkelly_apps/model/get_vehicle.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/shared_prefs.dart';
import '../../../widget/button_widget.dart';

class BottomSheetVehicleType extends StatefulWidget {
  final TextEditingController controller;
  final Function(Vehicle? selectedVehicle) isSelectedVehicle;
  final Vehicle? vehicleType;
  int? idVehicle;
   BottomSheetVehicleType({
    Key? key,
    required this.controller,
    required this.isSelectedVehicle,
    this.vehicleType, this.idVehicle,
  }) : super(key: key);

  @override
  State<BottomSheetVehicleType> createState() => _BottomSheetVehicleTypeState();
}

class _BottomSheetVehicleTypeState extends State<BottomSheetVehicleType> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  VehicleBloc vehicleBloc = VehicleBloc();

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Scaffold(
        key: scaffoldMessengerKey,
        body: SingleChildScrollView(
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
                    'Pilih Kendaraan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
              BlocBuilder(
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
                              visible: widget.idVehicle ==
                                  state.dataService.data?[index].id,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, right: 16),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 21,
                                ),
                              ),
                            ),
                            tileColor: widget.idVehicle ==
                                    state.dataService.data?[index].id
                                ? MyColors.blueOpacity
                                : null,
                            onTap: () {
                              setState(() {
                                // _updateListTile(index);
                                widget.idVehicle = state.dataService.data?[index].id;
                                widget.isSelectedVehicle(
                                    state.dataService.data?[index]);
                                Navigator.pop(context);
                              });
                              // Navigator.pop(context);
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
              ),
              const SizedBox(
                height: 7,
              ),
            ],
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
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                builder: (_) => BottomSheetAddVehicle(
                  controller: widget.controller,
                  vehicleType: widget.vehicleType,
                  scaffoldContext: scaffoldMessengerKey,
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
      ),
    );
  }

  Future<void> getIdVehicle() async {
    var id = await getId(VEHICLE_ID);
    if (id != null) {
      setState(() {
        widget.idVehicle = id;
      });
    }
  }
}
