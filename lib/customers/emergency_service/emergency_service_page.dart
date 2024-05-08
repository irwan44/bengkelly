import 'dart:async';
import 'dart:math';
import 'package:bengkelly_apps/customers/emergency_service/form_emergency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import '../../model/get_lokasi.dart';
import '../../model/nearby_places.dart';
import '../../providers/api.dart';
import '../../utils/constants.dart';
import '../../utils/general_function.dart';
import '../../utils/my_colors.dart';
import '../../widget/button_widget.dart';

class EmergencyServicePage extends StatefulWidget {
  const EmergencyServicePage({super.key});

  @override
  State<EmergencyServicePage> createState() => _EmergencyServicePageState();
}

class _EmergencyServicePageState extends State<EmergencyServicePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // int radius = 50000;
  static LatLng? currentLocation;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int markerIdCounter = 1;
  MarkerId? selectedId;
  Marker? marker, marker1;
  String placemarkAddress = "";
  GetLokasi getLokasi = GetLokasi();
  GetNearbyPlaces getNearbyPlaces = GetNearbyPlaces();
  LatLng? lastMapPosition = currentLocation;
  double? lat, lng;
  int? idCabang;
  double totalDistance = 0.0;

  @override
  void initState() {
    _lokasiSekarang();
    _getLokasi();
    // setSourceAndDestinationIcons();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _lokasiSekarang() async {
    debugPrint('lokasiSekarang');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await _getLocation(position.latitude, position.longitude);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      // _getNearbyPlaces(currentLocation);
      // _getLokasi();
      _addMarker(
        currentLocation?.latitude,
        currentLocation?.longitude,
      );
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation!, zoom: 15)));
  }

  _getLocation(latitude, longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null) {
      setState(() {
        placemarkAddress = getPlaceMarkAddress(placemarks.first);
      });
    }
  }

  _onCameraMove(CameraPosition position) async {
    debugPrint('_onCameraMove');
    setState(() {
      lastMapPosition = position.target;
      lat = position.target.latitude;
      lng = position.target.longitude;
    });
  }

  _onCameraIdle() async {
    _addMarker(
      currentLocation?.latitude,
      currentLocation?.longitude,
    );
  }

  // void setSourceAndDestinationIcons() async {
  //   markerIcon = await getBytesFromAsset(LOCATION_MARK, 100);
  // }

  void _remove(MarkerId? markerId) {
    setState(() {
      if (markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });
  }

  Future<void> _addMarker(tmpLat, tmpLng) async {
    _remove(selectedId);
    final int markerCount = markers.length;
    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$markerIdCounter';
    // final String markerIdVal1 = 'marker_id_${markerIdCounter}_1';
    markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);
    // MarkerId markerId1 = const MarkerId('');
    //
    // final Uint8List markerIcon = await getBytesFromAsset(DROP_PIN, 100);

    marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(tmpLat, tmpLng),
    );
    // for(int i = 0; i < getLokasi.data!.length; i++){
    //   markerId1 = MarkerId('marker_id_1_${getLokasi.data?[i].geometry?.location?.id}');
    //   marker1 = Marker(
    //     markerId: markerId1,
    //     icon: BitmapDescriptor.fromBytes(markerIcon),
    //     position: LatLng(
    //       double.parse(getLokasi.data?[i].geometry?.location?.lat ?? '0.0'),
    //       double.parse(getLokasi.data?[i].geometry?.location?.lng ?? '0.0'),
    //     ),
    //   );
    //   debugPrint(getLokasi.data?[i].name);
    // }

    setState(() {
      markers[markerId] = marker!;
      // markers[markerId1] = marker1!;
      selectedId = markerId;
    });
    // _markers.add(
    //   Marker(
    //     markerId: const MarkerId('marker_id_1'),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //     position: LatLng(tmpLat, tmpLng),
    //   ),
    // );
  }

  Future<void> _getLokasi() async {
    var res = await api.getLokasi();
    if (res != null) {
      setState(() {
        getLokasi = res;
      });
    }
  }

  double calculateTime(double distance, double speed) {
    return distance / speed; // Time = Distance / Speed
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
      // Handle the case where any of the parameters are null
      return 0.0; // Return a default value, indicating invalid distance
    }

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentLocation == null
              ? Expanded(
                  child: Center(
                    child: Text(
                      'loading map..',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                )
              : _currentLocation(),
        ],
      ),
      bottomSheet: SolidBottomSheet(
        canUserSwipe: true,
        headerBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: 50,
            child: const Center(
              child: Text('Swipe me!'),
            ),
          ),
        ),
        showOnAppear: true,
        maxHeight: 300,
        smoothness: Smoothness.high,
        body: getLokasi.data != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    if (getLokasi.data != null)
                      for (int i = 0; i < getLokasi.data!.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: ListTile(
                            tileColor: idCabang ==
                                    getLokasi.data?[i].geometry?.location?.id
                                ? MyColors.blueOpacity
                                : null,
                            onTap: () {
                              setState(() {
                                idCabang =
                                    getLokasi.data?[i].geometry?.location?.id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormEmergency(
                                      idCabang: idCabang,
                                      lokasi: getLokasi.data?[i].name,
                                    ),
                                  ),
                                );
                              });
                            },
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Estimated Time
                                Text(
                                  '${calculateTime(calculateDistance(
                                        currentLocation?.latitude,
                                        currentLocation?.longitude,
                                        double.parse(getLokasi.data?[i].geometry
                                                ?.location?.lat ??
                                            '0.0'),
                                        double.parse(getLokasi.data?[i].geometry
                                                ?.location?.lng ??
                                            '0.0'),
                                      ), 60).floorToDouble().toInt()} - ${calculateTime(calculateDistance(
                                        currentLocation?.latitude,
                                        currentLocation?.longitude,
                                        double.parse(getLokasi.data?[i].geometry
                                                ?.location?.lat ??
                                            '0.0'),
                                        double.parse(getLokasi.data?[i].geometry
                                                ?.location?.lng ??
                                            '0.0'),
                                      ), 60).floorToDouble().toInt() + 1} Jam',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    fontSize: 12,
                                  ),
                                ),

                                // Distance
                                Text(
                                  '${calculateDistance(
                                    currentLocation?.latitude,
                                    currentLocation?.longitude,
                                    double.parse(getLokasi
                                            .data?[i].geometry?.location?.lat ??
                                        '0.0'),
                                    double.parse(getLokasi
                                            .data?[i].geometry?.location?.lng ??
                                        '0.0'),
                                  ).floorToDouble().toInt()} KM',
                                  style: TextStyle(
                                    color: MyColors.grey,
                                    fontFamily: 'Nunito',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, right: 16),
                              child: Image.asset(
                                IC_NEARBY,
                                height: 25,
                              ),
                            ),
                            title: Text(
                              '${getLokasi.data?[i].name}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              '${getLokasi.data?[i].vicinity}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(
                      height: 15,
                    ),
                    // ButtonSubmitWidget(
                    //   onPressed: () async {
                    //     // Navigator.pop(context, name);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             FormEmergency(idCabang: idCabang),
                    //       ),
                    //     );
                    //   },
                    //   title: "Emergency Service",
                    //   bgColor: Colors.red,
                    //   textColor: Colors.white,
                    //   width: MediaQuery.of(context).size.width / 1.3,
                    //   height: 60,
                    //   borderSide: Colors.red,
                    // ),
                  ],
                ),
              )
            : buildShimmerListVehicle(),
      ),
    );
  }

  Widget _currentLocation() {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition: CameraPosition(
                    target: currentLocation!,
                    zoom: 15,
                  ),
                  onCameraIdle: _onCameraIdle,
                  onCameraMove: _onCameraMove,
                  mapType: MapType.normal,
                  myLocationEnabled: false,
                  // myLocationButtonEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  onMapCreated: (controller) async {
                    setState(() {
                      _controller.complete(controller);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
        Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
        Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.white,
      ),
      // leadingWidth: 80,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
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
      title: Text(
        'Emergency Service',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }

// Widget _buildListCard() {
//   return Padding(
//     padding: const EdgeInsets.only(
//       left: 20,
//       right: 20,
//       top: 10,
//     ),
//     child: ListView.builder(
//       shrinkWrap: true,
//       itemCount: phoneNumbers.length,
//       itemBuilder: (context, index) {
//         final data = phoneNumbers[index];
//         return _buildProduct(data);
//       },
//     ),
//   );
// }

// Widget _buildProduct(Map<String, dynamic> data) {
//   return SizedBox(
//     height: 80,
//     child: InkWell(
//       onTap: () {
//         _launchPhoneCall(data['phone']);
//       },
//       child: Card(
//         color: Colors.white,
//         clipBehavior: Clip.hardEdge,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//             bottomLeft: Radius.circular(10),
//             bottomRight: Radius.circular(10),
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 13, top: 15, bottom: 15),
//               child: Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: const Icon(
//                     Icons.phone,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 13,
//                     top: 20,
//                   ),
//                   child: Text(
//                     data['address'],
//                     style: const TextStyle(
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13, top: 5),
//                   child: Text(
//                     data['phone'],
//                     style: const TextStyle(
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// _launchPhoneCall(String phoneNumber) async {
//   String uri = 'tel:$phoneNumber';
//   try {
//     await launch(uri);
//   } catch (e) {
//     print('Error launching phone call: $e');
//   }
// }
}
