import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/constants/validation_constant.dart';
import 'package:stock_management_system/controller/form_validation_controller.dart';
import 'package:stock_management_system/controller/user_auth_controlller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';

class AddNewEmployeeScreen extends StatelessWidget{
  final FormValidationController _formValidationController = Get.put(FormValidationController());
  final UserAuthController _userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: commonText(title: "Add New Employee:",fontSize: 60.sp,),
          ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "Add Employee Data",
                onTap: (){

                  _formValidationController.addEmployeeFormKey.currentState
                      .save();
                  if (_formValidationController.addEmployeeFormKey.currentState
                      .validate()) {
                    _userAuthController.createAccount(true,false);
                  } else {
                    Get.snackbar("Add Employee",
                        "Please Fill All The Fields",
                        duration: Duration(seconds: 5));
                  }

                }
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w,vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.h,),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w),
                  child: Form(
                    key: _formValidationController.addEmployeeFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        commonTextFormField(
                          hintText: "Username",
                          prefixIcon: Icon(CupertinoIcons.person,),
                          controller: _formValidationController.usernameController,
                          validator: ValidationConstant.commonValidator,
                        ),
                        SizedBox(height: 40.h,),

                        commonTextFormField(
                          hintText: "Email",
                          prefixIcon: Icon(CupertinoIcons.mail,),
                          controller: _formValidationController.emailController,
                          validator: ValidationConstant.commonValidator,
                        ),
                        SizedBox(height: 40.h,),

                        commonTextFormField(
                          hintText: "Password",
                          obscureText: true,
                          prefixIcon: Icon(CupertinoIcons.lock,),
                          controller: _formValidationController.passwordController,
                          validator: ValidationConstant.commonValidator,
                        ),
                        SizedBox(height: 40.h,),

                        commonTextFormField(
                          hintText: "Phone Number",
                          prefixIcon: Icon(CupertinoIcons.device_phone_portrait,),
                          controller: _formValidationController.phoneNumberController,
                          validator: ValidationConstant.commonValidator,
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}