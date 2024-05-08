import 'package:bengkelly_apps/widget/see_all_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class BestPromoPage extends StatelessWidget {
  final Function()? onPressed;

  const BestPromoPage({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SeeAllWidget(
          onPressed: () {},
          title: 'Best Promo!',
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
          itemCount: 5,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildProduct();
          },
        ),
      ),
    );
  }

  Widget _buildProduct() {
    return SizedBox(
      width: 330,
      child: InkWell(
        onTap: onPressed,
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
                      DUMMY_PROMO_IMAGE,
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
                  const Padding(
                    padding: EdgeInsets.only(left: 13, top: 35),
                    child: Text(
                      'Promo #1',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13, top: 5),
                    child: Text(
                      'Vivamus aliquam nisl eu\nmassa aliquam mollis.',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Color(0xFF77838F)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 9),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Color(0xFFF2B90D),
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '4.8 reviews',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: Color(0xFF878787),
                          ),
                        )
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
