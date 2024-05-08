import 'package:bengkelly_apps/message/component/tab_page_message.dart';
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/my_colors.dart';
import '../widget/formfield_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildSearch(),
        const Expanded(
          child: TabPageMessage(),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 16),
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: theme.colorScheme.primaryContainer,
            width: 1,
          ),
        ),
        onChange: (String str) {},
        prefix: const Icon(
          Icons.search,
          size: 26,
          color: Color(0xFF4E4E4E),
        ),
        showCursor: true,
        cursorColor: const Color(0xFF4E4E4E),
        contentPadding: const EdgeInsets.only(top: 10),
        controller: _searchController,
        hintText: "Cari Pesan",
        hintStyle: const TextStyle(
          color: Color(0xFF4E4E4E),
          fontSize: 14,
        ),
        textInputType: TextInputType.text,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Message',
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
