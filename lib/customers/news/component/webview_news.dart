// import 'package:bengkelly_apps/utils/my_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewNewsPage extends StatefulWidget {
//   final String? url;
//
//   const WebViewNewsPage({super.key, this.url});
//
//   @override
//   State<WebViewNewsPage> createState() => _WebViewNewsPageState();
// }
//
// class _WebViewNewsPageState extends State<WebViewNewsPage> {
//   bool isLoading = true;
//   WebViewController webViewController = WebViewController();
//
//   @override
//   void initState() {
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {},
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {},
//           // onNavigationRequest: (NavigationRequest request) {
//           //   if (request.url.startsWith('https://www.youtube.com/')) {
//           //     return NavigationDecision.prevent;
//           //   }
//           //   return NavigationDecision.navigate;
//           // },
//         ),
//       )
//       ..loadRequest(
//         Uri.parse(widget.url ?? ''),
//       );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     webViewController.clearCache();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: SafeArea(
//         child: _buildBody(),
//       ),
//     );
//   }
//
//   Widget _buildBody() {
//     return Stack(
//       children: [
//         WebViewWidget(
//           controller: webViewController,
//         ),
//         isLoading
//             ? Center(
//                 child: CircularProgressIndicator(
//                   color: MyColors.appPrimaryColor,
//                 ),
//               )
//             : Stack()
//       ],
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       elevation: 0,
//       actionsIconTheme: const IconThemeData(size: 20),
//       backgroundColor: Colors.transparent,
//       title: Text(
//         'News',
//         style: TextStyle(
//           color: MyColors.appPrimaryColor,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Nunito',
//         ),
//       ),
//       leading: Container(
//         margin: const EdgeInsets.fromLTRB(15, 7, 0, 7),
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
