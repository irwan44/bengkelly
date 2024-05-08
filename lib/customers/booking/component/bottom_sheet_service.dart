import 'package:bengkelly_apps/bloc/service/service_bloc.dart';
import 'package:bengkelly_apps/model/get_service.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/my_colors.dart';

class BottomSheetService extends StatefulWidget {
  final TextEditingController controller;
  final Function(Service? isSelectedService) isSelectedService;

  const BottomSheetService({
    super.key,
    required this.controller,
    required this.isSelectedService,
  });

  @override
  State<BottomSheetService> createState() => _BottomSheetServiceState();
}

class _BottomSheetServiceState extends State<BottomSheetService> {
  ServiceBloc serviceBloc = ServiceBloc();

  @override
  void initState() {
    serviceBloc.add(ServiceFetch());
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: MyColors.blackMenu,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  const Text(
                    'Pilih Jenis Service',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              BlocBuilder(
                bloc: serviceBloc,
                builder: (context, state) {
                  if (state is ServiceFailure) {
                    return Center(
                      child: Text(state.dataError),
                    );
                  }
                  if (state is ServiceLoaded) {
                    return _buildServiceType(state.dataService.data);
                  }
                  return buildShimmerListService();
                },
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: ButtonSubmitWidget(
            onPressed: () {
              setState(() {
                if (count != 0) {
                  debugPrint("not null");
                  Navigator.pop(context);
                }
              });
            },
            title: "Pilih Servis",
            bgColor:
                count != 0 ? MyColors.appPrimaryColor : MyColors.greyButton,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width / 1.3,
            height: 60,
            borderSide:
                count != 0 ? MyColors.appPrimaryColor : MyColors.greyButton,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceType(List<Service>? data) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data?.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // final item = ;
        return Padding(
          padding: const EdgeInsets.only(top: 13),
          child: ListTile(
            tileColor: widget.controller.text == data?[index].namaJenissvc
                ? Colors.grey.shade300
                : null,
            onTap: () {
              setState(() {
                // _updateListTile(index);
                // debugPrint(index.toString());
                // if (count == 0) {
                //   widget.isSelectedService('');
                // } else {
                //   widget.isSelectedService(data[index].namaJenissvc);
                // }
                widget.isSelectedService(
                  data?[index],
                );
                count = 1;
              });
              // Navigator.pop(context);
            },
            contentPadding: const EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: widget.controller.text == data?[index].namaJenissvc,
                  child: Icon(
                    Icons.check,
                    color: MyColors.appPrimaryColor,
                    size: 21,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${data?[index].namaJenissvc}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        widget.controller.text == data?[index].namaJenissvc
                            ? FontWeight.bold
                            : FontWeight.normal,
                    fontFamily: 'Nunito',
                    color: widget.controller.text == data?[index].namaJenissvc
                        ? MyColors.appPrimaryColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
