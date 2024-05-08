import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../providers/common_data.dart';
import '../../../utils/general_function.dart';
import '../../../utils/my_colors.dart';
import '../component/detail_rest_area.dart';

class AllLocationBengkelly extends StatefulWidget {
  const AllLocationBengkelly({super.key});

  @override
  State<AllLocationBengkelly> createState() => _AllLocationBengkellyState();
}

class _AllLocationBengkellyState extends State<AllLocationBengkelly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildListCard()],
    );
  }

  Widget _buildListCard() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: restAreaPlace.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final data = restAreaPlace[index];
          return _buildProduct(data);
        },
      ),
    );
  }

  Widget _buildProduct(data) {
    return SizedBox(
      height: 150,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailRestArea(data: data),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      '${imageLocationBengkelly(data['name'])}',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 35),
                    child: Text(
                      data['name'],
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 5),
                    child: Text(
                      data['address'],
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Color(0xFF77838F)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 9),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: MyColors.blueOpacity,
                              shape: BoxShape.circle),
                          height: 25,
                          width: 25,
                          child: Icon(
                            Icons.restaurant,
                            color: MyColors.appPrimaryColor,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: MyColors.blueOpacity,
                              shape: BoxShape.circle),
                          height: 25,
                          width: 25,
                          child: Icon(
                            Icons.people_alt_outlined,
                            color: MyColors.appPrimaryColor,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: MyColors.blueOpacity,
                              shape: BoxShape.circle),
                          height: 25,
                          width: 25,
                          child: Icon(
                            Icons.local_gas_station,
                            color: MyColors.appPrimaryColor,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.transparent,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Lokasi Bengkelly',
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
      // actions: [
      //
      // ],
    );
  }
}
