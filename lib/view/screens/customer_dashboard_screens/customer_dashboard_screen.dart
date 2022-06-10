import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/controller/bill_system_controller.dart';
import 'package:stock_management_system/controller/product_controller.dart';
import 'package:stock_management_system/view/screens/customer_dashboard_screens/buy_product_screen.dart';
import 'package:stock_management_system/view/screens/customer_dashboard_screens/customer_profile_screen.dart';
import 'package:stock_management_system/view/screens/customer_dashboard_screens/search_screen.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerDashboardScreen extends StatelessWidget {
  final ProductController _productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blueColor,
        title:  commonText(
            title: "Stock Management:"
        ),
        actions: [
          GetBuilder<BillSystemController>(
            init: BillSystemController(),
            builder: (controller) {
              return InkWell(
                onTap: (){
                  controller.getBuyProductDataOfCurrentClient().then((value) {
                    return controller.snapshotDataOfBuyProductOfCurrentUser= value;
                  } );
                  Get.to(() => BuyProductScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_edu_rounded,color: Colors.white,),
                    SizedBox(height: 7.h,),
                    commonText(title: "Buyed Product",fontSize: 30.sp)
                  ],
                ),
              );
            }
          ),

          SizedBox(width: 40.w,),
          InkWell(
            onTap: (){
              Get.to(() => CustomerProfileScreen());
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
              image: new DecorationImage(image: new AssetImage("assets/images/bg_image.png"), fit: BoxFit.cover,),
            ),
            // child: new BackdropFilter(
            //   filter: new ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            //   child: new Container(
            //     decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //   ),
            // ),
          ),
          // --- ======= main body ======= ---
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.w, ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonText(title: "Welcome To Our Store:", color: Colors.white,fontSize: 55.sp,fontWidget: FontWeight.w600),

                        // -- search screen button --
                        InkWell(
                            onTap: (){
                               Get.to(() => SearchScreen());
                            },
                            child: Icon(CupertinoIcons.search,color: Colors.black,))
                      ],
                    ),
                    SizedBox(height: 50.h,),

                  Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: _productController.productDataList.length,
                           physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                          return Column(
                            children: [
                              // --- to open bottom sheet ---
                              InkWell(
                                onTap: (){
                                  // -------- Shopping Cart --- bottom sheet ---------
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(100.r))),
                                      context: context,
                                      builder: (content) => Container(
                                        height: .8.sh,
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 40.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 40.h,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                  commonText(
                                                      title: "Shopping Cart",
                                                       color: Colors.black,
                                                    fontSize: 60.sp,
                                                    fontWidget: FontWeight.bold
                                                  ),
                                              ],),
                                              SizedBox(height: 60.h,),

                                              Center(
                                                child: Container(
                                                  height: 600.h,
                                                  width: .9.sw,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50.r),
                                                      image: DecorationImage(image: NetworkImage(_productController.productDataList[index].imageUrl),fit: BoxFit.cover)
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 40.h,),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                  commonText(
                                                      title: _productController.productDataList[index].name,
                                                      color: Colors.lightBlue,
                                                      fontWidget: FontWeight.w600,
                                                      fontSize: 60.sp
                                                  ),
                                                    Row(
                                                      children: [
                                                        commonText(
                                                            title: "\$",
                                                            color: Colors.lightBlueAccent,
                                                            fontSize: 58.sp
                                                        ),
                                                        commonText(
                                                            title: _productController.productDataList[index].price,
                                                            color: Colors.lightBlueAccent,
                                                            fontSize: 58.sp
                                                        ),
                                                      ],
                                                    ),
                                                ],),
                                              ),

                                          //     ------------ pay button ---------------
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    commonButton(
                                                      onTap: (){
                                                        _productController.payForProduct(
                                                          _productController.productDataList[index].id,
                                                          _productController.productDataList[index].name,
                                                          _productController.productDataList[index].imageUrl,
                                                          _productController.productDataList[index].price,
                                                          _productController.productDataList[index].noOfItem,
                                                        );
                                                      },
                                                      buttonName: "Pay",
                                                      color: blueColor
                                                    ),
                                                    SizedBox(height: 30.h,)
                                                  ],
                                                ),
                                              )


                                          ],),
                                        ),
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: .5),
                                    borderRadius: BorderRadius.circular(50.r),
                                    color: Colors.black54
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20.h,),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 25.w),
                                        child: Container(
                                          height: 600.h,
                                          width: 1.sw,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.r),
                                              image: DecorationImage(image: NetworkImage(_productController.productDataList[index].imageUrl),fit: BoxFit.cover)
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 40.h,),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 55.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            commonText(
                                                title: _productController.productDataList[index].name,
                                                color: Colors.lightBlue,
                                                fontWidget: FontWeight.w600,
                                                fontSize: 60.sp
                                            ),
                                            SizedBox(height: 20.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                commonText(
                                                    title: "Price:",
                                                    color: Colors.white70,
                                                    fontWidget: FontWeight.w500,
                                                    fontSize: 45.sp
                                                ),
                                                Row(
                                                  children: [
                                                    commonText(
                                                        title: "\$",
                                                        color: Colors.lightBlueAccent,
                                                        fontSize: 58.sp
                                                    ),
                                                    commonText(
                                                        title: _productController.productDataList[index].price,
                                                        color: Colors.lightBlueAccent,
                                                        fontSize: 58.sp
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                commonText(
                                                    title: "No Of Item In Stock:",
                                                    color: Colors.white70,
                                                    fontWidget: FontWeight.w500,
                                                    fontSize: 45.sp
                                                ),
                                                commonText(
                                                    title: _productController.productDataList[index].noOfItem,
                                                    color: Colors.lightBlueAccent,
                                                    fontSize: 58.sp
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 34.h,)
                                          ],
                                        ),
                                      ),
                                    ],),
                                ),
                              ),
                              SizedBox(height: 50.h,)
                            ],
                          );
                        }),
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
