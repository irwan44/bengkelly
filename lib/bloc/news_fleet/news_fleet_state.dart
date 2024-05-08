part of 'news_fleet_bloc.dart';

abstract class NewsFleetState extends Equatable {
  const NewsFleetState();

  @override
  List<Object> get props => [];
}

class NewsFleetLoading extends NewsFleetState {}

class NewsFleetLoaded extends NewsFleetState {
  final List<RssFeed>? dataRss;

  const NewsFleetLoaded({
    this.dataRss,
  });

  NewsFleetLoaded copyWith({
    List<RssFeed>? dataRss,
  }) {
    return NewsFleetLoaded(
      dataRss: dataRss ?? this.dataRss,
    );
  }

  @override
  List<Object> get props => [dataRss ?? []];

  @override
  String toString() => 'NewsLoaded { data: ${dataRss?.length} }';
}


class NewsFleetFailure extends NewsFleetState {
  final String dataError;

  const NewsFleetFailure({
    required this.dataError,
  });

  @override
  List<Object> get props => [dataError];

  @override
  String toString() => 'Failure { items: $dataError }';
}
