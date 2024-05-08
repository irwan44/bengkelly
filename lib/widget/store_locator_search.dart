import 'dart:convert';

import 'package:bengkelly_apps/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../utils/my_colors.dart';

class StoreLocatorSearch extends StatefulWidget {
  final String? pencarian;

  const StoreLocatorSearch({super.key, this.pencarian});

  @override
  State<StoreLocatorSearch> createState() => _StoreLocatorSearchState();
}

class _StoreLocatorSearchState extends State<StoreLocatorSearch> {
  var controller = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken;
  List<dynamic> placeList = [];

  @override
  void initState() {
    super.initState();
    controller.text = widget.pencarian ?? '';
    controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(controller.text);
  }

  clearText() {
    controller.text = "";
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getSuggestion(String input) async {
    String kPlacesApi = GOOGLE_API_KEY;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPlacesApi&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                fillColor: Colors.white,
                filled: true,
                hintText: "Search Lokasi",
                hintStyle: TextStyle(
                  color: MyColors.appPrimaryColor,
                  fontFamily: 'Nunito',
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                  onPressed: () {
                    clearText();
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: placeList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pop(placeList[index]["description"]);
                    },
                    child: ListTile(
                      title: Text(placeList[index]["description"]),
                    ),
                  );
                },
              ),
            )
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
      centerTitle: true,
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
        'Search',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }
}
