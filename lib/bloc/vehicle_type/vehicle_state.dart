part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final GetVehicle dataService;

  const VehicleLoaded({
    required this.dataService,
  });

  VehicleLoaded copyWith({GetVehicle? dataService}) {
    return VehicleLoaded(
      dataService: dataService ?? this.dataService,
    );
  }

  @override
  List<Object> get props => [dataService];

  @override
  String toString() => 'NewsLoaded { data: $dataService}';
}

class VehicleFailure extends VehicleState {
  final String dataError;

  const VehicleFailure({
    required this.dataError,
  });

  @override
  List<Object> get props => [dataError];

  @override
  String toString() => 'Failure { items: $dataError }';
}
