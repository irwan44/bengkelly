import 'dart:convert';

import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:flutter/material.dart';

import '../../model/get_vehicle.dart';
import '../../providers/api.dart';
import '../../utils/constants.dart';
import '../../utils/general_function.dart';
import '../../utils/my_colors.dart';
import '../../widget/button_widget.dart';
import '../../widget/success_page.dart';
import '../xroot/tabPageCustomer.dart';

class DetailEmergencyService extends StatefulWidget {
  final int? idCabang;
  final String? keluhan;
  final Vehicle? vehicle;

  const DetailEmergencyService({
    super.key,
    this.idCabang,
    this.keluhan,
    this.vehicle,
  });

  @override
  State<DetailEmergencyService> createState() => _DetailEmergencyServiceState();
}

class _DetailEmergencyServiceState extends State<DetailEmergencyService> {
  TextEditingController complaintController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    complaintController = TextEditingController(text: widget.keluhan ?? "-");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 15,
          ),
          child: Text('Detail Kendaraan'),
        ),
        _detailsVehicle(),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 15,
          ),
          child: Text('Keluhan'),
        ),
        _complaint(),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 15,
          ),
          child: Text('Notes'),
        ),
        _notes(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ButtonSubmitWidget(
            onPressed: createEmergency,
            title: "CONFIRM EMERGENCY SERVICE",
            bgColor: MyColors.redEmergencyMenu,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width / 1.3,
            height: 60,
            borderSide: MyColors.redEmergencyMenu,
            loading: isLoading,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _detailsVehicle() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.vehicle?.merks?.namaMerk} - ${widget.vehicle?.tipes?[0].namaTipe}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 6,
                    ),
                    child: Text(
                      '${widget.vehicle?.noPolisi}',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.greyReview,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 6,
                    ),
                    child: Text(
                      '${widget.vehicle?.warna ?? 'Unknown'} - Tahun ${widget.vehicle?.tahun ?? '0000'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.greyReview,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _complaint() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 6,
      ),
      child: CustomTextFormField(
        controller: complaintController,
        maxLines: 5,
        readOnly: true,
        fillColor: Colors.grey.shade200,
        textStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold
        ),
        textInputType: TextInputType.text,
      ),
    );
  }

  Widget _notes() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 6,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Untuk Emergency Service Pihak Bengkelly Bekerja Sama dengan JMTO (Jasa Marga TollRoad Operator).  Mohon menunggu konfirmasi dari kami selanjutnya',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito',
                  ),
                )
              ],
            ),
          ],
        ),
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
      title: Text(
        'Emergency Service',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }

  Future<void> createEmergency() async {
    try {
      _showLoading();
      var res = await api.createEmergency(
        widget.idCabang,
        widget.keluhan,
        widget.vehicle?.id,
      );
      var result = json.decode(res);
      if (result['status'] == true) {
        showSnackBar(
          'Berhasil Create Booking',
          SnackBarType.succes,
          SUCCESS_IC,
          context,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SuccessPage(
                imageData: SUCCESS_MARK,
                title: "Emergency Berhasil!",
                subtitle: "Silakan kembali ke Home",
                titleButton: "Kembali Ke Home",
                classWidget: TabPageCustomer(),
              ),
            ),
            (Route<dynamic> route) => false);
      }
    } catch (error, stackTrace) {
      _dismissLoading();
      // var errorMessage = 'An error occurred';
      // if (error is FormatException) {
      //   errorMessage = error.message;
      // } else {
      //   errorMessage = 'An error occurred: $error';
      // }
      showSnackBar(
        '$error',
        SnackBarType.error,
        ERROR_IC,
        context,
      );
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
  }

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }
}
