part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsFetch extends NewsEvent {}
class NewsFetchBengekelly extends NewsEvent {}
// class NewsRefresh extends NewsEvent {}