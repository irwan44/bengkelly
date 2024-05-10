import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/news/news_bloc.dart';
import '../../bloc/news_fleet/news_fleet_bloc.dart';
import '../../model/master_data.dart';
import '../../model/rss_feed.dart';
import '../../providers/common_data.dart';
import '../../utils/constants.dart';
import '../../utils/general_function.dart';
import '../../utils/my_colors.dart';
import '../../widget/actions_widget.dart';
import '../../widget/grid_widget.dart';
import '../../widget/see_all_widget.dart';
import '../../widget/slider_widget.dart';
import '../news/news_detail.dart';
import 'component/bengkelly_location.dart';
import 'component/detail_rest_area.dart';
import 'component/detail_special_offer.dart';
import 'component/location_page.dart';
import 'component/news_page.dart';
import 'component/special_offer_page.dart';
import 'component/today_deals_page.dart';
import 'menus.dart';
import 'news/news_bengkelly.dart';
import 'news/news_fleet_maintenance.dart';

class HomePage extends StatefulWidget {
  final String? address;

  const HomePage({
    Key? key,
    this.address,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  List<SliderImageWidget> imageSliders = [
    const SliderImageWidget(
      image: SLIDERS2,
    ),
    const SliderImageWidget(
      image: SLIDERS,
    ),
    const SliderImageWidget(
      image: SLIDERS3,
    ),
    const SliderImageWidget(
      image: SLIDERS4,
    ),
  ];

  final NewsBloc newsBloc = NewsBloc();
  final NewsFleetBloc newsFleetBloc = NewsFleetBloc();
  List<MasterData> _masterDataList = [];
  UserMenus userCategoryMenus = UserMenus();

  LatLng? currentLocation;
  String placemarkAddress = "";

  Future<void> _lokasiSekarang() async {
    debugPrint('lokasiSekarang');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await _getLocation(position.latitude, position.longitude);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void onMenuTap(Function onMenuTap) {
    onMenuTap();
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

  @override
  void initState() {
    newsBloc.add(NewsFetchBengekelly());
    newsFleetBloc.add(NewsFleetFetch());
    _lokasiSekarang();
    _checkForUpdate(); // Panggil metode untuk memeriksa pembaruan saat inisialisasi halaman
    super.initState();
  }

  Future<void> _checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(updateInfo: updateInfo);
          },
        );
      }
    } catch (e) {
      print('Error checking for update: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 8),
              _buildSliders(),
              const SizedBox(height: 20),
              _buildGridMenus(),
              const SizedBox(height: 20),
              BengkellyLocation(
                onPressed: (dynamic data) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailRestArea(data: data),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SpecialOfferPage(
                onPressed: (dataProduct) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailSpecialOffer(product: dataProduct),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              TodayDealsPage(
                dataProduct: dataProduct, // Menggunakan dataProduct yang disediakan
                onPressed: (product) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailSpecialOffer(product: product),
                    ),
                  );
                },
              ),
              Column(
                children: [
                  _buildNewsBengkelly(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildNewsFleetMaintenance()
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNewsBengkelly() {
    return BlocBuilder(
      bloc: newsBloc,
      builder: (context, state) {
        if (state is NewsFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is NewsLoadedBengkelly) {
          return Column(
            children: [
              // SizedBox(height: 0),
              SeeAllWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsBengkelly(),
                    ),
                  );
                },
                // onPressed: seeAll,
                title: 'News',
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 30),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.9,
                  crossAxisCount: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  mainAxisExtent: 210,
                ),
                itemCount: state.dataRss!.length,
                itemBuilder: (context, index) {
                  if (index < state.dataRss!.length) {
                    return NewsPage(
                      data: state.dataRss?[index],
                      onPressed: (RssFeed? data) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsNews(data: data),
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          );
        }
        return buildShimmerListCard();
      },
    );
  }

  Widget _buildNewsFleetMaintenance() {
    return BlocBuilder(
      bloc: newsFleetBloc,
      builder: (context, state) {
        if (state is NewsFleetFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is NewsFleetLoaded) {
          return Column(
            children: [
              SeeAllWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsFleetMaintenance(),
                    ),
                  );
                },
                title: 'News Fleet Maintenance',
              ),
              GridView.builder(
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
                itemCount: state.dataRss!.length,
                itemBuilder: (context, index) {
                  if (index < state.dataRss!.length) {
                    return NewsPage(
                      data: state.dataRss?[index],
                      onPressed: (RssFeed? data) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsNews(data: data),
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          );
        }
        return buildShimmerListCard();
      },
    );
  }

  Widget _buildGridMenus() {
    _buildMenu(context);
    return GridMenuWidget(
      listMenu: _masterDataList,
      onMenuTap: onMenuTap,
    );
  }

  _buildMenu(BuildContext context) {
    _masterDataList = [];
    _masterDataList = userCategoryMenus.buildMenu(context);
  }

  Widget _buildSliders() {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              height: 200,
              viewportFraction: 1,
              autoPlay: true,
              enableInfiniteScroll: true,
              aspectRatio: 2.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.map((slider) {
              return Container(
                width: 15,
                height: 5.0,
                margin:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                  color: _current == imageSliders.indexOf(slider)
                      ? MyColors.appPrimaryColor
                      : const Color.fromRGBO(0, 0, 0, 0.2),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: MyColors.appPrimaryColor,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LocationPage()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                IC_LOCATION,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LocationPage()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Lokasi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Nunito',
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF606060),
                  size: 18,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: placemarkAddress != ''
                      ? Text(
                    widget.address != null
                        ? widget.address ?? ''
                        : placemarkAddress,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Nunito',
                    ),
                  )
                      : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: const [
        ActionWidget(),
      ],
    );
  }
}

class UpdateDialog extends StatelessWidget {
  final AppUpdateInfo updateInfo;

  const UpdateDialog({
    Key? key,
    required this.updateInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Tersedia'),
      content: Text('Bug telah diperbaiki dan kinerja telah ditingkatkan. Untuk menikmati fitur dan peningkatan terbaru, unduh versi terbaru aplikasi Bengkelly.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Nanti'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await InAppUpdate.startFlexibleUpdate();
          },
          child: Text('Perbarui'),
        ),
      ],
    );
  }
}
