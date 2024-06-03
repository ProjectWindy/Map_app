import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/user.dart';

class DatabaseService {
  final _fierstore = FirebaseFirestore.instance;
  late final CollectionReference _vocabularyRef;
  DatabaseService(String VOCABULARY_COLLECTION_REF) {
    _vocabularyRef = _fierstore
        .collection(VOCABULARY_COLLECTION_REF)
        .withConverter<UserData>(
            fromFirestore: (snapshots, _) => UserData.formJson(
                  snapshots.data()?.cast<String, Object>(),
                ),
            toFirestore: (flashcard, _) => flashcard.toJson());
  }
  // Lấy danh sách các flashcards
  Stream<QuerySnapshot> getFlashcards() {
    return _vocabularyRef.snapshots();
  }

  // Thêm flashcard mới
  Future<void> addFlashcard(UserData UserData) async {
    try {
      await _vocabularyRef.add(UserData);
      print('Flashcard added successfully!');
    } catch (error) {
      print('Error adding flashcard: $error');
    }
  }

  // Cập nhật flashcard
  Future<void> updateFlashcard(String flashcardId, UserData flashcard) async {
    try {
      await _vocabularyRef.doc(flashcardId).update(flashcard.toJson());
      print('Flashcard updated successfully!');
    } catch (error) {
      print('Error updating flashcard: $error');
    }
  }

  // Xóa flashcard
  Future<void> deleteFlashcard(String flashcardId) async {
    try {
      await _vocabularyRef.doc(flashcardId).delete();
      print('Flashcard deleted successfully!');
    } catch (error) {
      print('Error deleting flashcard: $error');
    }
  }

  Stream<QuerySnapshot> getUsers() {
    return _vocabularyRef.snapshots();
  }

  Stream<QuerySnapshot> getFind(String nameColumn, String searchName) {
    return _vocabularyRef.where(nameColumn, isEqualTo: searchName).snapshots();
  }

  Future<void> updateUserData(String vocabularyId, UserData userData) async {
    try {
      await _vocabularyRef.doc(vocabularyId).update(userData.toJson());
      print('Task updated successfully!'); // Informative success message
    } catch (error) {
      print('Error updating task: $error'); // Log the error for debugging
    }
  }

  Future<void> adUserData(UserData userData) async {
    try {
      await _vocabularyRef.add(userData);
      print('Task added successfully!'); // Informative success message
    } catch (error) {
      print('Error adding task: $error'); // Log the error for debugging
    }
  }

  Future<void> deleteUserData(String userDataId) async {
    try {
      await _vocabularyRef.doc(userDataId).delete();
      print('Task deleted successfully!'); // Informative success message
    } catch (error) {
      print('Error deleting task : $error'); // Log the error for debugging
    }
  }
}

// class DatabaseProjectService {
//   final _firestore = FirebaseFirestore.instance;
//   late final CollectionReference<Class> _tasksRef;

//   DatabaseProjectService(String TASK_COLLECTION_REF) {
//     _tasksRef = _firestore.collection(TASK_COLLECTION_REF).withConverter<Class>(
//           fromFirestore: (snapshots, _) => Class.fromJson(
//             // snapshots.data() lấy dữ liệu từ Firestore.
// // cast<String, Object>() chuyển đổi dữ liệu thành một bản đồ (map) với các khóa là String và các giá trị là Object.

//             snapshots.data()!.cast<String, Object>(),
//           ),
//           // toFirestore: Chuyển đổi đối tượng Class thành dữ liệu dạng JSON để lưu trữ trong Firestore.

//           toFirestore: (class1, _) => class1.toJson(),
//         );
//   }

//   Stream<QuerySnapshot> getClass() {
//     return _tasksRef.snapshots();
//   }

//   Stream<QuerySnapshot> getfind(String nameColumn, String searchName) {
//     return _tasksRef.where(nameColumn, isEqualTo: searchName).snapshots();
//   }

//   Future<void> getId(String taskId) async {
//     try {
//       await _tasksRef.doc(taskId).get();
//       print('Task updated successfully!'); // Informative success message
//     } catch (error) {
//       print('Error updating task: $error'); // Log the error for debugging
//     }
//   }

//   Future<void> updateClass(String taskId, Class task) async {
//     try {
//       await _tasksRef.doc(taskId).update(task.toJson());
//       print('Task updated successfully!'); // Informative success message
//     } catch (error) {
//       print('Error updating task: $error'); // Log the error for debugging
//     }
//   }

//   Future<void> addProject(Class task) async {
//     try {
//       await _tasksRef.add(task);
//       print('Task added successfully!'); // Informative success message
//     } catch (error) {
//       print('Error adding task: $error'); // Log the error for debugging
//     }
//   }

//   Future<void> deleteProject(String taskId) async {
//     try {
//       await _tasksRef.doc(taskId).delete();
//       print('Task deleted successfully!'); // Informative success message
//     } catch (error) {
//       print('Error deleting task: $error'); // Log the error for debugging
//     }
//   }
// }

class UserRespository extends GetxController {
  static UserRespository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // // Lay user tu firebase
  // Future<void> createUser(UserData user) async {
  //   await _db.collection('db_user').add(user.toJson()).whenComplete(() {
  //     Get.snackbar('Thêm thành công', 'Bạn vừa tạo 1 tài khoản',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green.withOpacity(0.1),
  //         colorText: Colors.green);
  //   }).catchError((error, StackTrace) {
  //     Get.snackbar('Lỗi', 'Hãy thử lại',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.redAccent.withOpacity(0.1),
  //         colorText: Colors.red);
  //     print('Lỗi,$error');
  //   });
  // }

  // // Fetch all User
  // Future<UserData> getuserDetails(String email) async {
  //   final snapshot =
  //       await _db.collection('db_user').where('email', isEqualTo: email).get();
  //   final userdata = snapshot.docs.map((e) => UserData.fromSnapshot(e)).single;
  //   return userdata;
  // }

  // Future<List<UserData>> allUsers() async {
  //   final snapshot = await _db.collection('db_user').get();
  //   final userdata =
  //       snapshot.docs.map((e) => UserData.fromSnapshot(e)).toList();
  //   return userdata;
  // }

  Future<void> updateUser(UserData user) async {
    await _db.collection("db_user").doc(user.email).update(user.toJson());
  }
}

class DatabaseMethods {
  Future<void> addUser(Map<String, dynamic> userinforMap) async {
    try {
      await FirebaseFirestore.instance
          .collection('db_user')
          .doc()
          .set(userinforMap);
    } catch (e) {
      print("Error adding user: $e");
      throw e;
    }
  }

  Future<Stream<QuerySnapshot>> getUserdetails() async {
    return await FirebaseFirestore.instance.collection('db_user').snapshots();
  }

  Future<void> deleteNoteByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('db_user')
          .where('email', isEqualTo: email)
          .get();

      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
        print('Document with email $email deleted successfully');
      });
    } catch (e) {
      print('Error deleting document: $e');
      throw e;
    }
  }

  Future updateUser(String email, Map<String, dynamic> updateinfo) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('db_user')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.size > 0) {
        String userId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('db_user')
            .doc(userId)
            .update(updateinfo);
      } else {
        print('User with email $email not found');
      }
    } catch (e) {
      print("Error updating user: $e");
      throw e;
    }
  }
}
