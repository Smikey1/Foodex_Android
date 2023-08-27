import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/widgets/changeTheme.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'Dark Mode'
        : 'Light Mode';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Theme Screen'),
        actions: const [ChangeThemeButtonWidget()],
      ),
      body: Column(
        children: [
          const Text('Theme Screen', style: TextStyle(fontSize: 30.0)),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: const Center(child: Text('this is karma')),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:foodex_app/app/utils/dimension.dart';

// class PostCart extends StatelessWidget {
//   const PostCart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//           boxShadow: const [
//             BoxShadow(
//               color: Color.fromARGB(255, 201, 200, 200),
//               spreadRadius: 2,
//               blurRadius: 10,
//               offset: Offset(0, 1), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                 height: Dimensions.height45 * 5,
//                 width: Dimensions.height100 * 5,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(
//                         'https://res.cloudinary.com/de9neeomp/image/upload/v1674758167/fodjeans/products/tmp-1-1674758164836.jpg'),
//                   ),
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25)),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Color Canvas',
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(
//                         'Rs.2500',
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
