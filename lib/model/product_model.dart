import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.imageUrl,
    this.name,
    this.price,
    this.noOfItem,
  });
  String id;
  String imageUrl;
  String name;
  String price;
  String noOfItem;

  ProductModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    imageUrl = doc["imageUrl"];
    name = doc["name"];
    price = doc["price"];
    noOfItem = doc["noOfItem"];

  }

}