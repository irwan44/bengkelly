import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bengkelly_apps/model/get_lokasi.dart';
import 'package:bengkelly_apps/model/nearby_places.dart';
import 'package:bengkelly_apps/providers/api.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../widget/button_widget.dart';

class BottomSheetLocationtest extends StatefulWidget {
  final Function(String locationRestArea, int? idLocations) onSelected;

  const BottomSheetLocationtest({
    super.key,
    required this.onSelected,
  });

  @override
  State<BottomSheetLocationtest> createState() =>
      _BottomSheetLocationtestState();
}

class _BottomSheetLocationtestState extends State<BottomSheetLocationtest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  int radius = 50000;
  static LatLng? currentLocation;
  final Set<Marker> _markers = {};
  String placemarkAddress = "";
  GetNearbyPlaces getNearbyPlaces = GetNearbyPlaces();
  LatLng? _lastMapPosition = currentLocation;
  double? lat, lng;
  GetLokasi getLokasi = GetLokasi();
  String? name;
  Uint8List? markerIcon;
  int? idCabang;

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

  Future<void> _getNearbyPlaces(LatLng? currentLocation) async {
    var data = await api.getNearbyPlaces(
      currentLocation?.latitude.toString() ?? '',
      currentLocation?.longitude.toString() ?? '',
      radius.toString(),
    );

    setState(() {
      getNearbyPlaces = data;
    });
  }

  _onCameraMove(CameraPosition position) async {
    debugPrint('_onCameraMove');
    setState(() {
      _lastMapPosition = position.target;
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

  void setSourceAndDestinationIcons() async {
    markerIcon = await getBytesFromAsset(DROP_PIN, 100);
  }

  Future<void> _addMarker(tmpLat, tmpLng) async {

    // Add marker for current location
    _markers.add(
      Marker(
        markerId: MarkerId('current_location'),
      ),
    );

    // Add markers for nearby locations
    if (getLokasi.data != null) {
      for (int i = 0; i < getLokasi.data!.length; i++) {
        double? lat = double.tryParse(
            getLokasi.data![i].geometry?.location?.lat ?? '0.0');
        double? lng = double.tryParse(
            getLokasi.data![i].geometry?.location?.lng ?? '0.0');

        if (lat != null && lng != null) {
          Uint8List markerIcon = await getBytesFromAsset(DROP_PIN, 100);
          _markers.add(
            Marker(
              markerId: MarkerId('marker_$i'), // Use unique ID for each marker
              icon: BitmapDescriptor.fromBytes(markerIcon),
              position: LatLng(lat, lng),
            ),
          );
        }
      }
    }
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
    if (lat1 == null ||
        lon1 == null ||
        lat2 == null ||
        lon2 == null) {
      // Handle the case where any of the parameters are null
      return 0.0; // Return a default value, indicating invalid distance
    }
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) *
            c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) /
            2;
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
        draggableBody: true,
        autoSwiped: true,
        minHeight: 200,
        headerBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.transparent,
            height: 50,
            width: double.infinity,
            child: const Center(
              child: Text('Swipe me!'),
            ),
          ),
        ),
        showOnAppear: true,
        smoothness: Smoothness.high,
        body: getLokasi.data != null
            ? SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              if (getLokasi.data != null)
                for (int i = 0; i < getLokasi.data!.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: ListTile(
                      tileColor: idCabang ==
                          getLokasi.data?[i].geometry?.location?.id
                          ? MyColors.blueOpacity
                          : null,
                      onTap: () async {
                        await _getLocation(
                          double.parse(getLokasi
                              .data?[i].geometry?.location?.lat ??
                              '0.0'),
                          double.parse(getLokasi
                              .data?[i].geometry?.location?.lng ??
                              '0.0'),
                        );
                        setState(() {
                          currentLocation = LatLng(
                            double.parse(getLokasi
                                .data?[i].geometry?.location?.lat ??
                                '0.0'),
                            double.parse(getLokasi
                                .data?[i].geometry?.location?.lng ??
                                '0.0'),
                          );
                          // _getNearbyPlaces(currentLocation);
                          _addMarker(
                            currentLocation?.latitude,
                            currentLocation?.longitude,
                          );

                          widget.onSelected(
                            getLokasi.data?[i].name ?? '',
                            getLokasi.data?[i].geometry?.location?.id,
                          );
                          idCabang =
                              getLokasi.data?[i].geometry?.location?.id;
                        });
                        final GoogleMapController controller =
                        await _controller.future;
                        controller.animateCamera(CameraUpdate
                            .newCameraPosition(CameraPosition(
                            target: currentLocation!, zoom: 15)));
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
            ],
          ),
        )
            : buildShimmerListVehicle(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
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
      centerTitle: false,
      title: Text(
        'Lokasi Bengkelly',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
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
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation!,
                    zoom: 15,
                  ),
                  onCameraIdle: _onCameraIdle,
                  onCameraMove: _onCameraMove,
                  mapType: MapType.terrain,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  onMapCreated: (controller) async {
                    setState(() {
                      _controller.complete(controller);
                    });
                  },
                ),
              ),
              SizedBox(height: 250,),
            ],

          ),

        ],
      ),
    );
  }
}
