import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vietmap_map/Screens/auth/Locationacess.dart';

// Màn hình Splash
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Locationacess(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF2B85),
      body: Center(
        child: Image.asset(
          'assets/images/z5498055623606_196a0e8d1bf13823eb7a17bf90d19f84-removebg-preview.png',
          scale: 3,
        ),
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFF2B85),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(15),
//                     child: Icon(
//                       Icons.back_hand,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Image.asset(
//                     '',
//                     height: 300,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: Column(
//                           children: [
//                             Text(
//                               'Sign up or Log in',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w700, fontSize: 20),
//                             ),
//                             Text(
//                               'Lựa chọn phương thức đăng nhập',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           width: double.infinity,
//                           height: 58,
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
