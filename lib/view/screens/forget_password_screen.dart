import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/constants/validation_constant.dart';
import 'package:stock_management_system/controller/form_validation_controller.dart';
import 'package:stock_management_system/controller/user_auth_controlller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';

class ForgetPasswordScreen extends StatelessWidget{
  final FormValidationController formValidationController = Get.put(FormValidationController());
  final UserAuthController _userAuthController = Get.put(UserAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "LOGIN",
                onTap: (){
                  formValidationController.forgetPasswordFormKey.currentState
                      .save();
                  if (formValidationController.forgetPasswordFormKey.currentState
                      .validate()) {
                    _userAuthController.resetPasswordRequest();
                  } else {
                    Get.snackbar("SignUp Screen",
                        "Please Fill All The Fields",
                        duration: Duration(seconds: 5));
                  }
                }
            ),
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
                  SizedBox(height: 20.h,),
                  commonText(title: "Forget Password",color: blueColor, fontWidget: FontWeight.w600,fontSize: 70.sp),
                  SizedBox(height: 40.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        commonText(
                          title: "If You Forget Your Password Then Recover It From Here. Please Enter Your Email In The Given Field."
                        ),
                        SizedBox(height: 120.h,),
                        Form(
                          key: formValidationController.forgetPasswordFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: commonTextFormField(
                            hintText: "Email",
                            prefixIcon: Icon(CupertinoIcons.mail,),
                            controller: formValidationController.emailController,
                            validator: ValidationConstant.emailValidator,

                          ),
                        )
                      ],
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }
}