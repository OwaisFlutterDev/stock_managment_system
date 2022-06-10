import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/constants/validation_constant.dart';
import 'package:stock_management_system/controller/product_controller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';

class AddStockItemScreen extends StatelessWidget{
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: commonText(title: "Add New Product:",fontSize: 60.sp,),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "Add Product Data",
                onTap: (){

                  _productController.addStockFormKey.currentState
                      .save();
                  if (_productController.addStockFormKey.currentState
                      .validate()) {
                    _productController.addProduct();
                  } else {
                    Get.snackbar("Add Product",
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
                    key: _productController.addStockFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText(title: "  Enter Product Name"),
                        SizedBox(height: 10.h,),
                        commonTextFormField(
                          hintText: "Product Name ",
                          controller: _productController.nameController,
                          validator: ValidationConstant.commonValidator,
                        ),

                        SizedBox(height: 50.h,),

                        commonText(title: "  Enter Product Price"),
                        SizedBox(height: 10.h,),
                        commonTextFormField(
                          hintText: "Product Price",
                          controller: _productController.priceController,
                          validator: ValidationConstant.commonValidator,
                        ),
                        SizedBox(height: 50.h,),

                        commonText(title: "  Enter No Of Item In Stock"),
                        SizedBox(height: 10.h,),
                        commonTextFormField(
                          hintText: "No Of Item",
                          controller: _productController.noOfItemController,
                          validator: ValidationConstant.commonValidator,
                        ),
                        SizedBox(height: 50.h,),
                        commonText(title: "  Pick Product Image"),
                        SizedBox(height: 10.h,),
                        // --- product image ---
                        InkWell(
                          onTap: (){
                            _productController.getImage();
                          },
                          child: GetBuilder<ProductController>(
                            init: ProductController(),
                            builder: (controller) {
                              return Container(
                                height: 600.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    border: Border.all(width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: _productController.imageFile == null ?  Icon(CupertinoIcons.share_up) :
                                     Container(
                                         height: 600.h,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(50.r),

                                           image: DecorationImage(image:  FileImage(_productController.imageFile),fit: BoxFit.cover,)
                                         ),
                                          )

                                  ),
                              );
                            }
                          ),
                        ),
                        SizedBox(height: 30.h,)

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