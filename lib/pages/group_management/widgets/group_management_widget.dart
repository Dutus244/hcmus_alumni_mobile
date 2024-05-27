import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/widgets/loading_widget.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';
import 'package:hcmus_alumni_mobile/pages/group_management/group_management_controller.dart';

import '../../../common/function/handle_participant_count.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';

AppBar buildAppBar(BuildContext context, Group group, int secondRoute) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/groupDetail",
                    (route) => false,
                arguments: {
                  "id": group.id,
                  "secondRoute": secondRoute,
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.w),
              child: SizedBox(
                width: 25.w,
                height: 25.h,
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Text(
            'Quản lý nhóm',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header0,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.secondaryHeader,
            ),
          ),
          Container(
            width: 25.w,
            color: Colors.transparent,
            child: Row(
              children: [],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget navigation(BuildContext context, Group group, int secondRoute) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          height: 1.h,
          color: AppColors.primarySecondaryElement,
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/groupDetail",
                        (route) => false,
                    arguments: {
                      "id": group.id,
                      "secondRoute": secondRoute,
                    },
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget groupManagement(BuildContext context, Group? group, int secondRoute) {
  if (group == null) {
    return loadingWidget();
  }
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = 'Nhóm Công khai';
  } else {
    typeGroup = 'Nhóm Riêng tư';
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  width: 40.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.h),
                    image: DecorationImage(
                      image: NetworkImage(group.coverUrl ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                    Text(
                      '$typeGroup - ${handleParticipantCount(group.participantCount)} thành viên',
                      style: TextStyle(
                        color: AppColors.primarySecondaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              height: 1.h,
              color: AppColors.primarySecondaryElement,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/groupEdit",
                      (route) => false,
                  arguments: {
                    "group": group,
                    "secondRoute": secondRoute,
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/option.svg",
                      width: 16.w,
                      height: 16.h,
                    ),
                    Container(
                      width: 10.h,
                    ),
                    Text(
                      'Chỉnh sửa nhóm',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/groupMemberApprove",
                      (route) => false,
                  arguments: {
                    "group": group,
                    "secondRoute": secondRoute,
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/user.svg",
                      width: 16.w,
                      height: 16.h,
                      color: Colors.black,
                    ),
                    Container(
                      width: 10.h,
                    ),
                    Text(
                      'Phê duyệt thành viên',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/groupMember",
                      (route) => false,
                  arguments: {
                    "group": group,
                    "secondRoute": secondRoute,
                    "route": 1,
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/user.svg",
                      width: 16.w,
                      height: 16.h,
                      color: Colors.black,
                    ),
                    Container(
                      width: 10.h,
                    ),
                    Text(
                      'Quản lý thành viên',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                GroupManagementController(context: context).handleExitGroup(group.id, secondRoute);
              },
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/exit.svg",
                      width: 16.w,
                      height: 16.h,
                      color: Colors.black,
                    ),
                    Container(
                      width: 10.h,
                    ),
                    Text(
                      'Rời nhóm',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                GroupManagementController(context: context).handleDeleteGroup(group.id, secondRoute);
              },
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/trash.svg",
                      width: 16.w,
                      height: 16.h,
                      color: Colors.black,
                    ),
                    Container(
                      width: 10.h,
                    ),
                    Text(
                      'Xoá nhóm',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}