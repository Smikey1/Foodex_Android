// import 'package:local_auth/local_auth.dart';

// class LocalAuth {
//   static final _auth = LocalAuthentication();

//   static Future<bool> _canAuthenticate() async =>
//       await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

//   static Future<bool> authenticate() async {
//     try {
//       if (!await _canAuthenticate()) return false;

//       return await _auth.authenticate(
//         authMessages: [
//           AndroidAuthMessages(
//             signInTitle: "Sign in",
//             cancelButton: "No Thanks",
//           ),
//           IOSAuthMessages(
//             cancelButton: "No Thanks",
//           ),
//         ],
//         localizedReason: "Please authenticate to access your account",
//       );
//     } catch (e) {
//       return false;
//     }
//   }
// }
