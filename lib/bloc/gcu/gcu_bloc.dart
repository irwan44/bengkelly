import 'package:bengkelly_apps/model/get_general_checkup.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/api.dart';

part 'gcu_event.dart';
part 'gcu_state.dart';

class GCUBloc extends Bloc<GCUEvent, GCUState> {
  GCUBloc() : super(GCULoading());

  GCUState get initialState => GCULoading();

  @override
  Stream<GCUState> mapEventToState(GCUEvent event) async* {
    if (event is GCUFetch) {
      try {
        final gcu = await api.getGCU();
        yield GCULoaded(gcu: gcu);
      } catch (error) {
        debugPrint(error.toString());
        yield GCUFailure(dataError: error.toString());
      }
    }
    if (event is GCURefresh) {
      try {
        final gcu = await api.getGCU();
        yield GCULoaded(gcu: gcu);
      } catch (error) {
        debugPrint(error.toString());
        yield GCUFailure(dataError: error.toString());
      }
    }
  }
}