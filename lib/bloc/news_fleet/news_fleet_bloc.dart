import 'package:bengkelly_apps/providers/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/rss_feed.dart';

part 'news_fleet_event.dart';

part 'news_fleet_state.dart';

class NewsFleetBloc extends Bloc<NewsFleetEvent, NewsFleetState> {
  NewsFleetBloc() : super(NewsFleetLoading());

  NewsFleetState get initialState => NewsFleetLoading();

  @override
  Stream<NewsFleetState> mapEventToState(NewsFleetEvent event) async* {
    final currentState = state;
    if (event is NewsFleetFetch) {
      try {
        if (currentState is NewsFleetLoading) {
          final dataRss = await api.getNewsFleet();
          yield NewsFleetLoaded(
            dataRss: dataRss,
          );
        }
        if (currentState is NewsFleetLoaded) {
          final dataRss = await api.getNewsFleet();
          yield NewsFleetLoaded(
            dataRss: dataRss,
          );
        }
      } catch (error) {
        debugPrint(error.toString());
        yield NewsFleetFailure(dataError: error.toString());
      }
    }

    if (event is NewsRefresh) {
      try {
        yield NewsFleetLoading();
        final dataRss = await api.getNewsFleet();
        yield NewsFleetLoaded(
          dataRss: dataRss,
        );
      } catch (error) {
        debugPrint(error.toString());
        yield NewsFleetFailure(dataError: error.toString());
      }
    }
  }
}
