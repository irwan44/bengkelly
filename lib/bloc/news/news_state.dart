part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoaded extends NewsState {
  final List<RssFeed>? dataRss;

  const NewsLoaded({this.dataRss});

  @override
  List<Object?> get props => [dataRss];
}

class NewsLoadedBengkelly extends NewsLoaded {
  const NewsLoadedBengkelly({List<RssFeed>? dataRss}) : super(dataRss: dataRss);
}

class NewsFailure extends NewsState {
  final String dataError;

  const NewsFailure({required this.dataError});

  @override
  List<Object?> get props => [dataError];
}