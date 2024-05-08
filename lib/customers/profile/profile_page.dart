import 'package:bengkelly_apps/bloc/user/user_bloc.dart';
import 'package:bengkelly_apps/credential/login%20page.dart';
import 'package:bengkelly_apps/customers/profile/component/help_center_page.dart';
import 'package:bengkelly_apps/customers/profile/component/setting_vehicle_page.dart';
import 'package:bengkelly_apps/customers/profile/component/settings_page.dart';
import 'package:bengkelly_apps/customers/profile/edit_profile_page.dart';
import 'package:bengkelly_apps/model/user.dart';
import 'package:bengkelly_apps/providers/auth.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:bengkelly_apps/utils/general_function.dart';
import 'package:bengkelly_apps/utils/my_colors.dart';
import 'package:bengkelly_apps/welcome_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../credential/register_page.dart';
import '../../widget/actions_widget.dart';
import '../../widget/button_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserBloc userBloc = UserBloc();

  @override
  void initState() {
    userBloc.add(UserFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor:  MyColors.appPrimaryColor,
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: Colors.transparent,
      title: Text(
        'Profile',
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

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        BlocBuilder(
          bloc: userBloc,
          builder: (context, state) {
            if (state is UserLoaded) {
              return _buildProfile(state.userData.data);
            }
            return buildShimmerProfile(context);
          },
        ),
        _buildMenuProfile(),
        _buildLogOut(context),
      ],
    );
  }

  Widget _buildProfile(Data? data) {
    debugPrint('${data?.gambar}');
    return Container(
      height: 140,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: const Color(0xFFD7E1FE),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFFD7E1FE),
                      child: ClipOval(
                        child: data?.gambar == null
                            ? Image.asset(
                                DUMMY_AVATAR,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${data?.gambar}',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 35),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          data?.nama ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.appPrimaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        top: 8,
                        right: 10,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          "${data?.email}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.appPrimaryColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        top: 8,
                        right: 10,
                      ),
                      child: Text(
                        data?.hp ?? '',
                        style: TextStyle(
                          color: MyColors.appPrimaryColor,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: const EdgeInsets.only(
                top: 25,
                right: 12,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(data: data),
                  ),
                );
              },
              icon: Image.asset(
                EDIT,
                height: 24,
                width: 24,
                color: MyColors.appPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuProfile() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(15),
          tileColor: const Color(0xFFF7F8F9),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFCDD4D3),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Image.asset(
              IC_CAR,
              height: 24,
            ),
          ),
          title: const Text(
            'Atur Kendaraaan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsVehiclePage(),
              ),
            );
          },
        ),
        // ListTile(
        //   contentPadding: const EdgeInsets.all(15),
        //   tileColor: const Color(0xFFF7F8F9),
        //   trailing: const Icon(
        //     Icons.arrow_forward_ios,
        //     color: Color(0xFFCDD4D3),
        //   ),
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 25),
        //     child: Image.asset(
        //       IC_POCKET,
        //       height: 24,
        //     ),
        //   ),
        //   title: const Text(
        //     'Metode Pembayaran',
        //     style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       fontFamily: 'Nunito',
        //     ),
        //   ),
        // ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HelpCenterPage(),
              ),
            );
          },
          contentPadding: const EdgeInsets.all(15),
          tileColor: const Color(0xFFF7F8F9),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFCDD4D3),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset(
              IC_HELP,
              height: 24,
            ),
          ),
          title: const Text(
            'Pusat Bantuan  ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ),
            );
          },
          contentPadding: const EdgeInsets.all(15),
          tileColor: const Color(0xFFF7F8F9),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFCDD4D3),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset(
              IC_SETTINGS,
              height: 24,
            ),
          ),
          title: const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogOut(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListTile(
        onTap: () async {
          Dialog(
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterLogo(size: 150,),
                  Text("This is a Custom Dialog",style:TextStyle(fontSize: 20),),
                  ElevatedButton(

                      onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text("Close"))
                ],
              ),
            ),
          );
          showDialog(context: context, builder: (context) =>    Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(30),
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Text("Continue To Logout?",style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
              Text("Are you sure to logout from this device?",style:TextStyle(fontSize: 17),),
                ],),
                  SizedBox(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonSubmitWidget1(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        title: "No, cancel",
                        bgColor: Colors.white,
                        textColor: MyColors.appPrimaryColor,
                        fontWeight: FontWeight.normal,
                        width: 70,
                        height: 50,
                        borderSide: Colors.transparent,
                      ),
                      SizedBox(height: 20,),
                      ButtonSubmitWidget2(
                        onPressed: () async {
                          await auth.forceSignOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WelcomeLogin2()));
                        },
                        title: "Yes, Continue",
                        bgColor: MyColors.appPrimaryColor,
                        textColor: Colors.white,
                        fontWeight: FontWeight.normal,
                        width: 100,
                        height: 50,
                        borderSide: Colors.transparent,
                      ),

                  ],),
                ],
              ),
            ),
          ),);
          return;
        },
        contentPadding: const EdgeInsets.all(24),
        tileColor: const Color(0xFFF7F8F9),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFCDD4D3),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Image.asset(
            IC_LOGOUT,
            height: 24,
          ),
        ),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
