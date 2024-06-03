import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vietmap_map/Screens/auth/firebase_service/auth_service.dart';
import 'package:vietmap_map/Screens/auth/signUp.dart';
import 'package:vietmap_map/Screens/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'firebase_service/getX/getX.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late bool obscurrentText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String validPassword = "";
  RoleController roleController = Get.put(RoleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF2B85),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Text(
                                ' Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              const Text(
                                'Phương thức đăng nhập',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: TextFormField(
                                          validator: (value) => EmailValidator
                                                  .validate(value!)
                                              ? null
                                              : "Please enter a valid email",
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.email_rounded,
                                              size: 30,
                                            ),
                                            hintText: " E-mail",
                                            labelText: "E-mail",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: TextFormField(
                                            validator: (value) =>
                                                validPassword == ""
                                                    ? null
                                                    : "Wong Password",
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            obscureText: obscurrentText,
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: const OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                                size: 30,
                                              ),
                                              hintText: "Enter Password",
                                              labelText: "Password",
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    obscurrentText =
                                                        !obscurrentText;
                                                  });
                                                },
                                                child: Icon(obscurrentText
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons
                                                        .visibility_outlined),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    validPassword = '';
                                  });
                                  if (_formkey.currentState!.validate()) {
                                    final userDoc = await FirebaseFirestore
                                        .instance
                                        .collection('db_user')
                                        .where("email",
                                            isEqualTo: _emailController.text)
                                        .get();
                                    roleController
                                        .setRole(userDoc.docs.first['role']);
                                    roleController.setName(
                                        userDoc.docs.first['displayName']);
                                    final message = await AuthService().login(
                                      email: _emailController.text,
                                      password: _passwordController.text.trim(),
                                    );
                                    if (message!.contains('Success')) {
                                      Get.offAll(const HomePage());
                                      // navigateToScreen(userDoc.docs.first['role']);
                                      Fluttertoast.showToast(msg: "Success");
                                    }
                                    setState(() {
                                      validPassword = message;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(message),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: context.height * 0.06,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 35),
                                  decoration: BoxDecoration(
                                    // color: Color(0xFF00B6F0),
                                    color: Color(0xFFE21A70),

                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5),
                                          offset: const Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Sign In',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        color: Color(0xFFffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("You don't have an account?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 15)),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUp(),
                                              ));
                                        },
                                        child: const Text("Create account.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                                fontSize: 15)))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.red[300],
                          ),
                        ),
                        const SizedBox(
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE21A70)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/4043232_avatar_batman_comics_hero_icon-removebg-preview.png',
                              width: 25,
                            ),
                            const Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Color(0xFFE21A70),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
