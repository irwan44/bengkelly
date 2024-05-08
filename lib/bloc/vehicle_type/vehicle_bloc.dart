import 'package:bengkelly_apps/model/get_vehicle.dart';
import 'package:bengkelly_apps/providers/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleLoading());

  VehicleState get initialState => VehicleLoading();

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {
    if (event is VehicleFetch) {
      try {
        final dataService = await api.getVehicle();
        yield VehicleLoaded(dataService: dataService);
      } catch (error) {
        debugPrint(error.toString());
        yield VehicleFailure(dataError: error.toString());
      }
    }
    if (event is VehicleRefresh) {
      try {
        yield VehicleLoading();
        final dataService = await api.getVehicle();
        yield VehicleLoaded(dataService: dataService);
      } catch (error) {
        debugPrint(error.toString());
        yield VehicleFailure(dataError: error.toString());
      }
    }
  }
}