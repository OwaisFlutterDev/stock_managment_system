import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/constants/validation_constant.dart';
import 'package:stock_management_system/controller/form_validation_controller.dart';
import 'package:stock_management_system/controller/user_auth_controlller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';

class SignUpAsCustomerScreen extends StatelessWidget{
  final FormValidationController formValidationController = Get.put(FormValidationController());
  final UserAuthController _userAuthController = Get.put(UserAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "SignUp",
                onTap: (){
                  formValidationController.signupCustomerFormKey.currentState
                      .save();
                  if (formValidationController.signupCustomerFormKey.currentState
                      .validate()) {
                    _userAuthController.createAccount(false,true);
                  } else {
                    Get.snackbar("SignUp Screen",
                        "Please Fill All The Fields",
                        duration: Duration(seconds: 5));
                  }
                }
            ),
            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(title: "Already have an account!"),
                SizedBox(width: 25.w,),
                InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: commonText(title: "Sign In", color: blueColor,fontWidget: FontWeight.w600)),
              ],),
          ],
        ),
      ),

      // ----- body ------
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  commonText(title: "Sign Up As Customer!",color: blueColor,fontSize: 65.sp, fontWidget: FontWeight.bold),
                  SizedBox(
                    height: 200.h,
                  ),
                  Form(
                      key: formValidationController.signupCustomerFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            commonTextFormField(
                              hintText: "Username",
                              prefixIcon: Icon(CupertinoIcons.person,),
                              controller: formValidationController.usernameController,
                              validator: ValidationConstant.commonValidator,
                            ),
                            SizedBox(height: 40.h,),
                            commonTextFormField(
                              hintText: "Email",
                              prefixIcon: Icon(CupertinoIcons.mail,),
                              controller: formValidationController.emailController,
                              validator: ValidationConstant.emailValidator,
                            ),
                            SizedBox(height: 40.h,),
                            commonTextFormField(
                              hintText: "Phone Number",
                              prefixIcon: Icon(CupertinoIcons.device_phone_portrait,),
                              controller: formValidationController.phoneNumberController,
                              validator: ValidationConstant.commonValidator,
                            ),
                            SizedBox(height: 40.h,),
                            commonTextFormField(
                                hintText: "Password",
                                controller: formValidationController.passwordController,
                                prefixIcon: Icon(CupertinoIcons.lock,),
                                validator: ValidationConstant.passwordValidatorForSignIn,
                                obscureText: true
                            ),
                            // SizedBox(height: 540.h,),
                          ],),
                      )),
                ],)
          ),
        ),
      ),
    );
  }
}