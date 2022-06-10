import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_system/constants/constant.dart';
import 'package:stock_management_system/controller/bill_system_controller.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthlyBillsScreen extends StatelessWidget {
  final BillSystemController _billSystemController = Get.put(BillSystemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText(
            title: "Monthly Bills:", color: Colors.white, fontSize: 60.sp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                commonText(title: "Monthly All Bills Details",fontWidget: FontWeight.w600,fontSize: 60.sp),
                SizedBox(height: 50.h,),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: {
                    0: FlexColumnWidth(0.3),
                    1: FlexColumnWidth(0.3),
                    2: FlexColumnWidth(0.3),
                    3: FlexColumnWidth(0.5),
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
                                  title: "Product Price",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "Buyer Name",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: commonText(
                                  title: "Date & Time",
                                  color: blueColor,
                                  fontWidget: FontWeight.w500))),
                    ]),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _billSystemController.snapshotDataForMonthly.docs.length,
                    itemBuilder: (context, index) {
                      return Table(
                          border: TableBorder.all(color: Colors.black),
                          columnWidths: {
                            0: FlexColumnWidth(0.3),
                            1: FlexColumnWidth(0.3),
                            2: FlexColumnWidth(0.3),
                            3: FlexColumnWidth(0.5),
                          },
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Center(
                                        child: commonText(
                                          title: _billSystemController
                                              .snapshotDataForMonthly.docs[index]['productName'],
                                        ))),
                                TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Center(
                                        child: commonText(
                                          title:
                                          _billSystemController
                                              .snapshotDataForMonthly.docs[index]['productPrice'],
                                        ))),
                                TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Center(
                                        child: commonText(
                                          title: _billSystemController
                                              .snapshotDataForMonthly.docs[index]['customerName'],
                                        ))),
                                TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Center(
                                        child: commonText(
                                          title: _billSystemController
                                              .snapshotDataForMonthly.docs[index]['timestamp'],
                                        ))),
                              ],
                            )
                          ]);
                    }),
                SizedBox(height: 300.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
