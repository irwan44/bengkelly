import 'dart:convert';
import 'dart:io';

import 'package:bengkelly_apps/customers/xroot/tabPageCustomer.dart';
import 'package:bengkelly_apps/model/others_images.dart';
import 'package:bengkelly_apps/model/user.dart';
import 'package:bengkelly_apps/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/auth.dart';
import '../../utils/constants.dart';
import '../../utils/general_function.dart';
import '../../utils/my_colors.dart';
import '../../widget/formfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  final Data? data;

  const EditProfilePage({
    super.key,
    this.data,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? usernameController;
  TextEditingController? hpController;
  TextEditingController? emailController;
  TextEditingController? addressController;
  bool isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();
  OthersImage? photosImage;
  String? urlImageProfile;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    usernameController = TextEditingController(text: widget.data?.nama);
    hpController = TextEditingController(text: widget.data?.hp);
    emailController = TextEditingController(text: widget.data?.email);
    addressController = TextEditingController(text: widget.data?.alamat ?? '-');
    setState(() {
      urlImageProfile = widget.data?.gambar;
    });
    super.initState();
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => _buildBottomSheetImage(),
            child: Stack(
              children: [
                photosImage?.image == null && widget.data?.gambar == null
                    ? Container(
                        margin: const EdgeInsets.only(
                          bottom: 13,
                        ),
                        child: Center(
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: const Color(0xFFD7E1FE),
                            child: Center(
                              child: Image.asset(
                                DUMMY_AVATAR,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    : photosImage?.image == null && widget.data?.gambar != null
                        ? Container(
                            margin: const EdgeInsets.only(
                              bottom: 13,
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: const Color(0xFFD7E1FE),
                                backgroundImage: NetworkImage('$urlImageProfile'),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                              bottom: 13,
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: const Color(0xFFD7E1FE),
                                backgroundImage: FileImage(
                                  File('${photosImage?.image}'),
                                ),
                              ),
                            ),
                          ),
                Positioned(
                  right: 125,
                  top: 65,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color(0xFFD7E1FE),
                    child: Center(
                      child: Image.asset(
                        EDIT,
                        height: 24,
                        width: 24,
                        color: MyColors.appPrimaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Text(
              'Ganti Foto',
              style: TextStyle(
                fontSize: 18,
                color: MyColors.appPrimaryColor,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextFormField(
              controller: usernameController,
              hintText: 'Nama Lengkap',
              hintStyle: TextStyle(color: Colors.grey),
              showCursor: true,
              cursorColor: Colors.black,
              textInputType: TextInputType.name,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextFormField(
              controller: hpController,
              hintText: 'Nomer Handphone',
              hintStyle: TextStyle(color: Colors.grey),
              showCursor: true,
              cursorColor: Colors.black,
              textInputType: TextInputType.name,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextFormField(
              controller: emailController,
              hintText: 'Email Anda',
              hintStyle: TextStyle(color: Colors.grey),
              showCursor: true,
              cursorColor: Colors.black,
              textInputType: TextInputType.name,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextFormField(
              hintText: 'Alamat Lengkap',
              hintStyle: TextStyle(color: Colors.grey),
              controller: addressController,
              showCursor: true,
              cursorColor: Colors.black,
              textInputType: TextInputType.name,
              maxLines: 4,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
            ),
            child: Center(
              child: ButtonSubmitWidget(
                onPressed: updateProfile,
                title: "Update Profile",
                bgColor: MyColors.appPrimaryColor,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                borderSide: MyColors.appPrimaryColor,
                loading: isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfile() async {
    try {
      dismissTextFieldFocus();
      _showLoading();

      var res = await auth.updateProfile(
        usernameController?.text,
        hpController?.text,
        emailController?.text,
        addressController?.text,
        photosImage?.image,
      );
      var result = json.decode(res);

      if (result['status'] == true) {
        showSnackBar(
          'Profile Berhasil di Update',
          SnackBarType.succes,
          SUCCESS_IC,
          context,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => TabPageCustomer(
                    tabIndex: 4,
                  )),
          (route) => false,
        );
      }
    } catch (error, stackTrace) {
      _dismissLoading();
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor: Colors.transparent,
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
        'Edit Profile',
        style: TextStyle(
          color: MyColors.appPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }

  void _showLoading() {
    setState(() => isLoading = true);
  }

  void _dismissLoading() {
    setState(() => isLoading = false);
  }

  Future<void> _buildBottomSheetImage() async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true, // makes modal fullscreen
        // backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                      width: 80,
                    ),
                    const Text(
                      'Ganti Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Ambil Foto',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                      ),
                    ),
                    onTap: () {
                      debugPrint('Camera');
                      _openCamera(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: const Icon(
                      Icons.image_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Pilih dari Galeri',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                      ),
                    ),
                    onTap: () {
                      debugPrint('Gallery');
                      _openCamera(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _openCamera(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 90,
      );
      setState(() {
        photosImage = OthersImage(pickedFile?.path);
        debugPrint(photosImage?.image);
      });
    } catch (e) {
      debugPrint('$e');
    }
  }
}
