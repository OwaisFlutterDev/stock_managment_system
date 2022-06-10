import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_management_system/view/widgets/common_widget.dart';
// dialogBox() {
//   final UserProfileController _userProfileController = Get.put(UserProfileController());
//
//   return GetBuilder<UserProfileController>(
//       init: UserProfileController(),
//       builder: (controller) {
//         return AlertDialog(
//           scrollable: true,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15))),
//            backgroundColor: Colors.indigo,
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ------- profile image -------
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       _userProfileController.imageFile != null
//                           ? CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.blue.shade800,
//                         backgroundImage: new FileImage(_userProfileController.imageFile,),
//                       )
//                           : CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.blue.shade800,
//                         backgroundImage: NetworkImage(
//                             _userProfileController
//                                 .userProfileModel.image),
//                       ),
//
//                       Positioned(
//                           right: 1,
//                           bottom: 0,
//                           child: InkWell(
//                             onTap: () {
//                               _userProfileController.getImage();
//                             },
//                             child: Container(
//                               height: 25,
//                               width: 25,
//                               decoration: BoxDecoration(
//                                   color: Colors.blue,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Icon(
//                                 CupertinoIcons.camera,
//                                 size: 15,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ))
//                     ],
//                   ),
//                 ],
//               ),
//
//               // ---------  user personal data ---------
//
//               SizedBox(
//                 height: 40.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: "Username",
//                         hintStyle: TextStyle(
//                           color: Colors.white70,
//                         ),
//                       ),
//                       style: GoogleFonts.poppins(
//                           textStyle:
//                           TextStyle(fontSize: 42.sp, color: Colors.white)),
//                       controller:
//                       _userProfileController.usernameProfileController,
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(
//                           enabled: false,
//                           hintText: "Email",
//                           hintStyle: TextStyle(color: Colors.white70)),
//                       style: GoogleFonts.poppins(
//                           textStyle:
//                           TextStyle(fontSize: 42.sp, color: Colors.white)),
//                       controller: _userProfileController.emailProfileController,
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(
//                           hintText: "Phone No",
//                           hintStyle: TextStyle(color: Colors.white70)),
//                       style: GoogleFonts.poppins(
//                           textStyle:
//                           TextStyle(fontSize: 42.sp, color: Colors.white)),
//                       controller:
//                       _userProfileController.phoneNumberProfileController,
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 60.h,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Container(
//                   height: 100.h,
//                   width: Get.size.width,
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20.r)),
//                   child: InkWell(
//                     onTap: () {
//                       _userProfileController.updateDataOfProfile();
//                     },
//                     child: Center(
//                         child: Text("Update Profile",
//                             style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     fontSize: 42.sp, color: Colors.white)))),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       });
// }

Widget userProfileDataWidget({String textData, Icon iconData, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          height: 140.h,
          width: 140.r,
          decoration: BoxDecoration(
              color: Colors.blue.shade100.withOpacity(0.06),
              borderRadius: BorderRadius.circular(100.r)
          ),
          child: iconData,
        ),
        SizedBox(width: 35.w,),
        commonText(title: textData,color: Colors.black),
      ],
      //
    ),
  );
}