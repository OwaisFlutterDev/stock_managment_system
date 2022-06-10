import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/controller/product_controller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductDetailsScreen extends StatelessWidget {
  final ProductController _productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText(
            title: "Stock Details:", color: Colors.white, fontSize: 60.sp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: {
                    0: FlexColumnWidth(0.3),
                    1: FlexColumnWidth(0.4),
                    2: FlexColumnWidth(0.2),
                    3: FlexColumnWidth(0.3),
                    4: FlexColumnWidth(0.3),
                  },
                  children: [
                    TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "Product Name",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "Product Image Url",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "Product Price",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "No Of Item In Stock",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "Update & Delete ",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                    ]),
                  ],
                ),
                Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _productController.productDataList.length,
                      itemBuilder: (context, index) {
                        return Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: {
                              0: FlexColumnWidth(0.3),
                              1: FlexColumnWidth(0.4),
                              2: FlexColumnWidth(0.2),
                              3: FlexColumnWidth(0.3),
                              4: FlexColumnWidth(0.3),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                          child: commonText(
                                        title: _productController
                                            .productDataList[index].name,
                                      ))),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                          child: commonText(
                                        title: _productController
                                            .productDataList[index].imageUrl,
                                      ))),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                          child: commonText(
                                        title: _productController
                                            .productDataList[index].price,
                                      ))),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                          child: commonText(
                                        title: _productController
                                            .productDataList[index].noOfItem,
                                      ))),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                _productController
                                                        .nameProductUpdateController
                                                        .text =
                                                    _productController
                                                        .productDataList[index]
                                                        .name;
                                                _productController
                                                        .imageUrlProductUpdateController
                                                        .text =
                                                    _productController
                                                        .productDataList[index]
                                                        .imageUrl;
                                                _productController
                                                        .priceProductUpdateController
                                                        .text =
                                                    _productController
                                                        .productDataList[index]
                                                        .price;
                                                _productController
                                                        .noOfItemProductUpdateController
                                                        .text =
                                                    _productController
                                                        .productDataList[index]
                                                        .noOfItem;

                                                // --- === Dialog Box === ---
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return GetBuilder<
                                                              ProductController>(
                                                          init:
                                                              ProductController(),
                                                          builder:
                                                              (controller) {
                                                            return AlertDialog(
                                                              scrollable: true,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                              backgroundColor:
                                                                  Colors.indigo,
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  // ---------  user personal data ---------

                                                                  SizedBox(
                                                                    height:
                                                                        40.h,
                                                                  ),
                                                                  commonText(title: "Update Product:",fontWidget: FontWeight.w700,color: Colors.orange),
                                                                  SizedBox(
                                                                    height:
                                                                    40.h,
                                                                  ),
                                                                  Form(
                                                                      key: controller.updateProductDialogFormKey,
                                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                      child:
                                                                          Column(
                                                                           children: [
                                                                            Padding(
                                                                             padding:
                                                                                 EdgeInsets.symmetric(horizontal: 50.h),
                                                                             child:
                                                                                Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  commonText(title: "Product Name",color: Colors.white70,fontSize: 30.sp),
                                                                                   // SizedBox(height: 10.h,),
                                                                                   TextFormField(
                                                                                  decoration: InputDecoration(
                                                                                    hintText: "Product Name",
                                                                                    hintStyle: TextStyle(
                                                                                      color: Colors.white70,
                                                                                    ),
                                                                                  ),
                                                                                  style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                  controller: controller.nameProductUpdateController,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 30.h,
                                                                                ),
                                                                                  commonText(title: "Product Image Url",color: Colors.white70,fontSize: 30.sp),

                                                                                // ------  product image  ---
                                                                                  InkWell(
                                                                                    onTap: (){
                                                                                      _productController.getImage();
                                                                                    },
                                                                                    child: GetBuilder<ProductController>(
                                                                                        init: ProductController(),
                                                                                        builder: (controller) {
                                                                                          return Container(
                                                                                            height: 150.h,
                                                                                            decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(50.r),
                                                                                                border: Border.all(width: 1)),
                                                                                            child: Align(
                                                                                                alignment: Alignment.center,
                                                                                                child: _productController.imageFile != null ?
                                                                                                Container(
                                                                                                  height: 150.h,
                                                                                                  decoration: BoxDecoration(
                                                                                                      borderRadius: BorderRadius.circular(50.r),
                                                                                                      image: DecorationImage(image:  FileImage(_productController.imageFile),fit: BoxFit.cover,)
                                                                                                  ),
                                                                                                ) :
                                                                                                _productController.productDataList[index].imageUrl != null ?
                                                                                                Container(
                                                                                                  height: 150.h,
                                                                                                  decoration: BoxDecoration(
                                                                                                      borderRadius: BorderRadius.circular(50.r),

                                                                                                      image: DecorationImage(image:  NetworkImage(_productController.productDataList[index].imageUrl ),fit: BoxFit.cover,)
                                                                                                  ),
                                                                                                ):
                                                                                                Icon(CupertinoIcons.share_up)
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                    ),
                                                                                  ),
                                                                                SizedBox(
                                                                                  height: 30.h,
                                                                                ),
                                                                                  commonText(title: "Product Price",color: Colors.white70,fontSize: 30.sp),
                                                                                TextFormField(
                                                                                  decoration: InputDecoration(hintText: "Product Price", hintStyle: TextStyle(color: Colors.white70)),
                                                                                  style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                  controller: controller.priceProductUpdateController,
                                                                                ),
                                                                                  SizedBox(
                                                                                    height: 30.h,
                                                                                  ),
                                                                                  commonText(title: "No Of Item In Stock",color: Colors.white70,fontSize: 30.sp),
                                                                                TextFormField(
                                                                                  decoration: InputDecoration(hintText: "No Of Item In Stock", hintStyle: TextStyle(color: Colors.white70)),
                                                                                  style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                  controller: controller.noOfItemProductUpdateController,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 30.h,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  SizedBox(
                                                                    height:
                                                                        60.h,
                                                                  ),

                                                                  // --- update button ---
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            50.w),
                                                                    child:
                                                                        Container(
                                                                      height: 100.h,
                                                                      width: Get.size.width,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .blue,
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.r)),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                               controller.updateProduct(
                                                                                 _productController.productDataList[index].id,
                                                                                 _productController.productDataList[index].imageUrl.toString(),
                                                                               );
                                                                            },
                                                                           child: Center(
                                                                            child:
                                                                                Text("Update Product Details", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)))),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    });

                                                print("Edit button clicked");
                                              },
                                              child: Icon(
                                                Icons.edit_outlined,
                                                color: Colors.black,
                                                size: 55.r,
                                              )),
                                          InkWell(
                                              onTap: () {
                                                _productController
                                                    .deleteProduct(
                                                  _productController
                                                      .productDataList[index]
                                                      .id,
                                                );
                                                print("Delete button clicked");
                                              },
                                              child: Icon(
                                                CupertinoIcons.delete,
                                                color: Colors.black,
                                                size: 55.r,
                                              )),
                                        ]),
                                  )
                                ],
                              )
                            ]);
                      }),
                ),
                SizedBox(height: 300.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
