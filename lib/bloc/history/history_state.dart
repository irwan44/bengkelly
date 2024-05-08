part of 'history_bloc.dart';

abstract class HistoryState extends Equatable{
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final GetHistory dataHistory;

  const HistoryLoaded({
    required this.dataHistory,
  });

  HistoryLoaded copyWith({GetHistory? dataHistory}) {
    return HistoryLoaded(
      dataHistory: dataHistory ?? this.dataHistory,
    );
  }

  @override
  List<Object> get props => [dataHistory];

  @override
  String toString() => 'NewsLoaded { data: $dataHistory}';
}

class HistoryFailure extends HistoryState {
  final String dataError;

  const HistoryFailure({
    required this.dataError,
  });

  @override
  List<Object> get props => [dataError];

  @override
  String toString() => 'Failure { items: $dataError }';
}
