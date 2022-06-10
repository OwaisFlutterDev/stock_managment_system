import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/view/screens/admin_dashboard_screens/add_new_employee_screen/add_new_employee_screen.dart';
import 'package:stock_management_system/view/screens/admin_dashboard_screens/add_new_employee_screen/all_employee_details_screen.dart';
import 'package:stock_management_system/view/screens/admin_dashboard_screens/admin_profile_screen.dart';
import 'package:stock_management_system/view/screens/admin_dashboard_screens/bill_system_screen/bill_system_screen.dart';
import 'package:stock_management_system/view/screens/stock_managemant/add_stock_item_screen.dart';
import 'package:stock_management_system/view/screens/stock_managemant/all_product_detail_screen.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blueColor,
        title:  commonText(
            title: "Admin Dashboard:"
        ),
        actions: [
          InkWell(
            onTap: (){
              Get.to(() => AdminProfileScreen());
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
        children: <Widget>[
          // ------- ==== bg image ==== --------
          new Container(
            decoration: new BoxDecoration(
              // color: Colors.black,
              image: new DecorationImage(image: new
              AssetImage("assets/images/bg_image.png"), fit: BoxFit.cover,),
            ),
            // child: new BackdropFilter(
            //   filter: new ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            //   child: new Container(
            //      decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //   ),
            // ),
          ),
          // ------- ==== main body ==== --------
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    commonText(title: "Welcome To The Admin Dashboard:", color: Colors.white,fontSize: 56.sp),
                    SizedBox(height: 15.h,),
                    commonText(title: "All Commands Are In Your Hand Sir 😊", color: Colors.black,fontSize: 43.sp),
                    SizedBox(height: 200.h,),
                    // ------  main buttons ------
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          SizedBox(height: 60.h,),
                          commonButton(
                              buttonName: "Add New Employee ",
                              color: Colors.indigo,
                              onTap: (){
                                Get.to(() => AddNewEmployeeScreen());
                              }
                          ),
                          SizedBox(height: 60.h,),
                          commonButton(
                              buttonName: "All Emp & Cust Details ",
                              color: Colors.indigo,
                              onTap: (){
                                Get.to(() => AllEmployeeAndCustomerDetailsScreen());
                              }
                          ),
                          SizedBox(height: 60.h,),
                          commonButton(
                              buttonName: "Add New Product To Stock ",
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
                          SizedBox(height: 60.h,),
                          commonButton(
                              buttonName: "Bill System ",
                              color: Colors.indigo,
                              onTap: (){
                                Get.to(() => BillSystemScreen());
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
