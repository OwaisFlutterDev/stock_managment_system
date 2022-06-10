import 'package:cloud_firestore/cloud_firestore.dart';

class BillSystemModel {
  BillSystemModel({
    this.id,
    this.productImageUrl,
    this.productName,
    this.productPrice,
    this.customerName,
    this.monthly
  });
  String id;
  String productImageUrl;
  String productName;
  String productPrice;
  String customerName;
  String timestamp;
  String monthly;

  BillSystemModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    productImageUrl = doc["productImageUrl"];
    productName = doc["productName"];
    productPrice = doc["productPrice"];
    customerName = doc["customerName"];
    timestamp = doc["timestamp"];
    monthly = doc["monthly"];
  }

}