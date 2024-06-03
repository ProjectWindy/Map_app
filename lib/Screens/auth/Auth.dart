import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vietmap_map/Screens/auth/SignIn.dart';
import 'package:vietmap_map/Screens/auth/firebase_service/auth_service.dart';
import 'package:vietmap_map/Screens/auth/signUp.dart';
import 'package:vietmap_map/Screens/home.dart';
import 'package:vietmap_map/features/map_screen/maps_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF2B85),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/z5498055623606_196a0e8d1bf13823eb7a17bf90d19f84-removebg-preview.png',
                    height: 300,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Sign up or Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            Text(
                              'Lựa chọn phương thức đăng nhập',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => SignIn())));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 58,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE21A70)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/4043232_avatar_batman_comics_hero_icon-removebg-preview.png',
                                width: 25,
                              ),
                              Text(
                                'Continue with Account',
                                style: TextStyle(
                                    color: Color(0xFFE21A70),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.red[300],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'or',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red[400]),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.red[300],
                          ))
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const SignUp()));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 58,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE21A70)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/4043232_avatar_batman_comics_hero_icon-removebg-preview.png',
                                width: 25,
                              ),
                              Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Color(0xFFE21A70),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
