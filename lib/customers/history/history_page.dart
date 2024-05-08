import 'package:bengkelly_apps/customers/history/tabPageHistory.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/actions_widget.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: Column(
            children: [
               Expanded(
                child: TabBarView(
                  children: [
                    _buildBody(),
                    _buildBody(),
                  ],
                ),
              ),
            ],
          ),
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
        'History',
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
        const SizedBox(height: 20),
        _buildSearch(),
        const Expanded(
          child: TabPageHistory(),
        ),
      ],
    );
  }
  Widget _buildTabBar() {
    return Material(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55,
              color: Colors.transparent,
              child: TabBar(
                isScrollable: false,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                unselectedLabelColor: const Color(0xFF8391A1),
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal, fontFamily: 'Nunito'),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyColors.appPrimaryColor,
                ),
                tabs: [
                  Tab(
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: MyColors.blueOpacity, width: 1),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Booking",
                          style: TextStyle(fontSize: 12, fontFamily: 'Nunito'),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: MyColors.blueOpacity, width: 1),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Emergency",
                          style: TextStyle(fontSize: 12, fontFamily: 'Nunito'),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 16),
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: theme.colorScheme.primaryContainer,
            width: 1,
          ),
        ),
        onChange: (String str) {},
        prefix: const Icon(
          Icons.search,
          size: 26,
          color: Color(0xFF4E4E4E),
        ),
        showCursor: true,
        cursorColor: const Color(0xFF4E4E4E),
        contentPadding: const EdgeInsets.only(top: 10),
        controller: _searchController,
        hintText: "Cari Transaksi",
        hintStyle: const TextStyle(
          color: Color(0xFF4E4E4E),
          fontSize: 14,
        ),
        textInputType: TextInputType.text,
      ),
    );
  }
}
