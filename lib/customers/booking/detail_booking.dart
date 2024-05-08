import 'dart:convert';
import 'package:bengkelly_apps/bloc/gcu/gcu_bloc.dart';
import 'package:bengkelly_apps/model/get_service.dart';
import 'package:bengkelly_apps/model/get_vehicle.dart';
import 'package:bengkelly_apps/widget/formfield_widget.dart';
import 'package:bengkelly_apps/widget/success_page.dart';
import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../providers/api.dart';
import '../../utils/general_function.dart';
import '../../widget/actions_widget.dart';

class DetailBookingPage extends StatefulWidget {
  final Vehicle? vehicleType;
  final Service? serviceType;
  final String? timePick, datePick, keluhan, location, timeWithExtension;
  final int? idLocation;

  const DetailBookingPage({
    super.key,
    this.vehicleType,
    this.serviceType,
    this.timePick,
    this.datePick,
    this.keluhan,
    this.location,
    this.timeWithExtension,
    this.idLocation,
  });

  @override
  State<DetailBookingPage> createState() => _DetailBookingPageState();
}

class _DetailBookingPageState extends State<DetailBookingPage> {
  bool isLoading = false;
  GCUBloc gcuBloc = GCUBloc();
  TextEditingController complaintController = TextEditingController();
  @override
  void initState() {
    gcuBloc.add(GCUFetch());
    complaintController = TextEditingController(text: widget.keluhan ?? '-');
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
          child: Text('Detail Lokasi, Tanggal dan Waktu'),
        ),
        _detailsTimeLoc(),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 15,
          ),
          child: Text('Jenis Servis'),
        ),
        _serviceType(),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 15,
          ),
          child: Text('Keluhan'),
        ),
        _complaint(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ButtonSubmitWidget(
            onPressed: () => _createBooking(context),
            title: "KONFIRMASI BOOKING",
            bgColor: MyColors.appPrimaryColor,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width / 1.3,
            height: 60,
            borderSide: MyColors.appPrimaryColor,
            loading: isLoading,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _detailsTimeLoc() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.location}',
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
                      '${widget.datePick}',
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
                      '${widget.timeWithExtension}',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.greyReview,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.vehicleType?.merks?.namaMerk} - ${widget.vehicleType?.tipes?[0].namaTipe}',
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
                      '${widget.vehicleType?.noPolisi}',
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
                      '${widget.vehicleType?.warna ?? 'Unknown'} - Tahun ${widget.vehicleType?.tahun ?? '0000'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.greyReview,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            )
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
            fontSize: 16, fontFamily: 'Nunito', fontWeight: FontWeight.bold),
        textInputType: TextInputType.text,
      ),
    );
  }

  Widget _serviceType() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 6,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.rectangle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.serviceType?.namaJenissvc}',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildItemServiceType(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemServiceType() {
    return BlocBuilder(
      bloc: gcuBloc,
      builder: (context, state) {
        if (state is GCUFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is GCULoaded) {
          return ListView.builder(
            itemCount: state.gcu.data?.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final gcuList = state.gcu.data?[index].gcu;
              final subHeading = state.gcu.data?[index].subHeading;
              return Visibility(
                visible:
                    widget.serviceType?.namaJenissvc == 'General Check UP/P2H',
                child: ExpansionTile(
                  title: Text(
                    '$subHeading',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      fontSize: 14,
                    ),
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    // ListView.builder untuk menampilkan list dari gcu
                    ListView.builder(
                      itemCount: gcuList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final gcuItem = gcuList?[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              const Text(
                                "\u2022",
                                style: TextStyle(fontSize: 25),
                              ),
                              Expanded(
                                child: Text(
                                  ' ${gcuItem!['gcu']}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: MyColors.appPrimaryColor,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.white,
      ),
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
        'Detail Booking',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
      actions: const [
        ActionWidget(),
      ],
    );
  }

  Future<void> _createBooking(BuildContext context) async {
    try {
      _showLoading();
      var res = await api.createBooking(
        widget.idLocation,
        widget.serviceType?.id,
        widget.keluhan,
        widget.datePick,
        widget.timePick,
        widget.vehicleType?.id,
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
                title: "Booking Berhasil!",
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
