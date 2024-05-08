import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/news/news_bloc.dart';
import '../../../utils/constants.dart';
import '../../../model/rss_feed.dart';
import '../../../utils/general_function.dart';

class TrendingTopicPage extends StatefulWidget {
  final Function(RssFeed? data)? onPressed;

  const TrendingTopicPage({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  _TrendingTopicPageState createState() => _TrendingTopicPageState();
}

class _TrendingTopicPageState extends State<TrendingTopicPage>
    with AutomaticKeepAliveClientMixin<TrendingTopicPage> {
  final NewsBloc newsBloc = NewsBloc();
  List<RssFeed>? _dataRss;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    newsBloc.close();
    super.dispose();
  }

  Future<void> _fetchData() async {
    if (_dataRss == null) {
      newsBloc.add(NewsFetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // You need to call super.build.
    return BlocBuilder(
      bloc: newsBloc,
      builder: (context, state) {
        if (state is NewsFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is NewsLoaded) {
          _dataRss = state.dataRss;
          return _buildTrendingTopic(state.dataRss);
        }
        return buildShimmerTrendingTopic();
      },
    );
  }

  Widget _buildTrendingTopic(List<RssFeed>? dataRss) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: dataRss?.length,
        padding: const EdgeInsets.only(top: 10),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 10,
          mainAxisExtent: 250,
        ),
        itemBuilder: (context, index) {
          final rssFeed = dataRss?[index];
          return Card(
            child: GestureDetector(
              onTap: () => widget.onPressed!(rssFeed),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rssFeed?.imageUrl == null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      IC_NEWS_ITEM,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${rssFeed?.imageUrl}',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 13),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 3,
                        bottom: 3,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFff7e00),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: rssFeed?.category == "Ulasan"
                            ? const Text(
                          'Ulasan',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontSize: 12,
                          ),
                        )
                            : const Text(
                          'Tips',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 3, right: 10),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 3,
                      ),
                      child: Text(
                        '${rssFeed?.title}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
