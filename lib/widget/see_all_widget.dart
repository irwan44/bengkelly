import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class SeeAllWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const SeeAllWidget({
    Key? key,
    this.onPressed,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: onPressed,
            child: const Text(
              'Lihat Semua',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
