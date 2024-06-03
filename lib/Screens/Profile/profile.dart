import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vietmap_map/Screens/Profile/userManager.dart';
import 'package:vietmap_map/Screens/auth/SignIn.dart';
import 'package:vietmap_map/Screens/auth/firebase_service/database_service.dart';
import 'package:vietmap_map/Screens/auth/firebase_service/getX/getX.dart';
import 'package:vietmap_map/Screens/home.dart';

import '../../data/models/user.dart';
import '../auth/firebase_service/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _AccountPageState();
}

class _AccountPageState extends State<ProfilePage> {
  // final UserDataController userDataController = Get.put(UserDataController());

  late bool obsCurrentText = true;
  late bool obsCurrentTextOldPassword = true;
  late bool obsCurrentTextNewPassword = true;
  late bool statusEditProfile = true;
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerOldPassword =
      TextEditingController();
  TextEditingController textEditingControllerNewPassword =
      TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  final DatabaseService _databaseUserService = DatabaseService('db_user');

  final RoleController roleController = Get.put(RoleController());
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(SignIn()); // Điều hướng về trang đăng nhập sau khi đăng xuất
  }

  @override
  Widget build(BuildContext context) {
    // print(roleController.role.value);
    return GestureDetector(
      onTap: () => AuthService().hideKeyBoard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text(
              "My profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          actions: [
            IconButton(onPressed: _signOut, icon: Icon(Icons.logout)),
          ],
        ),
        body: StreamBuilder(
          stream: _databaseUserService.getFind('email', "${user!.email}"),
          // stream: _databaseUserService.getFind('email',"manager@gmail.com"),
          builder: (context, snapshot) {
            final doc = snapshot.data?.docs.first;
            return SizedBox(
              height: context.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: statusEditProfile
                    ? Column(
                        children: [
                          costomTextField(
                              "Full Name",
                              "${doc?["displayName"]}",
                              textEditingControllerName,
                              Icons.account_circle_outlined,
                              statusEditProfile),
                          costomTextField(
                              "E-mail",
                              "${doc?["email"]}",
                              textEditingControllerName,
                              Icons.email_outlined,
                              statusEditProfile),
                          costomTextField(
                              "role",
                              "${doc?["role"]}",
                              textEditingControllerName,
                              Icons.person,
                              statusEditProfile),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: "${doc?["password"]}"),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obsCurrentText,
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                labelStyle: const TextStyle(color: Colors.blue),
                                alignLabelWithHint: true,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obsCurrentText = !obsCurrentText;
                                    });
                                  },
                                  child: Icon(obsCurrentText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                statusEditProfile = !statusEditProfile;
                              });
                            },
                            child: Container(
                              height: context.height * 0.06,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserManagementPage(),
                                ),
                              );
                            },
                            child: Container(
                              height: context.height * 0.06,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Text(
                                "Manager User",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const Text(
                            "My Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: TextFormField(
                              controller: textEditingControllerName,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                label: Text("User Name"),
                                hintText: "Enter User Name",
                                labelStyle: TextStyle(color: Colors.blue),
                                alignLabelWithHint: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: TextFormField(
                              controller: textEditingControllerOldPassword,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obsCurrentTextOldPassword,
                              decoration: InputDecoration(
                                label: const Text("Old Password"),
                                hintText: "Enter Old password",
                                labelStyle: const TextStyle(color: Colors.blue),
                                alignLabelWithHint: true,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obsCurrentTextOldPassword =
                                          !obsCurrentTextOldPassword;
                                    });
                                  },
                                  child: Icon(obsCurrentTextOldPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: TextFormField(
                              controller: textEditingControllerNewPassword,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obsCurrentTextNewPassword,
                              decoration: InputDecoration(
                                label: const Text("New Password"),
                                hintText: "Enter New password",
                                labelStyle: const TextStyle(color: Colors.blue),
                                alignLabelWithHint: true,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obsCurrentTextNewPassword =
                                          !obsCurrentTextNewPassword;
                                    });
                                  },
                                  child: Icon(obsCurrentTextNewPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await AuthService().changePassword(
                                email: "${doc?['email']}",
                                oldPassword:
                                    textEditingControllerOldPassword.text,
                                newPassword:
                                    textEditingControllerNewPassword.text,
                              );
                              setState(() {
                                statusEditProfile = !statusEditProfile;
                              });
                              UserData userData = UserData(
                                  displayName:
                                      textEditingControllerName.text == ''
                                          ? doc!['displayName']
                                          : textEditingControllerName.text,
                                  email: doc?['email'],
                                  password:
                                      textEditingControllerNewPassword.text,
                                  role: doc?['role']);
                              Fluttertoast.showToast(msg: "Success");
                              Get.offAll(const HomePage());
                              _databaseUserService.updateUserData(
                                  doc!.id, userData);
                              textEditingControllerName.clear();
                              textEditingControllerOldPassword.clear();
                              textEditingControllerNewPassword.clear();
                            },
                            child: Container(
                              height: context.height * 0.06,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding costomTextField(String title, String description,
      TextEditingController controller, IconData icon, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextField(
        controller:
            status ? TextEditingController(text: description) : controller,
        readOnly: status ? true : false,
        decoration: InputDecoration(
            label: Text(title),
            hintText: status ? "" : "Previous name: $description",
            labelStyle: const TextStyle(color: Colors.blue),
            alignLabelWithHint: true,
            prefixIcon: Icon(
              icon,
              color: Colors.blue,
              size: 30,
            ),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
