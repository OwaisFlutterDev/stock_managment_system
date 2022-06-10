import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/controller/bill_system_controller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyProductScreen extends StatelessWidget {
  final BillSystemController _billSystemController = Get.put(BillSystemController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title:  commonText(
            title: "Buyed Product History:"
        ),
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
                      commonText(title: "These Are The Product You Buy:", color: Colors.white,fontSize: 55.sp,fontWidget: FontWeight.w600),
                    ],
                  ),
                  SizedBox(height: 50.h,),

                  ListView.builder(
                          shrinkWrap: true,
                          itemCount: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  border: Border.all(width: .5),
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Row(
                                  children: [
                                   Container(
                                          height: 600.h,
                                          width: .4.sw,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.r),
                                              image: DecorationImage(image: NetworkImage(_billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['productImageUrl']),fit: BoxFit.cover)
                                          ),
                                        ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        commonText(
                                            title: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['productName'],
                                            color: Colors.lightBlueAccent,
                                            fontSize: 58.sp
                                        ),
                                        SizedBox(height: 90.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            commonText(
                                                title: "Payed Price:",
                                                color: Colors.white70,
                                                fontWidget: FontWeight.w500,
                                                fontSize: 45.sp
                                            ),
                                            SizedBox(width: 20.w,),
                                            commonText(
                                                title: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['productPrice'],
                                                color: Colors.lightBlueAccent,
                                                fontSize: 58.sp
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 90.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            commonText(
                                                title: "Date:",
                                                color: Colors.white70,
                                                fontWidget: FontWeight.w500,
                                                fontSize: 45.sp
                                            ),
                                            SizedBox(width: 40.w,),
                                            commonText(
                                                title: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['timestamp'],
                                                color: Colors.lightBlueAccent,
                                                fontSize: 58.sp
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),



                                  ],
                                )
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     SizedBox(height: 20.h,),
                                //     Padding(
                                //       padding:  EdgeInsets.symmetric(horizontal: 25.w),
                                //       child: Container(
                                //         height: 600.h,
                                //         width: 1.sw,
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(50.r),
                                //             image: DecorationImage(image: NetworkImage(_billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['productImageUrl']),fit: BoxFit.cover)
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(height: 40.h,),
                                //     Padding(
                                //       padding:  EdgeInsets.symmetric(horizontal: 55.w),
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           commonText(
                                //               title: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['productName'],
                                //               color: Colors.lightBlue,
                                //               fontWidget: FontWeight.w600,
                                //               fontSize: 60.sp
                                //           ),
                                //           SizedBox(height: 20.h,),
                                //           Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               commonText(
                                //                   title: "Price:",
                                //                   fontWidget: FontWeight.w500,
                                //                   fontSize: 45.sp
                                //               ),
                                //               Row(
                                //                 children: [
                                //                   commonText(
                                //                       title: "\$",
                                //                       color: Colors.lightBlueAccent,
                                //                       fontSize: 58.sp
                                //                   ),
                                //                   commonText(
                                //                       title: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['productPrice'],
                                //                       color: Colors.lightBlueAccent,
                                //                       fontSize: 58.sp
                                //                   ),
                                //                 ],
                                //               ),
                                //             ],
                                //           ),
                                //           SizedBox(height: 20.h,),
                                //           Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               commonText(
                                //                   title: "Date:",
                                //                   fontWidget: FontWeight.w500,
                                //                   fontSize: 45.sp
                                //               ),
                                //               commonText(
                                //                   title: _billSystemController.snapshotDataOfBuyProductOfCurrentUser.docs[index]['timestamp'],
                                //                   color: Colors.lightBlueAccent,
                                //                   fontSize: 58.sp
                                //               ),
                                //             ],
                                //           ),
                                //           SizedBox(height: 34.h,)
                                //         ],
                                //       ),
                                //     ),
                                //   ],),
                              ),
                              SizedBox(height: 50.h,)
                            ],
                          );
                        }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
