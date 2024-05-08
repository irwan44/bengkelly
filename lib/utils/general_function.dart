import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:shimmer/shimmer.dart';

enum SnackBarType { succes, warning, error }

void dismissTextFieldFocus() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void showSnackBar(
  String? title,
  SnackBarType type,
  String icon,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 80),
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Image.asset(
          icon,
          width: 28,
          height: 28,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            title ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
    closeIconColor: Colors.white,
    backgroundColor: type == SnackBarType.succes
        ? const Color(0xFF4AC000)
        : type == SnackBarType.warning
            ? const Color(0xFFEF9300)
            : type == SnackBarType.error
                ? const Color(0xFFE01A1A)
                : ThemeData().snackBarTheme.backgroundColor,
  ));
}

String formatMoney(val) {
  String money = "";
  if (val != null) {
    if (val is String) {
      money = NumberFormat.currency(
        decimalDigits: 0,
        symbol: "Rp. ",
        locale: "id",
      ).format(double.parse(val));
    } else {
      money = money = NumberFormat.currency(
        decimalDigits: 0,
        locale: "id",
        symbol: "Rp. ",
      ).format(val);
    }
  }
  return money;
}

//format tanggal tanpa waktu
String formatDateNoTime(DateTime? valueData) {
  return valueData != null
      ? DateFormat(
          'dd MMMM yyyy',
        ).format(valueData)
      : "-";
}

bool isNetworkImage(String? imageURL) {
  return imageURL!.contains("http://") || imageURL.contains("https://")
      ? true
      : false;
}

Color? statusHistoryColor(String? status) {
  switch (status) {
    case 'Diproses':
      return const Color(0xFFff7e00);
    case 'Invoice':
      return Colors.green;
    case 'Ditolak By System':
      return Colors.red;
    case 'Ditolak By Sistem':
      return Colors.red;
    case 'Dikerjakan':
      return MyColors.appPrimaryColor;
    case 'Selesai Dikerjakan':
      return MyColors.appPrimaryColor;
    case 'Lunas':
      return Colors.green;
    default:
      return const Color(0xFFff7e00);
  }
}

String? imageDetailHistory(String? status) {
  switch (status) {
    case 'Bengkelly Rest Area KM 379A':
      return REST_AREA_379;
    case 'Bengkelly Rest Area KM 228A':
      return REST_AREA_575;
    case 'Bengkelly Rest Area KM 389B':
      return REST_AREA_389;
    case 'Bengkelly Rest Area KM 575B':
      return REST_AREA_575;
    default:
      return REST_AREA_575;
  }
}

String? imageLocationBengkelly(String? status) {
  switch (status) {
    case 'Rest Area KM 379A':
      return REST_AREA_379;
    case 'Rest Area KM 228A':
      return REST_AREA_575;
    case 'Rest Area KM 389B':
      return REST_AREA_389;
    case 'Rest Area KM 319B':
      return REST_AREA_319;
    default:
      return REST_AREA_575;
  }
}

String getPlaceMarkAddress(Placemark placeMark) {
  // _placeMark : Street(jalan+nomor) + Sublocality(kelurahan) +  Locality(kecamatan)
  // + Subadministrative area(kabupaten/kota) + Administrative area(provinsi) + Country + Postal code
  String address =
      "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea}, ${placeMark.country}, ${placeMark.postalCode}";

  return address;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Widget buildShimmerListCard() {
  return GridView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.only(top: 10),
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 1.9,
      crossAxisCount: 1,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
      mainAxisExtent: 210,
    ),
    itemCount: 1,
    // Set a placeholder count for shimmer items
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 136,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: MyColors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 12,
                      width: 100,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildShimmerTrendingTopic() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 10,
    ),
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: 6,
      // Placeholder count for shimmer effect
      padding: const EdgeInsets.only(top: 10),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 10,
        mainAxisExtent: 250,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 160,
              color: Colors.white,
            ),
          ),
        );
      },
    ),
  );
}

Widget buildShimmerProfile(BuildContext context) {
  return Container(
    height: 140,
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Center(
                  child: _buildShimmerAvatar(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 35),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: _buildShimmerText(
                        height: 18,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 8,
                      right: 10,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: _buildShimmerText(
                        height: 14,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 8,
                      right: 10,
                    ),
                    child: _buildShimmerText(
                      height: 14,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            padding: const EdgeInsets.only(
              top: 25,
              right: 12,
            ),
            onPressed: () {}, // No action for edit button in shimmer
            icon: Icon(
              Icons.edit,
              size: 24,
              color: MyColors.appPrimaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildShimmerText({required double height, required double width}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      color: Colors.white,
    ),
  );
}

Widget _buildShimmerAvatar() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 70,
      width: 70,
      color: Colors.white,
    ),
  );
}

Widget buildShimmerListView() {
  return ListView.builder(
    itemCount: 1, // Placeholder count for shimmer effect
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          width: 330,
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 10),
                    child: Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 120,
                          height: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildShimmerListVehicle() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Container(
        width: 200,
        height: 18,
        color: Colors.white,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 14,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Container(
            width: 150,
            height: 14,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

Widget buildShimmerListService() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Container(
        width: 200,
        height: 18,
        color: Colors.white,
      ),
    ),
  );
}
