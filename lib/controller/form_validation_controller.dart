import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormValidationController extends GetxController{

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> loginAdminFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> adminSignUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> customerLoginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> employeeLoginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupCustomerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addEmployeeFormKey = GlobalKey<FormState>();


  //   ----- ========== Text Editing Controller ========== -----
  TextEditingController usernameController, emailController,
      passwordController, phoneNumberController, searchScreenController;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    searchScreenController = TextEditingController();

  }

  void clearTextField(){
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
    searchScreenController.clear();
  }

}