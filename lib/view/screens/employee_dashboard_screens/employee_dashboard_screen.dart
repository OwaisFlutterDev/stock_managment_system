import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/view/screens/employee_dashboard_screens/employee_profile_screen.dart';
import 'package:stock_management_system/view/screens/stock_managemant/add_stock_item_screen.dart';
import 'package:stock_management_system/view/screens/stock_managemant/all_product_detail_screen.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeDashboardScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blueColor,
        title:  commonText(
            title: "Employee Dashboard:"
        ),
        actions: [
          InkWell(
            onTap: (){
               Get.to(() => EmployeeProfileScreen() );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person,color: Colors.white,),
                SizedBox(height: 7.h,),
                commonText(title: "Profile",fontSize: 30.sp)
              ],
            ),
          ),
          SizedBox(width: 40.w,)
        ],
      ),
      body: Stack(
        children: [
          // ------- ==== bg image ==== --------
          new Container(
            decoration: new BoxDecoration(
              // color: Colors.black,
              image: new DecorationImage(image: new
              AssetImage("assets/images/bg_image.png"), fit: BoxFit.cover,),
            ),

          ),
          // ------- ==== main body ==== --------
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(title: "Welcome To The Employee Dashboard:", color: Colors.white,fontSize: 53.sp),
                  SizedBox(height: 500.h,),
                  // ------  main buttons ------
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // SizedBox(height: 60.h,),
                        // commonButton(
                        //     buttonName: "All Customer Details ",
                        //     color: blueColor,
                        //     onTap: (){}
                        // ),
                        SizedBox(height: 60.h,),
                        commonButton(
                            buttonName: "Add New Item To Stock ",
                            color: Colors.indigo,
                            onTap: (){
                               Get.to(() => AddStockItemScreen());
                            }
                        ),
                        SizedBox(height: 60.h,),
                        commonButton(
                            buttonName: "Stock Details ",
                            color: Colors.indigo,
                            onTap: (){
                              Get.to(() => AllProductDetailsScreen());
                            }
                        ),

                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}