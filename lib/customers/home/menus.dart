import 'package:bengkelly_apps/customers/emergency_service/emergency_service_page.dart';
import 'package:bengkelly_apps/customers/home/all_menus.dart';
import 'package:bengkelly_apps/model/master_data.dart';
import 'package:bengkelly_apps/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../booking/component/bottom_sheet_location.dart';
import '../booking/component/bottom_sheet_location_test.dart';
import '../xroot/tabPageCustomer.dart';

class UserMenus {
  var uuid = const Uuid();

  _goEmergencyServices(context) {
    debugPrint('_goEmergencyServices');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmergencyServicePage(),
      ),
    );
  }

  _goBookingServices(context) {
    debugPrint('_goBookingServices');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TabPageCustomer(
          tabIndex: 2,
        ),
      ),
    );
  }

  _goRepairAndMaintenance(context) {
    debugPrint('_goRepairAndMaintenance');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TabPageCustomer(
          tabIndex: 2,
        ),
      ),
    );
  }
  _goRepairAndMaintenanfce(context) async {
    debugPrint('_goRepairAndMaintenance');
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomSheetLocationtest(onSelected: (String locationRestArea, int? idLocations) {  },),
        ),
      );
      //
  }

  _goAllMenus(context) {
    debugPrint('_goAllMenus');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllMenus(),
      ),
    );
  }

  List<MasterData> buildAllMenu(BuildContext context, {bool? isAllMenus}) {
    List<MasterData> masterDataList = [];

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: IC_EMERGENCY,
        color: Colors.blue,
        title: "Emergency Service",
        emergency: true,
        onTap: () => _goEmergencyServices(context),
      ),
    );

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: BOOKING_SERVICE,
        color: Colors.blue,
        title: "Booking Service",
        onTap: () => _goBookingServices(context),
      ),
    );

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: IC_REPAIR,
        color: Colors.blue,
        title: "Repair & Maintenance",
        onTap: () => _goRepairAndMaintenance(context),
      ),
    );

    return masterDataList;
  }

  List<MasterData> buildMenu(BuildContext context, {bool? isAllMenus}) {
    List<MasterData> masterDataList = [];

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: IC_EMERGENCY,
        color: Colors.blue,
        title: "Emergency Service",
        emergency: true,
        onTap: () => _goEmergencyServices(context),
      ),
    );

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: BOOKING_SERVICE,
        color: Colors.blue,
        title: "Booking Service",
        onTap: () => _goBookingServices(context),
      ),
    );

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: IC_REPAIR,
        color: Colors.blue,
        title: "Repair & Maintenance",
        onTap: () => _goRepairAndMaintenance(context),
      ),
    );

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: DROP_PIN,
        color: Colors.blue,
        title: "Lokasi Bengkelly",
        onTap: () => _goRepairAndMaintenanfce(context),
      ),
    );

    masterDataList.add(
      MasterData(
        id: uuid.v4(),
        icon: Icons.note,
        image: ALL,
        color: Colors.blue,
        title: "Lihat Semua",
        onTap: () => _goAllMenus(
          context,
        ),
      ),
    );

    return masterDataList;
  }
}
