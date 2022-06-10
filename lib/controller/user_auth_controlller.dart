import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management_system/controller/bill_system_controller.dart';
import 'package:stock_management_system/controller/user_profile_controller.dart';
import 'package:stock_management_system/model/user_profile_model.dart';
import 'package:stock_management_system/view/screens/admin_dashboard_screens/admin_dashboard_screen.dart';
import 'package:stock_management_system/view/screens/choose_screen.dart';
import 'package:stock_management_system/view/screens/customer_dashboard_screens/customer_dashboard_screen.dart';
import 'package:stock_management_system/view/screens/employee_dashboard_screens/employee_dashboard_screen.dart';

import 'form_validation_controller.dart';

class UserAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit(){
    super.onInit();
    // final UserProfileController _userProfileController = Get.put(UserProfileController());
    // _userProfileController.getUserData();

    userDataList.bindStream(getAllUserData());


  }

  // ==============================================================================
  // -------------- ===========    Sign up through email & password used for (Employee)  ========== --------------
  //         =========================================================================

  Future createAccount(bool isEmployee, bool isCustomer) async {
     final FormValidationController _formValidationController = Get.put(FormValidationController());


    try {
      User firebaseUser = (await _auth.createUserWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(), password: _formValidationController.passwordController.text.trim()))
          .user;
      firebaseUser.sendEmailVerification();

      if (firebaseUser != null) {
        // -- here we add user data to Firestore --
        CollectionReference user = FirebaseFirestore.instance.collection('users');
        user.doc(firebaseUser.uid).set({
          "uid": firebaseUser.uid,
          "email": _formValidationController.emailController.text,
          "username": _formValidationController.usernameController.text,
          "image": "",
          "phoneNumber": _formValidationController.phoneNumberController.text,
          "isAdmin": false,
          "isEmployee": isEmployee == true ? true : false,
          "isCustomer": isCustomer == true ? true : false,

        }).then((_) => print("Data Of User Is Added to Firestore "))
            .catchError((onError) => print(onError.toString()));

        _formValidationController.clearTextField();
        Get.back();

        Get.snackbar(
          "Create Account Notification",
          "You Created Account Successfully, Please Verify Your Email Before Login ",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        // return _user;
      } else {
        Get.snackbar(
          "Create Account Notification",
          "Account creation field!  please check your email or password",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Create Account Notification",
          "The password provided is too weak.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Create Account Notification",
          "The Account Already Exists For That Email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } catch (error) {
      print(error);
      // Get.snackbar(
      //   "Add Employee Notification",
      //   error.toString(),
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 5),
      // );
      return null;
    }
  }

// ==============================================================================
// -------------- ===========    Sign In through email and password As (Admin)    ========== --------------
//         =========================================================================

  Future signInThroughEmailAndPassword(bool isAdmin, bool isEmployee, bool isCustomer) async {

     final UserProfileController _userProfileController = Get.put(UserProfileController());
     final FormValidationController _formValidationController = Get.put(FormValidationController());

     final BillSystemController _billSystemController = Get.put(BillSystemController());

    try {
      User _user = (await _auth.signInWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(), password: _formValidationController.passwordController.text.trim()))
          .user;
      if (_user.emailVerified) {
        // ----- to get user profile data -----
        await _userProfileController.getUserData();

        // -----------------=============== ReDirect User According to there Credentials ==============---------------

        if(isAdmin == true){
          // ------- ======  Admin Login ===== -------
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.uid)
              .get()
              .then((value) {

            if (value.data()["isAdmin"] == true) {

              // ---- ====== get today bill from bill_system(bill controller) ======= ----
              _billSystemController.getAllBillDataForToday().then((value) {
                return _billSystemController.snapshotDataForToday = value;
              } );
              // print("data  ${_billSystemController.snapshotDataForToday}");

              // ---- ====== get Monthly bill from bill_system(bill controller) ======= ----
              _billSystemController.getAllBillDataForMonthly().then((value) {
                return _billSystemController.snapshotDataForMonthly = value;
              } );

              Get.to(() => AdminDashboardScreen());
              Get.snackbar(
                "Sign In Notification",
                "You are successfully SignIn To Admin Dashboard",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );

            }
            else {
              Get.snackbar(
                "Sign In Notification",
                "Sir Your Account Information Is Not Match To Any Admin Credentials",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );
            }
          });
        }
        else if(isEmployee == true){

          // ------- ======  Employee Login ===== -------
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.uid)
              .get()
              .then((value) {

            if (value.data()["isEmployee"] == true) {

              Get.to(() => EmployeeDashboardScreen());
              Get.snackbar(
                "Sign In Notification",
                "You are successfully SignIn To Employee Dashboard",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );
            }
            else {
              Get.snackbar(
                "Sign In Notification",
                "Sir Your Account Information Is Not Match To Any Employee Credentials",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );
            }
          });

        }
        else if(isCustomer == true){
          // ----- to get user profile data -----
          await _userProfileController.getUserData();

          // ---- ====== get user buy product data from bill_system(bill controller) ======= ----
          _billSystemController.getBuyProductDataOfCurrentClient().then((value) {
            return _billSystemController.snapshotDataOfBuyProductOfCurrentUser = value;
          } );

          // ------- ======  Customer Login ===== -------
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.uid)
              .get()
              .then((value) {

            if (value.data()["isCustomer"] == true) {

              Get.to(() => CustomerDashboardScreen());
              Get.snackbar(
                "Sign In Notification",
                "You are successfully SignIn To Customer Dashboard",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );
            }
            else if(value.data == null){
              Get.snackbar(
                "Sign In Notification",
                "Sir Your Account Information Is Not Match To Any Customer Credentials",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );
            } else {
              Get.snackbar(
                "Sign In Notification",
                "Sir Your Account Information Is Not Match To Any Customer Credentials",
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 5),
              );
            }
          });

        }
        else {
          Get.snackbar(
            "Sign In Notification",
            "You Credentials Is Not Match To Any Account",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5),
          );
        }


        // Get.to(() => AdminDashboardScreen());
        _formValidationController.clearTextField();

        return _user;

      } else {
        Get.snackbar(
          "Sign In Notification",
          "Your account is not verified. We are sending you verification email please verify your account to login Thanks",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        _user.sendEmailVerification();
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Sign In Notification",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Sign In Notification",
          "Wrong password provided for that user.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  // ==============================================================================
// -------------- ===========    Forget Password Method    ========== ----------------------
//         =========================================================================

  Future resetPasswordRequest() async {
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      await _auth.sendPasswordResetEmail(email: _formValidationController.emailController.text.trim());
      Get.snackbar("Reset Password Screen",
          "The mail is send to ${_formValidationController.emailController.text.trim()} please reset the Password",
          duration: Duration(seconds: 5));
      _formValidationController.clearTextField();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Reset Password Notification",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else {
        return null;
      }
    } catch (error) {
      // Get.snackbar("Reset Password Screen", error.toString(),
      //     duration: Duration(seconds: 5));
      print(error);
    }
  }


// ==============================================================================
  // -------------- ===========    Sign out method   ========== --------------
  //         =========================================================================

  void logOut() async {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => ChooseScreen());
  }

// ==============================================================================
// -------------- ===========  Get the User data from Firestore   ========== --------------
//   =========================================================================

  //     ---- ================ User Model Instance =============== -----

  RxList<UserProfileModel> userDataList = RxList<UserProfileModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");


                     // ----- =======  function ====== -----
  Stream<List<UserProfileModel>> getAllUserData() => collectionReference.snapshots().map((query) =>
      query.docs.map((item) => UserProfileModel.fromDocumentSnapshot(item)).toList());



// ==============================================================================
// -------------- ===========  Delete User from Firestore and auth   ========== --------------
//   =========================================================================


  Future deleteUser(String userID) async{

    successMsg(){
      Get.snackbar(
        "Delete User Notification",
        "The User is Deleted Successfully: ",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }
    try {

      final collection = FirebaseFirestore.instance.collection('users');
      await collection
          .doc(userID) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => successMsg())
          .catchError((error) => print('Delete failed: $error'));

    }
    catch (error){
      Get.snackbar(
        "Delete User Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

}