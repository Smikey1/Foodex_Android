// import 'package:flutter/material.dart';
// import 'package:foodex_app/sensor/finger_sensor/finger_sensor.dart';

// class FingerScreen extends StatefulWidget {
//   const FingerScreen({super.key});

//   @override
//   State<FingerScreen> createState() => _FingerScreenState();
// }

// class _FingerScreenState extends State<FingerScreen> {
//   bool authenticated = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Finger Sensor'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const Text('Finger Sensor'),
//             ElevatedButton(onPressed: () async {
//               final authenticate = await LocalAuth.authenticate();
//               setState(() {
//                 authenticated = true;
//               });
//             }, child: const Text("Verify"))
//           ],
//         ),
//       ),
//     );
//   }
// }
