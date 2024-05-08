import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/slider_widget.dart';
import 'package:bengkelly_apps/providers/common_data.dart';
import 'detail_menu.dart';

class DetailTenants extends StatelessWidget {
  final Map<String, dynamic>? data;

  DetailTenants({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSliders(),
          const SizedBox(height: 10),
          _buildContent(),
          _buildDescription(context),
          _buildMenu(),
        ],
      ),
    );
  }

  Widget _buildSliders() {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity, // Menyesuaikan lebar
          child: data?['image'] != null
              ? Image.asset(
            data?['image']!,
            fit: BoxFit.cover, // Mengisi kontainer dengan gambar tanpa terdistorsi
          )
              : Image.asset(
            'assets/placeholder.png', // Gambar placeholder jika data gambar tidak tersedia
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _buildMenu() {
    List<Map<String, dynamic>>? menu = data?['menu'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
            child: Text(
              'Menu Makanan dan Minuman',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Nunito',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            itemCount: menu?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var menuItem = menu![index];
              return SizedBox(
                width: 330,
                height: 140,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                      ),
                      builder: (_) => DetailMenu(data: menuItem),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                menuItem['image']!,
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 18),
                              child: Text(
                                menuItem['name']!,
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    menuItem['deskripsi']!,
                                    maxLines: 3,
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 12,
                                      color: Color(0xFF77838F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 18),
                              child: Text(
                                formatMoney(menuItem['harga']!),
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data?['name']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Nunito',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Deskripsi',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Nunito',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: ReadMoreText(
              '${data?['description']}', // Use description data from tenant
              trimLines: 7,
              colorClickableText: MyColors.appPrimaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Baca selengkapnya',
              trimExpandedText: '',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
              moreStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
              ),
              lessStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        data?['name']!,
        style:  TextStyle(
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
    );
  }
}
