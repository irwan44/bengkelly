import 'package:bengkelly_apps/customers/news/news_detail.dart';
import 'package:bengkelly_apps/model/rss_feed.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/my_colors.dart';

class SliderNewsWidget extends StatelessWidget {
  final RssFeed? slider;

  const SliderNewsWidget({
    super.key,
    this.slider,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsNews(data: slider,)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              slider?.imageUrl != null
                  ? Image.network(
                      '${slider?.imageUrl}',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      IC_NEWS_SLIDE,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    '${slider?.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: MyColors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      formatDateNoTime(slider?.date),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: MyColors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
