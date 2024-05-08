import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
  import '../../../utils/general_function.dart';

class DetailMenu extends StatelessWidget {
  final Map<String, dynamic>? data;

  const DetailMenu({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(context),
              _buildContent(),
              _buildDeskripsi(),
              _buildPrice()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 18),
      child: Text(
        formatMoney(data?['harga']),
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            '${data?['image']}',
            height: 150,
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
            '${data?['name']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Nunito',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDeskripsi() {
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
            '${data?['deskripsi']}',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
