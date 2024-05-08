import 'package:bengkelly_apps/model/get_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/api.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceLoading());

  ServiceState get initialState => ServiceLoading();

  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is ServiceFetch) {
      try {
        final dataService = await api.getService();
        yield ServiceLoaded(dataService: dataService);
      } catch (error) {
        debugPrint(error.toString());
        yield ServiceFailure(dataError: error.toString());
      }
    }
    if (event is ServiceRefresh) {
      try {
        yield ServiceLoading();
        final dataService = await api.getService();
        yield ServiceLoaded(dataService: dataService);
      } catch (error) {
        debugPrint(error.toString());
        yield ServiceFailure(dataError: error.toString());
      }
    }
  }
}
