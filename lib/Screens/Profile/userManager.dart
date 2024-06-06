import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vietmap_map/Screens/Profile/form.dart';
import 'package:vietmap_map/Screens/search/profilecontroller.dart';
import 'package:vietmap_map/Screens/search/search_user.dart';

import '../auth/firebase_service/database_service.dart';

class UserManagementPage extends StatefulWidget {
  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  // final TextEditingController roleController = new TextEditingController();

  Stream? userStream;
  String? selectedRole;

  getontheLoad() async {
    userStream = await DatabaseMethods().getUserdetails();
    setState(() {}); // Update the state to refresh the UI
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getontheLoad();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getontheLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Form1()));
        },
        child: GestureDetector(child: Icon(Icons.add)),
      ),
      appBar: AppBar(
        title: Row(
          children: [Text('Manager Users')],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [Expanded(child: allUserDetails())],
        ),
      ),
    );
  }

  Widget allUserDetails() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          // Kiểm tra dữ liệu có và không rỗng
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name: ' + ds['displayName'],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  nameController.text = ds['displayName'];
                                  emailController.text = ds['email'];
                                  passwordController.text = ds['password'];
                                  selectedRole = ds[
                                      'role']; // Gán giá trị role cho selectedRole

                                  EditUser(ds['displayName'], context);
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool confirm = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Xác nhận xóa người dùng?'),
                                      content: Text(
                                          'Bạn có chắc muốn xóa người dùng này không?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text('Hủy'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text('Xóa'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true) {
                                    await DatabaseMethods()
                                        .deleteNoteByEmail(ds['email']);
                                    getontheLoad();
                                    print(ds['email']);
                                  }
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Email: ' + ds['email'],
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Role: ' + ds['role'],
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // Trả về container trống nếu không có dữ liệu
          return Container();
        }
      },
    );
  }

  Future EditUser(String id, context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              content: Container(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel)),
                          SizedBox(
                            width: 60.0,
                          ),
                          const Text(
                            'Edit ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Details: ',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      buildTextField('Name', nameController, false),
                      SizedBox(height: 10.0),
                      buildTextField('Password', passwordController, true),
                      SizedBox(height: 10.0),
                      Text(
                        'Role',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        children: [
                          if (selectedRole == null ||
                              selectedRole == 'staff') // Show Staff option

                            RadioListTile<String>(
                              title: const Text('Staff'),
                              value: 'staff',
                              groupValue: selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value;
                                });
                              },
                            ),
                          if (selectedRole == null ||
                              selectedRole == 'manager') // Show Manager option

                            RadioListTile<String>(
                              title: const Text('Manager'),
                              value: 'manager',
                              groupValue: selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value;
                                });
                              },
                            ),
                          // Conditional content based on the selected role
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> updateinfo = {
                              'displayName': nameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                              'role': selectedRole,
                            };

                            await DatabaseMethods()
                                .updateUser(emailController.text, updateinfo)
                                .then((value) {
                              Fluttertoast.showToast(
                                msg: "Update thành công!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Update'),
                        ),
                      )
                    ]),
              ),
            ),
          )));
}

Widget buildTextField(
  String label,
  TextEditingController controller,
  bool show,
) {
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
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          obscureText: show,
          controller: controller,
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    ],
  );
}
