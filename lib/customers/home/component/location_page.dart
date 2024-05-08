import 'dart:async';
import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:bengkelly_apps/widget/store_locator_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import '../../../model/nearby_places.dart';
import '../../../providers/api.dart';
import '../../../utils/constants.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/formfield_widget.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  int radius = 50000;
  static LatLng? currentLocation;
  final Set<Marker> _markers = {};
  String placemarkAddress = "";

  GetNearbyPlaces getNearbyPlaces = GetNearbyPlaces();
  LatLng? _lastMapPosition = currentLocation;
  double? lat, lng;

  @override
  void initState() {
    _lokasiSekarang();
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
      _getNearbyPlaces(currentLocation);
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
      debugPrint("hahahaha $getNearbyPlaces");
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

  // void setSourceAndDestinationIcons() async {
  //   markerIcon = await getBytesFromAsset(LOCATION_MARK, 100);
  // }

  Future<void> _addMarker(tmpLat, tmpLng) async {
    _markers.add(
      Marker(
        markerId: const MarkerId('marker_id_1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(tmpLat, tmpLng),
      ),
    );
  }

  Future<void> _getPlaceApi(String cari) async {
    try {
      var hasil = await api.placesApi(cari: cari);
      if (hasil != null) {
        await _getLocation(hasil.candidates?[0].geometry?.location?.lat,
            hasil.candidates?[0].geometry?.location?.lng);
        setState(() {
          currentLocation = LatLng(
              hasil.candidates?[0].geometry?.location?.lat ?? 0.0,
              hasil.candidates?[0].geometry?.location?.lng ?? 0.0);
          _addMarker(hasil.candidates?[0].geometry?.location?.lat,
              hasil.candidates?[0].geometry?.location?.lng);
        });
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation!, zoom: 15)));
      }
    } catch (e) {
      // Get.snackbar("Gagal", "Gagal Menemukan Lokasi");
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
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
        headerBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.grey,
            height: 50,
            child: const Center(
              child: Text('Swipe me!'),
            ),
          ),
        ),
        showOnAppear: true,
        maxHeight: 300,
        smoothness: Smoothness.high,
        body: getNearbyPlaces.results != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      onTap: () async {
                        Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        await _getLocation(
                            position.latitude, position.longitude);
                        setState(() {
                          currentLocation =
                              LatLng(position.latitude, position.longitude);
                          _getNearbyPlaces(currentLocation);
                          _addMarker(position.latitude, position.longitude);
                        });
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: currentLocation!, zoom: 15)));
                      },
                      title: Text(
                        'Gunakan lokasi sekarang',
                        style: TextStyle(
                          color: MyColors.appPrimaryColor,
                        ),
                      ),
                      leading: ImageIcon(
                        const AssetImage(
                          IC_CENTER_LOC,
                        ),
                        size: 30,
                        color: MyColors.appPrimaryColor,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    if (getNearbyPlaces.results != null)
                      for (int i = 0; i < getNearbyPlaces.results!.length; i++)
                        ListTile(
                          onTap: () async {
                            await _getLocation(
                              getNearbyPlaces
                                  .results?[i].geometry?.location.lat,
                              getNearbyPlaces
                                  .results?[i].geometry?.location.lng,
                            );
                            setState(() {
                              currentLocation = LatLng(
                                getNearbyPlaces
                                        .results?[i].geometry?.location.lat ??
                                    0.0,
                                getNearbyPlaces
                                        .results?[i].geometry?.location.lng ??
                                    0.0,
                              );
                              _getNearbyPlaces(currentLocation);
                              _addMarker(
                                currentLocation?.latitude,
                                currentLocation?.longitude,
                              );
                            });
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: currentLocation!, zoom: 15)));
                          },
                          leading: Image.asset(
                            IC_NEARBY,
                            height: 25,
                          ),
                          title: Text(
                            '${getNearbyPlaces.results?[i].name}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            '${getNearbyPlaces.results?[i].vicinity}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ButtonSubmitWidget(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TabPageCustomer(address: placemarkAddress),
                          ),
                        );
                      },
                      title: "Pilih Lokasi",
                      bgColor: MyColors.appPrimaryColor,
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: 60,
                      borderSide: MyColors.appPrimaryColor,
                    ),
                    const SizedBox(
                      height: 10,
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
      centerTitle: true,
      title: Text(
        'Pilih Lokasi',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
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
                child: Stack(
                  children: [
                    GoogleMap(
                      markers: _markers,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: CustomTextFormField(
                        readOnly: true,
                        controller: _searchController,
                        hintText: 'Search…',
                        hintStyle: TextStyle(
                          color: MyColors.appPrimaryColor,
                          fontFamily: 'Nunito',
                          fontSize: 16,
                        ),
                        prefix: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onTap: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoreLocatorSearch(
                                pencarian: _searchController.text,
                              ),
                            ),
                          );

                          if (res != null) {
                            _getPlaceApi(res).then((value) {
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabPageCustomer(
                                        address: placemarkAddress),
                                  ),
                                );
                              });
                            });
                            setState(() {
                              _searchController.text = res;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
