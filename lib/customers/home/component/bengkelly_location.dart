import 'package:bengkelly_apps/customers/home/lokasi_bengkelly/all_location_bengkelly.dart';
import 'package:bengkelly_apps/providers/common_data.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/see_all_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/general_function.dart';

class BengkellyLocation extends StatelessWidget {
  final Function(dynamic data)? onPressed;

  const BengkellyLocation({
    super.key,
    this.onPressed,
  });

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
                builder: (context) => const AllLocationBengkelly(),
              ),
            );
          },
          title: 'Lokasi Bengkelly',
        ),
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
        height: 160,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: restAreaPlace.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final data = restAreaPlace[index];
            return _buildProduct(data);
          },
        ),
      ),
    );
  }

  Widget _buildProduct(data) {
    return SizedBox(
      width: 330,
      child: InkWell(
        onTap: () => onPressed!(data),
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
}
