import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/widget/slider_widget.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/button_widget.dart';
import '../../booking/booking_page.dart';

class DetailSpecialOffer extends StatelessWidget {
  final Map<String, dynamic> product;

  const DetailSpecialOffer({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: ButtonSubmitWidget(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingPage(),
                ),
              );
            },
            title: "Booking",
            bgColor: MyColors.appPrimaryColor,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width / 1.3,
            height: 60,
            borderSide: MyColors.appPrimaryColor,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              floating: true,
              automaticallyImplyLeading: false,
              expandedHeight: 350,
              leading: Container(
                margin: const EdgeInsets.fromLTRB(15, 7, 0, 7),
                decoration: BoxDecoration(
                  color: Colors.white,
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
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      _buildImageSlider(),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildContent(),
                    _buildDescription(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 450, // Adjust the height as needed
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(product['image']), // Load the product image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Nunito',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product['Harga'],
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito',
              color: MyColors.appPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [

              Text(
                formatMoney(product['harga_asli']),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFF5DCB6A),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  product['diskon'],
                  style: TextStyle(
                    color: Colors.white,
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
    );
  }
  String formatMoney(dynamic val) {
    String money = "";
    if (val != null) {
      try {
        String cleanVal = val.toString().replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', '');
        money = NumberFormat.currency(
          decimalDigits: 0,
          symbol: "Rp. ",
          locale: "id",
        ).format(double.parse(cleanVal));
      } catch (e) {
        money = "Rp0"; // Jika terjadi kesalahan, atur harga menjadi Rp0
      }
    } else {
      money = "Rp0"; // Jika val null, atur harga menjadi Rp0
    }
    return money;
  }


  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Nunito',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ReadMoreText(
            product['description'],
            trimLines: 7,
            colorClickableText: MyColors.appPrimaryColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Lihat lainnya',
            trimExpandedText: '',
            style:  TextStyle(
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
        ],
      ),
    );
  }
}
