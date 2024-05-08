import 'package:bengkelly_apps/customers/history/component/detail_history.dart';
import 'package:bengkelly_apps/model/get_history.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/history/history_bloc.dart';
import '../../../utils/constants.dart';

class AllHistoryPage extends StatefulWidget {
  const AllHistoryPage({super.key});

  @override
  State<AllHistoryPage> createState() => _AllHistoryPageState();
}

class _AllHistoryPageState extends State<AllHistoryPage> {
  HistoryBloc historyBloc = HistoryBloc();

  @override
  void initState() {
    historyBloc.add(HistoryFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: historyBloc,
      builder: (context, state) {
        if (state is HistoryFailure) {
          return Center(
            child: Text(state.dataError),
          );
        }
        if (state is HistoryLoaded) {
          return _buildBody(state.dataHistory.data);
        }
        return buildShimmerListView();
      },
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      historyBloc.add(HistoryRefresh());
    });
  }

  Widget _buildBody(List<History>? data) {
    return SafeArea(
      child: RefreshIndicator(
        color: MyColors.appPrimaryColor,
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 25,
          ),
          child: SizedBox(
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data?.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final dataHistory = data?[index];
                return SizedBox(
                  width: 330,
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailHistory(data: dataHistory),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, bottom: 10),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/bengkelly.png',
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 15),
                                    child: Text(
                                      "${dataHistory?.namaJenissvc}",
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 5),
                                    child: Text(
                                      '${dataHistory?.namaCabang}',
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 12,
                                          color: Color(0xFF77838F)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, top: 10),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 3,
                                        bottom: 3,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: statusHistoryColor(
                                              dataHistory?.status),
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                          left: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${dataHistory?.status}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: dataHistory?.status ==
                                                  'Selesai Dikerjakan',
                                              child: const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 25, bottom: 30),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      right: 5, left: 5, bottom: 5, top: 5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "${dataHistory?.noPolisi}",
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}