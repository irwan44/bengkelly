import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:bengkelly_apps/providers/common_data.dart';
import '../../../utils/constants.dart';
import '../component/detail_special_offer.dart';

class AllSpecialOfferPage extends StatefulWidget {
  final Map<String, dynamic>? dataProduct;

  const AllSpecialOfferPage({super.key, this.dataProduct});
  // const AllSpecialOfferPage({Key? key}) : super(key: key);

  @override
  State<AllSpecialOfferPage> createState() => _AllSpecialOfferPageState();
}

class _AllSpecialOfferPageState extends State<AllSpecialOfferPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

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
    return Column(
      children: [
        // _buildTabBar(),
        _buildBanner(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildGridView('Promo Sparepart'),
              _buildGridView('Katalog Sparepart'),
              _buildGridView('Produk Perawatan'),
              _buildGridView('Interior'),
              _buildGridView('Eksterior'),
              _buildGridView('Produk Perawatan'),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildTabBar() {
  //   return Container(
  //     height: 50,
  //     child: Card(
  //       elevation: 2,
  //       child: TabBar(
  //         isScrollable: true, // Untuk memungkinkan tab berada dalam satu baris
  //         controller: _tabController,
  //         tabs: [
  //           _buildTab('Promo Sparepart'),
  //           _buildTab('Katalog Sparepart'),
  //           _buildTab('Produk Perawatan'),
  //           _buildTab('Interior'),
  //           _buildTab('Eksterior'),
  //           _buildTab('Produk Perawatan'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildTab(String text) {
  //   return Card(
  //     elevation: 0, // Remove shadow from the card
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Text(text),
  //     ),
  //   );
  // }

  Widget _buildBanner() {
    return Container(
      height: 200, // Ganti dengan warna latar belakang yang sesuai
      child: Center(
        child:   Image.asset(
          BANNER, // Menggunakan gambar produk dari data
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _buildGridView(String category) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: dataProduct.length,
      itemBuilder: (context, index) {
        final productData = dataProduct[index];
        return GestureDetector(
          onTap: () {
            // Redirect to detail page with animation
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 250),
                reverseTransitionDuration: const Duration(milliseconds: 250),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: DetailSpecialOffer(product: productData),  // or any other detail page
                  );
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Gambar produk
                Image.asset(
                  productData['image'], // Menggunakan gambar produk dari data
                  fit: BoxFit.cover,
                ),
                // Label diskon
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: MyColors.greenSnackBar,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      productData['diskon'], // Menggunakan nama produk dari data
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                // Product name
                Positioned(
                  bottom: 90,
                  left: 5,
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      productData['name'], // Menggunakan nama produk dari data
                      maxLines: 1, // Batasi teks hanya ke satu baris
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                // Product price
                Positioned(
                  bottom: 70,
                  left: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min, // tambahkan ini
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productData['Harga'], // Menggunakan harga produk dari data
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Rp',
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black45,
                              ),
                            ),
                            TextSpan(
                              text: productData['harga_asli'],
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Sold quantity
                // Sold quantity
                Positioned(
                  bottom: 50,
                  left: 5,
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          STAR,
                        ),
                        // const SizedBox(width: 3),
                        Text(
                          '4.9',
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(width: 5), // Memberikan sedikit jarak antara ikon dan teks
                        Text(
                          productData['terjual'], // Menggunakan jumlah terjual produk dari data
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(width: 5),
                        // Memberikan sedikit jarak antara ikon dan teks
                        Text(
                          'terjual', // Menggunakan jumlah terjual produk dari data
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 5,
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          SAFETY,
                          width: 13,
                          height: 13,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Dilayani Bengkelly',
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
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
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Special Offer',
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
    );
  }
}
