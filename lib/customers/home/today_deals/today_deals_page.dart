import 'package:bengkelly_apps/providers/common_data.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants.dart';
import '../component/detail_special_offer.dart';
import '../special_offer/all_special_offer.dart';

class AllTodayDealsPage extends StatefulWidget {
  // const AllTodayDealsPage({super.key});
  const AllTodayDealsPage({
    Key? key,
    required this.productData,
  }) : super(key: key);

  final Map<String, dynamic> productData;
  @override
  State<AllTodayDealsPage> createState() => _AllTodayDealsPageState();
}

class _AllTodayDealsPageState extends State<AllTodayDealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: RefreshIndicator(
          color: MyColors.appPrimaryColor,
          onRefresh: () async {},
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllSpecialOfferPage(),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        DUMMY_DEALS_IMAGE,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 10),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Deals 1',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
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
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: Row(
                    children: [
                      const Text(
                        '1.0 km',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF878787),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF878787)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.star,
                        color: Color(0xFFF2B90D),
                        size: 20,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        '4.8 reviews',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Color(0xFF878787),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
        'Today Deals',
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
