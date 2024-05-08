import 'package:bengkelly_apps/customers/home/special_offer/all_special_offer.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../providers/common_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/see_all_widget.dart';

class SpecialOfferPage extends StatelessWidget {
  // final Function()? onPressed;
  final Function(Map<String, dynamic>)? onPressed;

  const SpecialOfferPage({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SeeAllWidget(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllSpecialOfferPage(),
              ),
            );
          },
          title: 'Special Offer',
        ),
        _buildTimer(),
        _buildListCard(),
      ],
    );
  }

  Widget _buildListCard() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: SizedBox(
        height: 240,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: dataProduct.length, // Menggunakan panjang data produk
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildProduct(dataProduct[index]); // Mengirimkan data produk sesuai indeks
          },
        ),
      ),
    );
  }

  Widget _buildProduct(Map<String, dynamic> productData) {
    return SizedBox(
      width: 150,
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed!(productData); // Pass the productData when InkWell is tapped
          }
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
                height: 150,
                width: double.infinity,
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
                bottom: 60,
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
                bottom: 40,
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
                bottom: 20,
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
                bottom: 5,
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
      ),
    );
  }

  Widget _buildTimer() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 10,
          ),
          child: Text(
            'Berakhir dalam',
            style: TextStyle(
              color: Color(0xFF32353E),
              fontSize: 14,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            // padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.red,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Image.asset(
                    IC_TIMER,
                    height: 12,
                    width: 8,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const SlideCountdown(
                  duration: Duration(
                    days: 1,
                  ),
                  slideDirection: SlideDirection.up,
                  separator: ':',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontSize: 12,
                  ),
                )
                // const Padding(
                //   padding: EdgeInsets.only(right: 10),
                //   child: Text(
                //     '07:32:14',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily: 'Nunito',
                //       fontSize: 12,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
