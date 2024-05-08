import 'package:bengkelly_apps/model/rss_feed.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/widget/see_all_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/my_colors.dart';

class NewsPage extends StatelessWidget {
  final Function(RssFeed? data)? onPressed;
  final Function()? seeAll;
  final RssFeed? data;
  const NewsPage({
    Key? key,
    this.seeAll,
    this.onPressed, this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildListCard();
  }

  Widget _buildListCard() {
    return GestureDetector(
      onTap: () => onPressed!(data),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: data?.imageUrl != null
                      ? Image.network(
                    '${data?.imageUrl}',
                    height: 136,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    DUMMY_DEALS_IMAGE,
                    height: 136,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data?.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1D1D21),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 2),
                child: Row(
                  children: [
                    // const Text(
                    //   '1.0 km',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Color(0xFF878787),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 8,
                    // ),
                    // Container(
                    //   height: 4,
                    //   width: 4,
                    //   decoration: const BoxDecoration(
                    //       shape: BoxShape.circle, color: Color(0xFF878787)),
                    // ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.calendar_month,
                      color: MyColors.grey,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      formatDateNoTime(data?.date),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: MyColors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return GridView.builder(
    //   shrinkWrap: true,
    //   padding: const EdgeInsets.only(top: 10),
    //   physics: const NeverScrollableScrollPhysics(),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     childAspectRatio: 1.9,
    //     crossAxisCount: 1,
    //     crossAxisSpacing: 1,
    //     mainAxisSpacing: 1,
    //     mainAxisExtent: 210,
    //   ),
    //   itemCount: data?.length,
    //   itemBuilder: (context, index) {
    //     final dataRss = data?[index];
    //     debugPrint(dataRss?.imageUrl);
    //     return GestureDetector(
    //       onTap: () => onPressed!(dataRss),
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 10, right: 10),
    //         child: Card(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(left: 10, right: 10),
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(12),
    //                   child: dataRss?.imageUrl != null
    //                       ? Image.network(
    //                           '${dataRss?.imageUrl}',
    //                           height: 136,
    //                           width: double.infinity,
    //                           fit: BoxFit.cover,
    //                         )
    //                       : Image.asset(
    //                           DUMMY_DEALS_IMAGE,
    //                           height: 136,
    //                           width: double.infinity,
    //                           fit: BoxFit.cover,
    //                         ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(
    //                   top: 12,
    //                   left: 10,
    //                   right: 10,
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                       child: Text(
    //                         dataRss?.title ?? '',
    //                         overflow: TextOverflow.ellipsis,
    //                         style: const TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 14,
    //                           color: Color(0xFF1D1D21),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 5, left: 2),
    //                 child: Row(
    //                   children: [
    //                     // const Text(
    //                     //   '1.0 km',
    //                     //   style: TextStyle(
    //                     //     fontSize: 12,
    //                     //     color: Color(0xFF878787),
    //                     //   ),
    //                     // ),
    //                     // const SizedBox(
    //                     //   width: 8,
    //                     // ),
    //                     // Container(
    //                     //   height: 4,
    //                     //   width: 4,
    //                     //   decoration: const BoxDecoration(
    //                     //       shape: BoxShape.circle, color: Color(0xFF878787)),
    //                     // ),
    //                     const SizedBox(
    //                       width: 8,
    //                     ),
    //                     Icon(
    //                       Icons.calendar_month,
    //                       color: MyColors.grey,
    //                       size: 20,
    //                     ),
    //                     const SizedBox(
    //                       width: 6,
    //                     ),
    //                     Text(
    //                       formatDateNoTime(dataRss?.date),
    //                       style: TextStyle(
    //                         fontFamily: 'Nunito',
    //                         fontSize: 12,
    //                         color: MyColors.grey,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
