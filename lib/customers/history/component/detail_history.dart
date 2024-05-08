import 'package:bengkelly_apps/model/get_history.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/my_colors.dart';

class DetailHistory extends StatelessWidget {
  final History? data;

  const DetailHistory({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          _buildContent(),
          _buildJasa(),
          _buildPart(),
          // _buildDescription(context),
          // _buildFacility(),
          // _buildTenant(),
        ],
      ),
    );
  }

  Widget _buildPart() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
            child: Text(
              'Part',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Nunito',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          data!.part!.isNotEmpty
              ? ListView.builder(
            itemCount: data?.part?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final part = data?.part?[index];
              return SizedBox(
                width: 330,
                height: 100,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailTenants(
                    //       data: restAreaTenants[index],
                    //     ),
                    //   ),
                    // );
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 13, top: 10),
                              child: Text(
                                '${part?.namaSparepart}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 13, top: 5),
                              child: Text(
                                '${part?.kodeSparepart}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 13, top: 5),
                              child: Text(
                                formatMoney(part?.harga),
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    color: MyColors.appPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, bottom: 35),
                          child: Text(
                            formatDateNoTime(part?.tgl),
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF77838F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              :  Card(
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
            child: Container(
              width: double.infinity,
              child:
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(10), child:
                  Text(
                      '${data?.message}'
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJasa() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
            child: Text(
              'Jasa',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          data!.jasa!.isNotEmpty
              ? ListView.builder(
            itemCount: data?.jasa?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final jasa = data?.jasa?[index];
              return SizedBox(
                width: 330,
                height: 100,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 13, top: 10),
                            child: Text(
                              '${jasa?.namaJasa}',
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 13, top: 5),
                            child: Text(
                              '${jasa?.kodeJasa}',
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 13, top: 5),
                            child: Text(
                              formatMoney(jasa?.harga),
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: MyColors.appPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 15, bottom: 35),
                        child: Text(
                          formatDateNoTime(jasa?.tgl),
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF77838F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
              :   Card(
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
            child: Container(
              width: double.infinity,
              child:
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(10), child:
                  Text(
                      '${data?.message}'
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data?.namaJenissvc}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Nunito',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${data?.namaCabang}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            '${imageDetailHistory(data?.namaCabang)}',
            fit: BoxFit.cover,
            height: 350,
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
        'Detail History',
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