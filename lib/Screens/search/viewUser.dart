// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vietmap_map/Screens/search/profilecontroller.dart';
// import 'package:vietmap_map/Screens/search/search_user.dart';
// import 'package:vietmap_map/firebase_service/database_service.dart';

// class UserManagementPage extends StatefulWidget {
//   @override
//   State<UserManagementPage> createState() => _UserManagementPageState();
// }

// class _UserManagementPageState extends State<UserManagementPage> {
//   final TextEditingController nameController = new TextEditingController();
//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//   final TextEditingController roleController = new TextEditingController();

//   Stream? userStream;

//   getontheLoad() async {
//     userStream = await DatabaseMethods().getUserdetails();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     getontheLoad();
//     super.initState();
//   }

//   Widget allUserDetails() {
//     return StreamBuilder(
//       stream: userStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
//           // Kiểm tra dữ liệu có và không rỗng
//           return ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot ds = snapshot.data.docs[index];
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 20.0),
//                 child: Material(
//                   elevation: 5.0,
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Name: ' + ds['displayName'],
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   nameController.text = ds['displayName'];
//                                   emailController.text = ds['email'];
//                                   passwordController.text = ds['password'];
//                                   roleController.text = ds['role'];

//                                   EditUser(ds['displayName'], context);
//                                 },
//                                 child: Icon(
//                                   Icons.edit,
//                                   color: Colors.orange,
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Email: ' + ds['email'],
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Password: ' + ds['password'],
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Role: ' + ds['role'],
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           // Trả về container trống nếu không có dữ liệu
//           return Container();
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => Form1()));
//         },
//         child: GestureDetector(child: Icon(Icons.add)),
//       ),
//       appBar: AppBar(
//         title: Row(
//           children: [Text('Manager Users')],
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
//         child: Column(
//           children: [Expanded(child: allUserDetails())],
//         ),
//       ),
//     );
//   }

//   Future EditUser(String id, context) => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//               content: Container(
//             child: Container(
//               child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Icon(Icons.cancel)),
//                           SizedBox(
//                             width: 60.0,
//                           ),
//                           const Text(
//                             'Edit ',
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Text(
//                             'Details: ',
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       buildTextField('Name', nameController),
//                       SizedBox(height: 10.0),
//                       buildTextField('Email', emailController),
//                       SizedBox(height: 10.0),
//                       buildTextField('Password', passwordController),
//                       SizedBox(height: 10.0),
//                       buildTextField('Role', roleController),
//                       SizedBox(height: 30.0),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             Map<String, dynamic> updateinfo = {
//                               'displayName  ': nameController.text,
//                               'email': emailController.text,
//                               'password': passwordController.text,
//                               'role': roleController.text,
//                               'Id': id,
//                             };

//                             await DatabaseMethods()
//                                 .updateUser(id, updateinfo)
//                                 .then((value) => {Navigator.pop(context)});
//                           },
//                           child: Text('Update'),
//                         ),
//                       )
//                     ]),
//               ),
//             ),
//           )));
// }

// Widget buildTextField(String label, TextEditingController controller) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 24.0,
//         ),
//       ),
//       SizedBox(height: 10.0),
//       Container(
//         padding: EdgeInsets.only(left: 10.0),
//         decoration: BoxDecoration(
//           border: Border.all(),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: TextField(
//           controller: controller,
//           decoration: InputDecoration(border: InputBorder.none),
//         ),
//       ),
//     ],
//   );
// }
