import 'package:bengkelly_apps/providers/common_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import '../../../utils/constants.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/slider_widget.dart';
import '../detail_lokasi_bengkelly/detail_tenants.dart';

class DetailRestArea extends StatelessWidget {
  final Map<String, dynamic> data;
  int _current = 0;
  List<SliderImageWidget> imageSliders = [
    const SliderImageWidget(
      image: BANNDER1,
    ),
    const SliderImageWidget(
      image: PROMO1,
    ),
    const SliderImageWidget(
      image: DEALS1,
    )
  ];

  DetailRestArea({
    super.key,
    required this.data,
  });

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
          _buildSlider(data['sliderImages']),
          // _buildImage(context),
          const SizedBox(
            height: 10,

          ),
          _buildContent(),
          _buildDescription(context),
          _buildFacility(),
          _buildTenant(),
        ],
      ),
    );
  }

  Widget _buildSlider(List<String> sliderImages) {
    return CarouselSlider(
      items: sliderImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1, // Set ke 1 untuk mengisi lebar layar
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
        autoPlayCurve: Curves.linearToEaseOut,
        pauseAutoPlayOnTouch: true,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            '${imageLocationBengkelly(data['name'])}',
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data['name']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Nunito',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          // Text(
          //   'Category: ${data?.category}',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontFamily: 'Nunito',
          //     color: MyColors.grey,
          //   ),
          // ),
          // Text(
          //   'Date: ${formatDateNoTime(data?.date)}',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontFamily: 'Nunito',
          //     color: MyColors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFacility() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fasilitas',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Nunito',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyColors.blueOpacity, shape: BoxShape.circle),
                  height: 35,
                  width: 35,
                  child: Icon(
                    Icons.restaurant,
                    color: MyColors.appPrimaryColor,
                    size: 15,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: MyColors.blueOpacity, shape: BoxShape.circle),
                  height: 35,
                  width: 35,
                  child: Icon(
                    Icons.people_alt_outlined,
                    color: MyColors.appPrimaryColor,
                    size: 15,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: MyColors.blueOpacity, shape: BoxShape.circle),
                  height: 35,
                  width: 35,
                  child: Icon(
                    Icons.local_gas_station,
                    color: MyColors.appPrimaryColor,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          // Text(
          //   'Category: ${data?.category}',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontFamily: 'Nunito',
          //     color: MyColors.grey,
          //   ),
          // ),
          // Text(
          //   'Date: ${formatDateNoTime(data?.date)}',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontFamily: 'Nunito',
          //     color: MyColors.grey,
          //   ),
          // ),
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
              data['description'], // Use description data from rest area
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

  Widget _buildTenant() {
    // Filter tenant berdasarkan rest area yang dipilih
    List<Map<String, dynamic>> filteredTenants = restAreaTenants.where((tenant) => tenant['restAreaId'] == data['id']).toList();

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
            child: Text(
              'Tenants',
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
            itemCount: filteredTenants.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final tenant = filteredTenants[index];
              return SizedBox(
                width: 330,
                height: 140,
                child: InkWell(
                  onTap: () {
                    // Navigasi ke halaman detail tenant dengan mengirim data tenant yang dipilih
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailTenants(data: tenant),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: Image.asset(
                              tenant['image'],
                              height: 120,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Tambahkan jarak antara gambar dan teks
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: Text(
                                tenant['name'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                tenant['address'],
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  color: Color(0xFF77838F),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFF2B90D),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.white,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        '${data['name']}',
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
