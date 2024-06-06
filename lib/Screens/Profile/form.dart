import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import '../auth/firebase_service/database_service.dart';

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  _Form1State createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  TextEditingController roleController = TextEditingController(text: 'staff');

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    roleController.dispose();
    super.dispose();
  }

  Widget buildTextField(
      String label, TextEditingController controller, bool show, bool seen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.verified_outlined,
                color: Colors.black,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  readOnly: seen,
                  obscureText: show,
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: label,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addUser() async {
    DatabaseMethods databaseMethods = DatabaseMethods();

    // Lấy giá trị văn bản từ các TextEditingController
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String role = 'staff';

    // Kiểm tra giá trị đầu vào không null hoặc trống
    if (name.isEmpty || email.isEmpty || password.isEmpty || role.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập đầy đủ thông tin");
      return;
    }
    String Id = randomAlphaNumeric(10);

    Map<String, dynamic> userinforMap = {
      "displayName": name,
      "email": email,
      "password": password,
      "Id": Id,
      "role": role,
    };

    try {
      await databaseMethods.addUser(userinforMap);
      Fluttertoast.showToast(msg: "Thêm thành công");
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error adding user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Name', nameController, false, false),
              SizedBox(height: 10.0),
              buildTextField('Email', emailController, false, false),
              SizedBox(height: 10.0),
              buildTextField('Password', passwordController, true, false),
              SizedBox(height: 10.0),
              buildTextField('Role', roleController, false, true),
              SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(alignment: Alignment.center),
                  onPressed: addUser,
                  child: Text(
                    'Add User',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
