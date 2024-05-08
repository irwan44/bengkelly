part of 'gcu_bloc.dart';

abstract class GCUState extends Equatable {
  const GCUState();

  @override
  List<Object> get props => [];
}

class GCULoading extends GCUState {}

class GCULoaded extends GCUState {
  final GetGeneralCheckUp gcu;

  const GCULoaded({
    required this.gcu,
  });

  GCULoaded copyWith({GetGeneralCheckUp? gcu}) {
    return GCULoaded(
      gcu: gcu ?? this.gcu,
    );
  }

  @override
  List<Object> get props => [gcu];

  @override
  String toString() => 'GCULoaded { data: $gcu}';
}

class GCUFailure extends GCUState {
  final String dataError;

  const GCUFailure({
    required this.dataError,
  });

  @override
  List<Object> get props => [dataError];

  @override
  String toString() => 'Failure { items: $dataError }';
}
