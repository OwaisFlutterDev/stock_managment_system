import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/view/screens/login_as_admin_screen.dart';
import 'package:stock_management_system/view/screens/login_as_customer_screen.dart';
import 'package:stock_management_system/view/screens/login_as_employee_screen.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:stock_management_system/view/widgets/logo_widget.dart';

class ChooseScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ----- body ------
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SizedBox(
                  height: 20.h,
                  ),
                  commonText(title: "Welcome To The Stock Management System",color: blueColor,fontSize: 70.sp, fontWidget: FontWeight.bold),
                  SizedBox(
                    height: 30.h,
                  ),
                  commonText(title: "Continue As...",color: Colors.black,fontSize: 50.sp, ),
                SizedBox(
                  height: 100.h,
                ),
                // -- logo  --
                logoWidget(),

                  SizedBox(
                    height: 240.h,
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    commonButton(
                        buttonName: "Continue As Admin",
                        onTap: (){
                          Get.to(() =>  LoginAsAdminScreen());
                        },
                        color: blueColor
                    ),
                    SizedBox(height: 100.h,),
                    commonButton(
                        buttonName: "Continue As Employee",
                        onTap: (){
                          Get.to(() =>  LoginAsEmployeeScreen());
                        },
                        color: Colors.orange.shade600
                    ),

                    SizedBox(height: 100.h,),
                    commonButton(
                        buttonName: "Continue As Customer",
                        onTap: (){
                          Get.to(() =>  LoginAsCustomerScreen());
                        },
                        color: Colors.yellow
                    ),

                  ],
                )
            ],)
          ),
        ),
      ),
    );
  }


}