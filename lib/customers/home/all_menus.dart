import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/master_data.dart';
import 'menus.dart';

class AllMenus extends StatefulWidget {
  const AllMenus({super.key});

  @override
  State<AllMenus> createState() => _AllMenusState();
}

class _AllMenusState extends State<AllMenus> {
  List<MasterData> _masterDataList = [];
  UserMenus userCategoryMenus = UserMenus();

  void onMenuTap(Function onMenuTap) {
    onMenuTap();
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
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
        'All Menus',
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

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildGridMenus(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildGridMenus() {
    _buildMenu(context);
    return GridMenuWidget(
      listMenu: _masterDataList,
      onMenuTap: onMenuTap,
    );
  }

  _buildMenu(BuildContext context) {
    _masterDataList = [];
    _masterDataList = userCategoryMenus.buildAllMenu(context);
  }
}
