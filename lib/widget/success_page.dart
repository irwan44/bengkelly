import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String imageData, title, subtitle, titleButton;
  final Widget classWidget;
  const SuccessPage({
    Key? key,
    required this.imageData,
    this.title = '',
    this.subtitle = '',
    this.titleButton = '',
    required this.classWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // _buildAppBar(context),
          const SizedBox(height: 150),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              imageData,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 25),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: MyColors.appPrimaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Nunito',
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: ButtonSubmitWidget(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => classWidget));
              },
              title: titleButton,
              bgColor: MyColors.appPrimaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 1.3,
              height: 60,
              borderSide: MyColors.appPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildAppBar(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: Container(
  //       height: 45,
  //       width: 45,
  //       margin: const EdgeInsets.fromLTRB(30, 36, 0, 0),
  //       decoration: BoxDecoration(
  //         shape: BoxShape.rectangle,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(color: Colors.grey.shade300),
  //       ),
  //       child: InkWell(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: const Icon(
  //           Icons.arrow_back_ios_new,
  //           color: Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
