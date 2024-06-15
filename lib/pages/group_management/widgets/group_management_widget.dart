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
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          'Quản lý nhóm',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header0,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget groupManagement(BuildContext context, Group? group) {
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
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  "/groupEdit",
                  arguments: {
                    "group": group,
                  },
                );
                GroupManagementController(context: context).handleGetGroup(group.id);
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
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  "/groupMemberApprove",
                  arguments: {
                    "group": group,
                  },
                );
                GroupManagementController(context: context).handleGetGroup(group.id);
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
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  "/groupMember",
                  arguments: {
                    "group": group,
                  },
                );
                GroupManagementController(context: context).handleGetGroup(group.id);
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
                GroupManagementController(context: context).handleExitGroup(group.id);
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
                GroupManagementController(context: context).handleDeleteGroup(group.id);
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