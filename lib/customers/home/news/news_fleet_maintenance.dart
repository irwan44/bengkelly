import 'package:bengkelly_apps/customers/home/component/news_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/rss_feed.dart';
import '../../../providers/api.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../../news/news_detail.dart';

class NewsFleetMaintenance extends StatefulWidget {
  const NewsFleetMaintenance({super.key});

  @override
  State<NewsFleetMaintenance> createState() => _NewsFleetMaintenanceState();
}

class _NewsFleetMaintenanceState extends State<NewsFleetMaintenance> {
  final ScrollController _scrollController = ScrollController();
  final List<RssFeed> _posts = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        _loadPosts();
      }
    });
  }

  void _loadPosts() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      List<RssFeed> newPosts = await api.fetchPagingFleetNews(
        page: currentPage,
      );
      setState(() {
        currentPage++;
        _posts.addAll(newPosts);
        isLoading = false;
        hasMore = newPosts.length >= 10;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return isLoading && _posts.isEmpty
        ? buildShimmerListCard()
        : GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.9,
              crossAxisCount: 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              mainAxisExtent: 210,
            ),
            controller: _scrollController,
            itemCount: _posts.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show loading indicator at the bottom
              }
              RssFeed post = _posts[index];

              return NewsPage(
                data: post,
                onPressed: (RssFeed? data) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsNews(data: data),
                    ),
                  );
                },
              );
            },
          );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.transparent,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'All News Fleet',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.fromLTRB(15, 7, 0, 7),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      // actions: [
      //
      // ],
    );
  }
}
