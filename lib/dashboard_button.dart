// import 'dart:async';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:foodex_app/app/theme/constants.dart';
// import 'package:foodex_app/app/utils/dimension.dart';
// import 'package:foodex_app/screen/export_screen.dart';
// import 'package:foodex_app/widgets/snack_bar.dart';
// import 'package:proximity_sensor/proximity_sensor.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DashboardButtonScreen extends StatefulWidget {
//   const DashboardButtonScreen({super.key});

//   @override
//   State<DashboardButtonScreen> createState() => _DashboardButtonScreenState();
// }

// class _DashboardButtonScreenState extends State<DashboardButtonScreen> {
//   bool _isNear = false;
//   late StreamSubscription<dynamic> _streamSubscription;

//   @override
//   void initState() {
//     listenSensor();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _streamSubscription.cancel();
//   }

//   Future<void> listenSensor() async {
//     _streamSubscription = ProximitySensor.events.listen((int event) {
//       setState(() {
//         _isNear = (event > 0) ? true : false;
//         print("IS NEAR -->$_isNear");
//       });
//       if (_isNear == true) {
//         // show logout alert dialog
//         showAlertDialog(context);
//       }
//     });
//   }

//   var currentIndex = 0;
//   List<Widget> lstBottomScreen = [
//     const HomeScreen(),
//     const OrderScreen(),
//     const ChatScreen(),
//     const ProfileScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     // double screenHeight = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: lstBottomScreen[currentIndex],
//       bottomNavigationBar: Container(
//         margin: EdgeInsets.only(
//             left: Dimensions.height20,
//             right: Dimensions.height20,
//             bottom: Dimensions.height20,
//             top: Dimensions.height5),
//         height: Dimensions.height65,
//         decoration: BoxDecoration(
//           color: AppColor.kPrimaryColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.15),
//               blurRadius: 30,
//               offset: const Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(Dimensions.height45),
//         ),
//         child: ListView.builder(
//           itemCount: 4,
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.symmetric(horizontal: Dimensions.height25),
//           itemBuilder: (context, index) => InkWell(
//             onTap: () {
//               setState(() {
//                 currentIndex = index;
//                 HapticFeedback.lightImpact();
//               });
//             },
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             child: Stack(
//               children: [
//                 // Text("Text Value:-->$_isNear"),
//                 SizedBox(
//                   width: Dimensions.width81,
//                   child: Center(
//                     child: AnimatedContainer(
//                       duration: const Duration(seconds: 1),
//                       curve: Curves.fastLinearToSlowEaseIn,
//                       height: index == currentIndex ? Dimensions.height50 : 0,
//                       width: index == currentIndex ? Dimensions.width75 : 0,
//                       decoration: BoxDecoration(
//                         color: index == currentIndex
//                             ? AppColor.kSecondaryColor
//                             : Colors.transparent,
//                         borderRadius:
//                             BorderRadius.circular(Dimensions.height50),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: Dimensions.width85,
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.only(
//                       left: Dimensions.width2, right: Dimensions.width2),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(
//                       listOfIcons[index],
//                       size: Dimensions.iconSize27,
//                       color:
//                           index == currentIndex ? Colors.white : Colors.black26,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<IconData> listOfIcons = [
//     Icons.home_rounded,
//     Icons.shopping_cart_checkout_rounded,
//     Icons.chat_sharp,
//     Icons.person_rounded,
//   ];

//   void showAlertDialog(BuildContext context) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.WARNING,
//       animType: AnimType.TOPSLIDE,
//       showCloseIcon: true,
//       title: "Log Out",
//       desc: "Are you sure you want to log out?",
//       // autoHide: const Duration(seconds: 3),
//       btnCancelOnPress: () {},
//       btnOkOnPress: () async {
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         showSnackbar(context, "Logout Successfully!", Colors.orange);
//         pref.clear();
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (_) => const LoginScreen(),
//           ),
//         );
//       },
//     ).show();
//   }
// }
