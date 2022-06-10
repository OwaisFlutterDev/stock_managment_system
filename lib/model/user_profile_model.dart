import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  UserProfileModel({
    this.uid,
    this.username,
    this.image,
    this.phoneNumber,
    this.email,
    this.isAdmin,
    this.isEmployee,
    this.isCustomer
  });

  String uid;
  String username;
  String email;
  String image;
  String phoneNumber;
  bool isAdmin;
  bool isEmployee;
  bool isCustomer;

  UserProfileModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc["uid"];
    username = doc["username"];
    email = doc["email"];
    image = doc["image"];
    phoneNumber = doc["phoneNumber"];
    isAdmin = doc["isAdmin"];
    isEmployee = doc["isEmployee"];
    isCustomer = doc["isCustomer"];
  }
}