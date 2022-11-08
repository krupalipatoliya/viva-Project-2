import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseCloudHelpper {
  FireBaseCloudHelpper._();

  static final FireBaseCloudHelpper fireBaseCloudHelpper =
      FireBaseCloudHelpper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      {required String name,
      required String role,
      required int age,
      required int salary}) async {
    CollectionReference users = firestore.collection('Registration');
    users.doc().set({
      'name': name,
      'age': age,
      'role': role,
      'salary': salary,
    });

  }

  Stream<QuerySnapshot> fetchAllData() {
    firestore.collection('Registration').snapshots();

    Stream<QuerySnapshot> collectionStream =
        firestore.collection('Registration').snapshots();

    print(collectionStream);
    return collectionStream;
  }

  Future<void> deleteUser({required String i}) {
    CollectionReference users = firestore.collection('Registration');
    return users
        .doc(i)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateUser(
      {required String i,
      required String name,
      required String role,
      required int age,
      required int salary}) {
    CollectionReference users = firestore.collection('Registration');

    return users
        .doc(i)
        .update({
          'name': name,
          'age': age,
          'role': role,
          'salary': salary,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
