part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final GetService dataService;

  const ServiceLoaded({
    required this.dataService,
  });

  ServiceLoaded copyWith({GetService? dataService}) {
    return ServiceLoaded(
      dataService: dataService ?? this.dataService,
    );
  }

  @override
  List<Object> get props => [dataService];

  @override
  String toString() => 'NewsLoaded { data: $dataService}';
}

class ServiceFailure extends ServiceState {
  final String dataError;

  const ServiceFailure({
    required this.dataError,
  });

  @override
  List<Object> get props => [dataError];

  @override
  String toString() => 'Failure { items: $dataError }';
}
