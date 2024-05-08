part of 'gcu_bloc.dart';


abstract class GCUEvent extends Equatable {
  const GCUEvent();

  @override
  List<Object> get props => [];
}

class GCUFetch extends GCUEvent {}
class GCURefresh extends GCUEvent {}