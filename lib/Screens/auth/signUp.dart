import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vietmap_map/Screens/auth/SignIn.dart';
import 'package:vietmap_map/Screens/auth/firebase_service/auth_service.dart';
import 'package:vietmap_map/data/models/user.dart';

import 'firebase_service/database_service.dart';
import 'firebase_service/getX/getX.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userVerifyPasswordController =
      TextEditingController();

  final DatabaseService _databaseService = DatabaseService('db_user');

  RoleController _roleController = Get.put(RoleController());

  bool obscurrentText = true;
  bool obscurrentTextVerify = true;
  bool isSigningUp = false;
  String validEmail = "";
  String validPassword = "";

  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userVerifyPasswordController.dispose();
    super.dispose();
  }

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
                                ' Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              const Text(
                                'Phương thức đăng ký',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        width: context.width * 0.85,
                                        child: TextFormField(
                                          validator: (value) =>
                                              value == null || value.isEmpty
                                                  ? 'Please enter username.'
                                                  : null,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _userNameController,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.person,
                                              size: 30,
                                            ),
                                            hintText: "Enter UserName",
                                            labelText: "UserName",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        width: context.width * 0.85,
                                        child: TextFormField(
                                          validator: (value) => EmailValidator
                                                  .validate(value!)
                                              ?
                                              // (validEmail?null:"Email already exists. Please use another email.")
                                              (validEmail ==
                                                      "The email address is already in use by another account."
                                                  ? validEmail
                                                  : null)
                                              : "Please enter a valid email",
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _userEmailController,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              size: 30,
                                            ),
                                            hintText: "Enter E-mail",
                                            labelText: "E-mail",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        width: context.width * 0.85,
                                        child: TextFormField(
                                          validator: (value) => (value!
                                                          .length >=
                                                      8 &&
                                                  value!.length <= 24)
                                              ? (validPassword ==
                                                      "The password provided is too weak"
                                                  ? validPassword
                                                  : null)
                                              : "Enter a password greater than 8 and less than 24",
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _userPasswordController,
                                          obscureText: obscurrentText,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
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
                                                  : Icons.visibility_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        width: context.width * 0.85,
                                        child: TextFormField(
                                          validator: (value) =>
                                              _userPasswordController.text ==
                                                      value
                                                  ? null
                                                  : "Please check your password again",
                                          keyboardType: TextInputType.text,
                                          controller:
                                              _userVerifyPasswordController,
                                          obscureText: obscurrentTextVerify,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.security,
                                              size: 30,
                                            ),
                                            hintText: "Enter Verify Password",
                                            labelText: "VerifyPassword",
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  obscurrentTextVerify =
                                                      !obscurrentTextVerify;
                                                });
                                              },
                                              child: Icon(obscurrentTextVerify
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  final message =
                                      await AuthService().registration(
                                    email: _userEmailController.text,
                                    password: _userPasswordController.text,
                                  );
                                  print('$message------------------');
                                  if (validEmail ==
                                      'The email is already in use by another account.') {
                                    setState(() {
                                      validEmail = '';
                                    });
                                  }
                                  setState(() {
                                    validPassword = message!;
                                    validEmail = message;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    if (message!.contains(
                                            "The account already exists for that email.") ||
                                        message.contains(
                                            "The password provided is too weak.")) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                        ),
                                      );
                                    } else if (message.contains('Success')) {
                                      Get.offAll(const SignIn());
                                      UserData user = UserData(
                                        displayName: _userNameController.text,
                                        email: _userEmailController.text,
                                        password: _userPasswordController.text,
                                        role: "staff",
                                      );
                                      _databaseService.adUserData(user);
                                      Fluttertoast.showToast(msg: "Success");
                                    }
                                  }
                                },
                                child: Container(
                                  height: context.height * 0.06,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 35),
                                  decoration: BoxDecoration(
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
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Register Account',
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
                                    const Text("You  have an account!",
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
                                                    const SignIn(),
                                              ));
                                        },
                                        child: const Text("Login Now.",
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
                                builder: (context) => const SignIn()));
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
                              'Sign In',
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
