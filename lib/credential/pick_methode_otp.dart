import 'package:flutter/material.dart';

class PickMethodeOTPPage extends StatelessWidget {
  const PickMethodeOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
        ],
      ),
    );
  }
  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.fromLTRB(30, 36, 0, 0),
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
    );
  }
}
