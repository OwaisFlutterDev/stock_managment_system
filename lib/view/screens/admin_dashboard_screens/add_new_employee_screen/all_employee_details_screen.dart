import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/controller/user_auth_controlller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllEmployeeAndCustomerDetailsScreen extends StatelessWidget{
  final UserAuthController _userAuthController = Get.put(UserAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: commonText(
          title: "All Employee And Customer Details:",
          color: Colors.white,
          fontSize: 50.sp
      ),),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w,vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             SizedBox(height: 50.h,),
              Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(0.4),
                  2: FlexColumnWidth(0.2),
                  3: FlexColumnWidth(0.3),
                  4: FlexColumnWidth(0.2),
                },
                children: [
                  TableRow(children: [
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: commonText(title: "Username",color: blueColor, fontWidget: FontWeight.w500))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: commonText(title: "Email",color: blueColor, fontWidget: FontWeight.w500))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: commonText(title: "Phone Number",color: blueColor, fontWidget: FontWeight.w500))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: commonText(title: "Credential Type",color: blueColor, fontWidget: FontWeight.w500))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: commonText(title: "Delete",color: blueColor, fontWidget: FontWeight.w500))),
                  ]),
                ],
              ),
              Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _userAuthController.userDataList.length,
                      itemBuilder: (context, index) {
                      return Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: {
                          0: FlexColumnWidth(0.3),
                          1: FlexColumnWidth(0.4),
                          2: FlexColumnWidth(0.2),
                          3: FlexColumnWidth(0.3),
                          4: FlexColumnWidth(0.2),
                        },
                        children: [
                          TableRow(children: [
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Center(
                                    child: commonText(title:
                                        _userAuthController
                                            .userDataList[index].username,
                                       ))),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Center(
                                    child: commonText(title:
                                        _userAuthController
                                            .userDataList[index].email,
                                        ))),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Center(
                                    child: commonText(title:
                                        _userAuthController.userDataList[index].phoneNumber,
                                       ))),
                            // _userAuthController.userDataList[index].isCustomer == true ? "Customer" :
                            // _userAuthController.userDataList[index].isEmployee == true ? "Employee" :
                            // "Admin",
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Center(
                                    child: commonText(title:
                                      _userAuthController.userDataList[index].isCustomer == true ? "Customer" :
                                      _userAuthController.userDataList[index].isEmployee == true ? "Employee" :
                                      "Admin",
                                    ))),
                            TableCell(
                              verticalAlignment:
                              TableCellVerticalAlignment.middle,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          _userAuthController.deleteUser(
                                            _userAuthController
                                                .userDataList[index]
                                                .uid,
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
                          ]),

                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),),
    );
  }
}