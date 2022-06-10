import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_management_system/controller/user_auth_controlller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_management_system/controller/user_profile_controller.dart';
import 'package:stock_management_system/view/widgets/profile_screen_widgets.dart';

class CustomerProfileScreen extends StatelessWidget {
  final UserAuthController _userAuthController = Get.put(UserAuthController());
  final UserProfileController _userProfileController = Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 40.w,vertical: 50.h),
          child: userProfileDataWidget(
              onTap: () {
                _userAuthController.logOut();
              },
              textData: "Sign Out",
              iconData: Icon(
                CupertinoIcons.arrowshape_turn_up_left_2,
                color: Colors.black,
              )),
        ),
        // resizeToAvoidBottomInset: false,
        body: GetBuilder<UserProfileController>(
            init: UserProfileController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // --- for design --
                    Container(
                      height: 600.h,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(80.r),
                              bottomRight: Radius.circular(80.r))),
                      // --  edit icon and image --
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 43.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Customer Profile",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 50.sp,
                                            color: Colors.white))),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                      return GetBuilder<UserProfileController>(
                                                          init: UserProfileController(),
                                                          builder: (controller) {
                                                            return AlertDialog(
                                                              scrollable: true,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                                                              backgroundColor: Colors.indigo,
                                                              content: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  // ------- profile image -------
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          _userProfileController.imageFile != null
                                                                              ? CircleAvatar(
                                                                            radius: 50,
                                                                            backgroundColor: Colors.blue.shade800,
                                                                            backgroundImage: new FileImage(_userProfileController.imageFile,),
                                                                          )
                                                                              : CircleAvatar(
                                                                            radius: 50,
                                                                            backgroundColor: Colors.blue.shade800,
                                                                            backgroundImage: NetworkImage(
                                                                                _userProfileController
                                                                                    .userProfileModel.image),
                                                                          ),

                                                                          Positioned(
                                                                              right: 1,
                                                                              bottom: 0,
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  _userProfileController.getImage();
                                                                                },
                                                                                child: Container(
                                                                                  height: 25,
                                                                                  width: 25,
                                                                                  decoration: BoxDecoration(
                                                                                      color: Colors.blue,
                                                                                      borderRadius: BorderRadius.circular(20)),
                                                                                  child: Icon(
                                                                                    CupertinoIcons.camera,
                                                                                    size: 15,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),

                                                                  // ---------  user personal data ---------

                                                                  SizedBox(
                                                                    height: 40.h,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 50.h),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        TextField(
                                                                          decoration: InputDecoration(
                                                                            hintText: "Username",
                                                                            hintStyle: TextStyle(
                                                                              color: Colors.white70,
                                                                            ),
                                                                          ),
                                                                          style: GoogleFonts.poppins(
                                                                              textStyle:
                                                                              TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                          controller:
                                                                          _userProfileController.usernameProfileController,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 30.h,
                                                                        ),
                                                                        TextField(
                                                                          decoration: InputDecoration(
                                                                              enabled: false,
                                                                              hintText: "Email",
                                                                              hintStyle: TextStyle(color: Colors.white70)),
                                                                          style: GoogleFonts.poppins(
                                                                              textStyle:
                                                                              TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                          controller: _userProfileController.emailProfileController,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 30.h,
                                                                        ),
                                                                        TextField(
                                                                          decoration: InputDecoration(
                                                                              hintText: "Phone No",
                                                                              hintStyle: TextStyle(color: Colors.white70)),
                                                                          style: GoogleFonts.poppins(
                                                                              textStyle:
                                                                              TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                          controller:
                                                                          _userProfileController.phoneNumberProfileController,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 30.h,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 60.h,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                    child: Container(
                                                                      height: 100.h,
                                                                      width: Get.size.width,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.blue,
                                                                          borderRadius: BorderRadius.circular(20.r)),
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          _userProfileController.updateDataOfProfile(false,false,true);
                                                                        },
                                                                        child: Center(
                                                                            child: Text("Update Profile",
                                                                                style: GoogleFonts.poppins(
                                                                                    textStyle: TextStyle(
                                                                                        fontSize: 42.sp, color: Colors.white)))),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                });
                                          },
                                          child: SingleChildScrollView(
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 65.r,
                                              ))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 65.h,
                          ),
                          Container(
                            height: 320.h,
                            width: 320.r,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade800,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(controller.userProfileModel.image),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                    // ------ user personal data ------
                    SizedBox(
                      height: 90.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w),
                      child: Column(
                        children: [
                          userProfileDataWidget(
                              textData: controller.userProfileModel.username,
                              iconData: Icon(
                                CupertinoIcons.person_alt,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 50.h,
                          ),
                          userProfileDataWidget(
                              textData: controller.userProfileModel.email,
                              iconData: Icon(
                                CupertinoIcons.mail,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 50.h,
                          ),
                          userProfileDataWidget(
                              textData: controller.userProfileModel.phoneNumber,
                              iconData: Icon(
                                CupertinoIcons.phone,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 300.h,
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
