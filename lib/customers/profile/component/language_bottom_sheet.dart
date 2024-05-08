import 'package:flutter/material.dart';

import '../../../utils/my_colors.dart';

class LanguageBottomSheetPage extends StatefulWidget {
  const LanguageBottomSheetPage({super.key});

  @override
  State<LanguageBottomSheetPage> createState() => _LanguageBottomSheetPageState();
}

class _LanguageBottomSheetPageState extends State<LanguageBottomSheetPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.35,
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
                    'Pilih Bahasa',
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
              _buildServiceType(),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceType() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // final item = ;
        return Padding(
          padding: const EdgeInsets.only(top: 13),
          child: ListTile(
            tileColor: null,
            onTap: () {
              // setState(() {
              //   // _updateListTile(index);
              //   // debugPrint(index.toString());
              //   // if (count == 0) {
              //   //   widget.isSelectedService('');
              //   // } else {
              //   //   widget.isSelectedService(data[index].namaJenissvc);
              //   // }
              //   widget.isSelectedService(
              //     data?[index],
              //   );
              //   count = 1;
              // });
              // Navigator.pop(context);
            },
            contentPadding: const EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                // Visibility(
                //   visible: widget.controller.text == data?[index].namaJenissvc,
                //   child: Icon(
                //     Icons.check,
                //     color: MyColors.appPrimaryColor,
                //     size: 21,
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Indonesia",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: Colors.black,
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
