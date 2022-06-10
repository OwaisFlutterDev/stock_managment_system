import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/controller/form_validation_controller.dart';
import 'package:stock_management_system/controller/product_controller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget{
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FormValidationController _formValidationController = Get.put(FormValidationController());

  final ProductController _productController = Get.put(ProductController());
  QuerySnapshot snapshotData;
  bool  isExecute = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.h),
            child: Column(children: [
                SizedBox(height: 40.h,),
                 GetBuilder<ProductController>(
                   init: ProductController(),
                   builder: (controller) {
                     return commonTextFormField(
                       hintText: "Search Any Product",
                       controller: _formValidationController.searchScreenController,
                       suffixIcon: InkWell(
                         onTap: (){
                           controller.getAllProductDataForSearch(_formValidationController.searchScreenController.text.trim()).then((value) {
                             snapshotData = value;
                             setState(() {
                               isExecute = true;
                             });
                           });
                         },
                           child: Icon(CupertinoIcons.search))
                     );
                   }
                 ),
                SizedBox(height: 60.h,),
                // ---  ========== search data ============ ---
                isExecute == true ? Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 17.h),
                  child: Column(
                    children: [

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshotData.docs.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return   Column(
                                children: [
                                  InkWell(
                                    onTap: (){

                                      // -------- Shopping Cart ---------
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
                                                          image: DecorationImage(image: NetworkImage(snapshotData.docs[index]['imageUrl']),fit: BoxFit.cover)
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
                                                            title: snapshotData.docs[index]['name'],
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
                                                                title: snapshotData.docs[index]['price'],
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
                                                                snapshotData.docs[index]['id'],
                                                                snapshotData.docs[index]['name'],
                                                                snapshotData.docs[index]['imageUrl'],
                                                                snapshotData.docs[index]['price'] ,
                                                                snapshotData.docs[index]['noOfItem'],
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
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 200.h,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                            color: Colors.indigoAccent,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: NetworkImage(snapshotData.docs[index]['imageUrl'] ?? '' ),fit: BoxFit.cover)
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            commonText(
                                              title: snapshotData.docs[index]['name'] ?? '',
                                              color: blueColor,
                                              fontWidget: FontWeight.w500,
                                              fontSize: 50.sp
                                            ),
                                            SizedBox(height: 10.h,),
                                            Row(
                                              children: [
                                                commonText(
                                                    title: "Item In Stock",
                                                    color: Colors.black,
                                                    fontWidget: FontWeight.w500,
                                                    fontSize: 40.sp
                                                ),
                                                SizedBox(width: 20.w,),
                                                commonText(
                                                    title: snapshotData.docs[index]['noOfItem'] ?? '',
                                                    color: blueColor,
                                                    fontWidget: FontWeight.w500,
                                                    fontSize: 50.sp
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              commonText(
                                                  title: "\$",
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500,
                                                  fontSize: 50.sp
                                              ),
                                              commonText(
                                                  title: snapshotData.docs[index]['price'] ?? '',
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500,
                                                  fontSize: 50.sp
                                              ),
                                            ],),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Divider()
                                ],
                              );

                            }),
                    ],
                  ),
                ) : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: commonText(
                            title: "Search Product",
                            fontSize: 80.sp,
                            fontWidget: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                )
            ],),
          ),
        ),
      ),
    );
  }
}
