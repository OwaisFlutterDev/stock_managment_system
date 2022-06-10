import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_management_system/controller/bill_system_controller.dart';
import 'package:stock_management_system/model/product_model.dart';
import 'package:intl/intl.dart';

class ProductController extends GetxController{

  //     ---- ================ product Model Instance =============== -----

  RxList<ProductModel> productDataList = RxList<ProductModel>([]);
  // RxList<ProductModel> productDataListForSearch = RxList<ProductModel>([]);

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("product");

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> addStockFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateProductDialogFormKey = GlobalKey<FormState>();


  TextEditingController nameController, imageUrlController, priceController, noOfItemController;

  TextEditingController nameProductUpdateController = new TextEditingController();
  TextEditingController imageUrlProductUpdateController = new TextEditingController();
  TextEditingController priceProductUpdateController = new TextEditingController();
  TextEditingController noOfItemProductUpdateController = new TextEditingController();


  File imageFile;
  String fileName;


  // ---------- onInit() ------------

  @override
  void onInit(){
    super.onInit();

    productDataList.bindStream(getAllProductData());
    // productDataListForSearch.bindStream(getAllProductDataForSearch());

    nameController = TextEditingController();
    imageUrlController = TextEditingController();
    priceController = TextEditingController();
    noOfItemController = TextEditingController();

    final BillSystemController _billSystemController = Get.put(BillSystemController());
    _billSystemController.getBuyProductDataOfCurrentClient();


  }

  //  ---------------- get the image from gallery ---------------------
  void getImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(img.path);
    update();
  }

  void clearTextField(){
    nameController.clear();
    imageUrlController.clear();
    priceController.clear();
    noOfItemController.clear();
  }
  // ==============================================================================
  // -------------- ===========    Add product data to Firestore    ========== --------------
  //         =========================================================================

  Future addProduct() async{

    successMsg(){
      Get.snackbar(
        "Add Product Notification",
        "Successfully Added the Product",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {

      String imageUrl;
      fileName = basename(imageFile.path);

      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'user_images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

      // ignore: unused_local_variable

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
          () {
        print("Upload Complete");
      });

      imageUrl = await firebaseStorageRef.getDownloadURL();

      final addProduct = FirebaseFirestore.instance.collection("product").doc();
      await addProduct.set({
        "id": addProduct.id,
        "name": nameController.text,
        "imageUrl": imageUrl != null ? imageUrl : "",
        "price":  priceController.text,
        "noOfItem":  noOfItemController.text,

      }).then((_) => successMsg()).catchError((onError) => print(onError.toString()));

      clearTextField();

    }
    catch (error){
      Get.snackbar(
        "Add Product Notification",
       "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  // ==============================================================================
  // -------------- ===========    Get the product data from Firestore    ========== --------------
  //         =========================================================================


  Stream<List<ProductModel>> getAllProductData() => collectionReference.snapshots().map((query) =>
      query.docs.map((item) => ProductModel.fromDocumentSnapshot(item)).toList());

  // _doc != null ? print("Get Data from firebase") : print("Get null Data from firebase");



// ==============================================================================
  // -------------- ===========    Delete Product    ========== --------------
  //         =========================================================================

  Future deleteProduct(String productID) async{

    successMsg(){
      Get.snackbar(
        "Delete Product Notification",
        "The Product is Deleted Successfully: ",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {

      final collection = FirebaseFirestore.instance.collection('product');
      await collection
          .doc(productID) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => successMsg())
          .catchError((error) => print('Delete failed: $error'));
    }
    catch (error){
      Get.snackbar(
        "Delete Product Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }


// ==============================================================================
  // -------------- ===========    Update Product    ========== --------------
  //         =========================================================================

  Future updateProduct(String id, String oldFirebaseImage ) async {

    successMsg(){
      Get.back();
      Get.snackbar(
        "Update Product Notification",
        "Successfully Update the Product",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {
      if(imageFile != null) {
        String imageUrl;
        fileName = basename(imageFile.path);

        Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
            'user_images/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

        // ignore: unused_local_variable

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
            () {
          print("Upload image Complete");
        });

        imageUrl = await firebaseStorageRef.getDownloadURL();

        await FirebaseFirestore.instance.collection('product').doc(id)
            .update(
            {
              "id": id,
              "name": nameProductUpdateController.text,
              "imageUrl":  imageUrl,
              "price":  priceProductUpdateController.text ,
              "noOfItem":  noOfItemProductUpdateController.text,
            }
        )
            .then((_) => successMsg())
            .catchError((onError) => print(onError.toString()));

      } else {

        await FirebaseFirestore.instance.collection('product').doc(id)
            .update(
            {
              "id": id,
              "name": nameProductUpdateController.text,
              "imageUrl":  imageUrlProductUpdateController.text ,
              "price":  priceProductUpdateController.text ,
              "noOfItem":  noOfItemProductUpdateController.text,
            }
        )
            .then((_) => successMsg())
            .catchError((onError) => print(onError.toString()));
      }
    }
    catch (error){
      Get.snackbar(
        "Update Product Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  // ==============================================================================
  // -------------- ===========    Pay For Product and Bill add    ========== --------------
  //         =========================================================================

  Future payForProduct(String id, String name, String image, String price ,String noOfItem) async {

     successMsg(){
       Get.back();
       Get.snackbar(
         "Buy Product Notification",
         "You Successfully Buy this Product",
         snackPosition: SnackPosition.TOP,
         duration: Duration(seconds: 7),
       );

     }
     // ------------  ============ to check no of item in Stock ============  ------------
     var noOfItemInGetProductData = await FirebaseFirestore.instance
         .collection('product')
         .doc(id)
         .get()
         .then((value) {
       return value.data()['noOfItem']; // Access your field value after your get the data
     });
     int noOfItemInInt = int.parse(noOfItemInGetProductData);
     print("No of item Of The Product $noOfItemInInt");

     try {

       if(noOfItemInInt == 0) {
         Get.back();
         Get.snackbar(
           "Buy Product Notification",
           "Sorry Sir, This Product Is Currently Out Of Stock And Unavailable",
           snackPosition: SnackPosition.TOP,
           duration: Duration(seconds: 7),
         );

       }
       else {

         var priceInt = int.parse(noOfItem);
         var sub = priceInt - 1;
         String stringNoOfItem = "$sub";
         print(stringNoOfItem);

         await FirebaseFirestore.instance.collection('product').doc(id)
             .set(
             {
               "id": id,
               "name": name,
               "imageUrl": image,
               "price":  price ,
               "noOfItem":  stringNoOfItem,
             }
         )
             .then((_) => successMsg())
             .catchError((onError) => print(onError.toString()));
                 // =======================================
       //   ----- ==========  add bill to bill system ========= -----
       //          ===================================

         final currentUser = FirebaseAuth.instance.currentUser;
         // -- get current user name --
         String userName = await FirebaseFirestore.instance
             .collection('users')
             .doc(currentUser.uid)
             .get()
             .then((value) {
           return value.data()['username']; // Access your field value after your get the data
         });

         print("Current User Name: $userName");

         // ----- ======= today time ======== -----
         // DateTime currentDT = DateTime.now();
         // // DateTime enterDataTime = DateFormat().format(currentDT);
         // print(DateFormat().format(currentDT).toString());

         final addProduct = FirebaseFirestore.instance.collection("bill_system").doc();
         await addProduct.set({
           "id": addProduct.id,
           "productImageUrl": image,
           "productName": name,
           "productPrice":  price,
           "customerName":  userName,
           "timestamp": DateFormat("dd-MM-yyyy").format(DateTime.now()),
           "monthly": DateFormat("MM-yyyy").format(DateTime.now())

         }).then((_) => print("You Successfully Enter The Bill Data ")).catchError((onError) => print(onError.toString()));


         final BillSystemController _billSystemController = Get.put(BillSystemController());
         // ---- ====== get user buy product data from bill_system(bill controller) ======= ----
         _billSystemController.getBuyProductDataOfCurrentClient().then((value) {
           return _billSystemController.snapshotDataOfBuyProductOfCurrentUser = value;
         } );
       }
     }
     catch (error){
       Get.snackbar(
         "Buy Product Notification",
         "Check Your Internet Connection",
         snackPosition: SnackPosition.TOP,
         duration: Duration(seconds: 3),
       );
     }
   }

  // ==============================================================================
  // -------------- ===========    Get the product data from Firestore    ========== --------------
  //         =========================================================================


  //
  // final FormValidationController _formValidationController = Get.put(FormValidationController());

  // Stream<List<ProductModel>> getAllProductDataForSearch() => collectionReference.where('name',isGreaterThanOrEqualTo: _formValidationController.searchScreenController.text).snapshots().map((query) =>
  //     query.docs.map((item) => ProductModel.fromDocumentSnapshot(item)).toList());
  Future getAllProductDataForSearch(String searchText) async {

    return FirebaseFirestore.instance.collection("product").where('name', isEqualTo: searchText).get();

  }

}