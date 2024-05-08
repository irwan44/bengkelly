import 'package:flutter/material.dart';
import 'package:bengkelly_apps/widget/see_all_widget.dart';
import '../../../providers/common_data.dart';
import '../special_offer/all_special_offer.dart';
import 'detail_special_offer.dart'; // Import halaman detail

class TodayDealsPage extends StatelessWidget {
  final List<Map<String, dynamic>> dataProduct; // Add dataProduct parameter
  final Function(Map<String, dynamic>)? onPressed; // Change the type of onPressed function

  const TodayDealsPage({
    Key? key,
    required this.dataProduct, // Initialize dataProduct in the constructor
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert dataProduct to List<Deal>
    List<Deal> dealsData = dataProduct.take(6).map((product) {
      return Deal(
        name: product['name'],
        image: product['image'],
        price: product['Harga'],
        originalPrice: product['harga_asli'],
        discount: product['diskon'],
      );
    }).toList();

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
          title: 'Today Deals',
        ),
        _buildListCard(dealsData), // Pass dealsData to _buildListCard
      ],
    );
  }

  Widget _buildListCard(List<Deal> dealsData) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:0.7,
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: dealsData.length, // Use dealsData length for the item count
        itemBuilder: (context, index) {
          final deal = dealsData[index];
          return GestureDetector(
            onTap: () {
              // Call onPressed callback and pass the selected product data
              onPressed?.call(dataProduct[index]);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            deal.image,
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${deal.discount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1D1D21),
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${deal.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      ), Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Rp ${deal.originalPrice}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black45,
                                fontSize: 10
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

class Deal {
  final String name;
  final String image;
  final String price;
  final String originalPrice;
  final String discount;

  Deal({
    required this.name,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.discount,
  });
}
