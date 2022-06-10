import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/controller/user_profile_controller.dart';
import 'package:stock_management_system/model/bill_system_model.dart';
import 'package:intl/intl.dart';

class BillSystemController extends GetxController{

  RxList<BillSystemModel> billDataaList = RxList<BillSystemModel>([]);
  // RxList<BillSystemModel> buyProductDataList = RxList<BillSystemModel>([]);

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("bill_system");

  @override
  void onInit() {
    super.onInit();

    billDataaList.bindStream(getAllBilData());
    // buyProductDataList.bindStream(getBuyProductData());

  }


  // ==============================================================================
  // -------------- ===========    Get all bill data from Firestore    ========== --------------
  //         =========================================================================

  // Stream<List<BillSystemModel>> getAllBillData() => collectionReference.snapshots().map((value) =>
  //     value.docs.map((item) => BillSystemModel.fromDocumentSnapshot(item)).toList());

  Stream<List<BillSystemModel>> getAllBilData() => collectionReference.snapshots().map((query) =>
      query.docs.map((item) => BillSystemModel.fromDocumentSnapshot(item)).toList());

  // ==============================================================================
  // -------------- ===========    Get the Bill Today data from Firestore    ========== --------------
  //         =========================================================================
  QuerySnapshot snapshotDataForToday;
  DateTime currentDT = DateTime.now();

  Future getAllBillDataForToday() async {
    return FirebaseFirestore.instance.collection("bill_system").where('timestamp', isEqualTo: DateFormat("dd-MM-yyyy").format(DateTime.now())).get();
  }

  // ==============================================================================
  // -------------- ===========    Get the Bill Monthly data from Firestore    ========== --------------
  //         =========================================================================
  QuerySnapshot snapshotDataForMonthly;

  Future getAllBillDataForMonthly() async {
    return FirebaseFirestore.instance.collection("bill_system").where('monthly', isGreaterThanOrEqualTo: DateFormat("MM-yyyy").format(DateTime.now())).get();
    // .then((value) {
    // return snapshotDataForToday = value;
    // });
  }

  // ==============================================================================
  // -------------- ===========    Get all buyed product  data of Current User from Firestore    ========== --------------
  //         =========================================================================
  QuerySnapshot snapshotDataOfBuyProductOfCurrentUser;

  Future getBuyProductDataOfCurrentClient() async {
    final UserProfileController _controller = Get.put(UserProfileController());
    print("function run tim name: ${_controller.usernameProfileController.text}");
    return FirebaseFirestore.instance.collection("bill_system").where('customerName', isEqualTo: _controller.usernameProfileController.text).get();
  }

  // Stream<List<BillSystemModel>> getBuyProductData() {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   final UserProfileController _controller = Get.put(UserProfileController());
  //   print("function run tim name: ${_controller.usernameProfileController.text}");
  //
  //   String userName ;
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUser.uid)
  //       .get()
  //       .then((value) {
  //     print(" Wrong Data: ${value.data()['username']}");
  //     return  userName = value.data()['username'].toString();// Access your field value after your get the data
  //   });
  //
  //   return FirebaseFirestore.instance.collection("bill_system").where("customerName",isEqualTo: userName
  //   ).snapshots().map((query) => query.docs.map((item) => BillSystemModel.fromDocumentSnapshot(item)).toList());
  // }

}