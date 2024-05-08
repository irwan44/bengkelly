import 'package:bengkelly_apps/bloc/news/news_bloc.dart';
import 'package:bengkelly_apps/customers/news/component/trending_topic.dart';
import 'package:bengkelly_apps/customers/news/news_detail.dart';
import 'package:bengkelly_apps/widget/slider_news_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../main.dart';
import '../../model/rss_feed.dart';
import '../../utils/my_colors.dart';
import '../../widget/actions_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;

  final NewsBloc newsBloc = NewsBloc();

  List<SliderNewsWidget> sliderNews = [];

  @override
  void initState() {
    newsBloc.add(NewsFetch());
    // newsBloc.add(NewsFetch());
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SafeArea(
        child:
        RefreshIndicator(
          color: MyColors.appPrimaryColor,
          onRefresh: _onRefresh,
          child: _buildBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor:  MyColors.appPrimaryColor,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'News',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
      actions: const [
        ActionWidget(),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              _buildCardSlider(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Text(
                  'Trending Topic',
                  style: TextStyle(
                    color: MyColors.appPrimaryColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TrendingTopicPage(
                onPressed: (RssFeed? data) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsNews(data: data),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardSlider() {
    return BlocBuilder(
      bloc: newsBloc,
      builder: (context, state) {
        if (state is NewsFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is NewsLoaded) {
          List<RssFeed> rssFeed = state.dataRss
              ?.where((element) => element.category == "Ulasan")
              .toList() ??
              [];
          sliderNews = rssFeed
              .map((slider) => SliderNewsWidget(
            slider: slider,
          ))
              .toList();
          return Column(
            children: [
              CarouselSlider(
                items: sliderNews,
                options: CarouselOptions(
                    height: 280,
                    autoPlay: true,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    aspectRatio: 2.0,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rssFeed.map((slider) {
                    return Container(
                      width: 15,
                      height: 5.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 3.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        color: _current == rssFeed.indexOf(slider)
                            ? MyColors.appPrimaryColor
                            : const Color.fromRGBO(0, 0, 0, 0.2),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 280,
            height: 280,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    // newsBloc.add(NewsRefresh());
  }
}
