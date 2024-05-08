part of 'news_fleet_bloc.dart';

abstract class NewsFleetEvent extends Equatable {
  const NewsFleetEvent();

  @override
  List<Object> get props => [];
}

class NewsFleetFetch extends NewsFleetEvent {}
class NewsRefresh extends NewsFleetEvent {}