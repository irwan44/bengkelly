import 'package:bengkelly_apps/model/master_data.dart';
import 'package:flutter/material.dart';

class GridMenuWidget extends StatelessWidget {
  final List<MasterData> listMenu;
  final Function onMenuTap;

  const GridMenuWidget({
    Key? key,
    required this.listMenu,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(
        left: 1,
        right: 1,
      ),
      alignment: Alignment.center,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: listMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 4,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          mainAxisExtent: 100,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _rowMasterData(listMenu[index]);
        },
      ),
    );
  }

  Widget _rowMasterData(MasterData master) {
    return InkWell(
      onTap: () => onMenuTap(master.onTap),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(0),
            child: master.image != null
                ? Image.asset(
                    master.image ?? '',
                    fit: BoxFit.cover,
                    width: 55,
                    height: 55,
                    // color: Colors.black,
                  )
                : Icon(
                    master.icon,
                    color: master.color,
                    size: 36,
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            master.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              // color: Colors.black87,
              fontWeight:
                  master.emergency ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Nunito',
              color: master.emergency
                  ? const Color(0xFFC93131)
                  : const Color(0xFF1F2340),
            ),
          ),
        ],
      ),
    );
  }
}
