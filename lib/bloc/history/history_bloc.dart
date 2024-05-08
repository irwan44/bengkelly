import 'package:bengkelly_apps/model/get_history.dart';
import 'package:bengkelly_apps/providers/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryLoading());

  HistoryState get initialState => HistoryLoading();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is HistoryFetch) {
      try {
        final dataHistory = await api.getHistory();
        yield HistoryLoaded(dataHistory: dataHistory);
      } catch (error) {
        debugPrint(error.toString());
        yield HistoryFailure(dataError: error.toString());
      }
    }
    if (event is HistoryRefresh) {
      try {
        yield HistoryLoading();
        final dataHistory = await api.getHistory();
        yield HistoryLoaded(dataHistory: dataHistory);
      } catch (error) {
        debugPrint(error.toString());
        yield HistoryFailure(dataError: error.toString());
      }
    }
  }
}
