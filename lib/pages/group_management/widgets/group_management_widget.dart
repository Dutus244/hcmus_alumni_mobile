import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/widgets/loading_widget.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';
import 'package:hcmus_alumni_mobile/pages/group_management/group_management_controller.dart';

import '../../../common/function/handle_participant_count.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('group_management'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
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
    typeGroup = '${translate('group')} ${translate('public')}';
  } else {
    typeGroup = '${translate('group')} ${translate('private')}';
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
                    Container(
                      width: 260.w,
                      child: Text(
                        group.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                    ),
                    Text(
                      '$typeGroup - ${handleParticipantCount(group.participantCount)} thành viên',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              height: 1.h,
              color: AppColors.elementLight,
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
                      translate('edit_group'),
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header,
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
                    "groupId": group.id,
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
                      translate('approve_group_members'),
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header,
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
                      translate('manage_member'),
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header,
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
                      translate('exit_group'),
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header,
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
                      translate('delete_group'),
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header,
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