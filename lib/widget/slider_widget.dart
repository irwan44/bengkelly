import 'package:flutter/material.dart';

class SliderImageWidget extends StatelessWidget {
  final String image;

  const SliderImageWidget({Key? key, this.image = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // _launchURL(slider.url);
            },
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: 500,

            ),
          ),
        ],
      ),
    );
  }
}
