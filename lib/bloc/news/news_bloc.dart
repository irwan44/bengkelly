import 'package:bengkelly_apps/providers/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/rss_feed.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<RssFeed>? cachedData; // Cached data

  NewsBloc() : super(NewsLoading());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsFetch || event is NewsFetch) {
      yield* _mapNewsFetchToState();
    } else {
      yield* _mapNewsFetchToBengkellyState();
    }
  }

  Stream<NewsState> _mapNewsFetchToState() async* {
    try {
      if (cachedData != null) {
        yield NewsLoaded(dataRss: cachedData!);
      }

      final futures = [api.getNews(), api.getNewsFleet()];
      final results = await Future.wait(futures);

      final allRss = results.expand((data) => data).toList();

      if (!listEquals(cachedData, allRss)) {
        cachedData = allRss;
        yield NewsLoaded(dataRss: allRss);
      }
    } catch (error) {
      debugPrint(error.toString());
      yield NewsFailure(dataError: error.toString());
    }
  }

  Stream<NewsState> _mapNewsFetchToBengkellyState() async* {
    try {
      if (cachedData != null) {
        yield NewsLoadedBengkelly(dataRss: cachedData!);
      }

      final dataRss = await api.getNews();

      if (!listEquals(cachedData, dataRss)) {
        cachedData = dataRss;
        yield NewsLoadedBengkelly(dataRss: dataRss);
      }
    } catch (error) {
      debugPrint(error.toString());
      yield NewsFailure(dataError: error.toString());
    }
  }
}
