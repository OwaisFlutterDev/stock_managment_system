import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/constants/validation_constant.dart';
import 'package:stock_management_system/controller/form_validation_controller.dart';
import 'package:stock_management_system/controller/user_auth_controlller.dart';
import 'package:stock_management_system/view/screens/forget_password_screen.dart';
import 'package:stock_management_system/view/screens/signup_as_customer_screen.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:stock_management_system/view/widgets/logo_widget.dart';

class LoginAsCustomerScreen extends StatelessWidget{
  final FormValidationController _formValidationController = Get.put(FormValidationController());
  final  UserAuthController _userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "LOGIN",
                onTap: (){
                  _formValidationController.customerLoginFormKey.currentState
                      .save();
                  if (_formValidationController.customerLoginFormKey.currentState
                      .validate()) {
                    _userAuthController.signInThroughEmailAndPassword(false,false,true);
                  } else {
                    Get.snackbar("SignUp Screen",
                        "Please Fill All The Fields",
                        duration: Duration(seconds: 5));
                  }
                }
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(title: "Don't have an account!"),
                SizedBox(width: 25.w,),
                InkWell(
                    onTap: (){
                      Get.to(() => SignUpAsCustomerScreen());
                    },
                    child: commonText(title: "Sign Up", color: blueColor,fontWidget: FontWeight.w600)),
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
                  commonText(title: "Continue As Customer!",color: blueColor,fontSize: 65.sp, fontWidget: FontWeight.bold),
                  SizedBox(
                    height: 30.h,
                  ),
                  logoWidget(),
                  SizedBox(
                    height: 80.h,
                  ),
                  Form(
                      key: _formValidationController.customerLoginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            commonTextFormField(
                              hintText: "Email",
                              prefixIcon: Icon(CupertinoIcons.mail,),
                              controller: _formValidationController.emailController,
                              validator: ValidationConstant.emailValidator,

                            ),
                            SizedBox(height: 40.h,),
                            commonTextFormField(
                                hintText: "Password",
                                controller: _formValidationController.passwordController,
                                prefixIcon: Icon(CupertinoIcons.lock,),
                                validator: ValidationConstant.passwordValidatorForSignIn,
                                obscureText: true
                            ),
                            SizedBox(height: 20.h,),
                            InkWell(
                              onTap: (){
                                Get.to(() => ForgetPasswordScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  commonText(title: "Forget Password    ", color: blueColor,)
                                ],),
                            )
                          ],),
                      )),
                  SizedBox(height: 30.h,),
                ],)
          ),
        ),
      ),
    );
  }
}