// import 'package:flutter/material.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     Key? key,
//     this.height,
//     this.leadingWidth,
//     this.leading,
//     this.title,
//     this.centerTitle,
//     this.actions,
//     required this.context,
//   }) : super(
//     key: key,
//   );
//
//   final double? height;
//
//   final double? leadingWidth;
//
//   final Widget? leading;
//
//   final Widget? title;
//
//   final bool? centerTitle;
//
//   final List<Widget>? actions;
//
//   final BuildContext context;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       toolbarHeight: height ?? 56,
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,
//       leadingWidth: leadingWidth ?? 0,
//       leading: leading,
//       title: title,
//       titleSpacing: 0,
//       centerTitle: centerTitle ?? false,
//       actions: actions,
//     );
//   }
//
//   @override
//   Size get preferredSize => Size(
//     MediaQuery.of(context).size.width,
//     height ?? 56,
//   );
// }