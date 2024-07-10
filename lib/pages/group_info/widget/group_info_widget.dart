import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/group_info/group_info_controller.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../model/group.dart';
import '../bloc/group_info_blocs.dart';

import 'dart:io';

// AppBar buildAppBar(BuildContext context, Group group  ) {
//   return AppBar(
//     backgroundColor: AppColors.background,
//     flexibleSpace: Center(
//       child: Container(
//         margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
//         child: Text(
//           group.name,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontFamily: AppFonts.Header,
//             fontWeight: FontWeight.bold,
//             fontSize: 16.sp,
//             color: AppColors.secondaryHeader,
//           ),
//         ),
//       ),
//     ),
//   );
// }

AppBar buildAppBar(BuildContext context, Group group ) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 80.w, // Giới hạn chiều rộng tối đa của Text
          ),
          child: Text(
            group.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.secondaryHeader,
            ),
          ),
        ),
      ),
    ),
  );
}


Widget infoGroup(BuildContext context, Group group) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w, top: 5.h),
              child: Text(
                translate('introduce'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Header,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
              width: MediaQuery.of(context).size.width,
              child: ExpandableText(
                group.description,
                maxLines: 4,
                expandText: translate('see_more'),
                collapseText: translate('collapse'),
                style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            if (group.privacy == 'PRIVATE')
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/lock.svg",
                      width: 11.w,
                      height: 13.h,
                      color: AppColors.textBlack,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('private'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            width: 300.w,
                            child: Text(
                              translate('private_description'),
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            if (group.privacy == 'PUBLIC')
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/earth.svg",
                      width: 11.w,
                      height: 13.h,
                      color: AppColors.textBlack,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('public'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            width: 300.w,
                            child: Text(
                              translate('public_description'),
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/clock.svg",
                    width: 11.w,
                    height: 13.h,
                    color: AppColors.textBlack,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          translate('group_history'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                        Container(
                          width: 300.w,
                          child: Text(
                            '${translate('group_creation_date')} ${handleDateTime2(group.createAt)}',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 10.h, bottom: 5.h),
              height: 1.h,
              color: AppColors.elementLight,
            ),
            if (group.isJoined || group.privacy == 'PUBLIC')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        child: Text(
                          translate('members'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15.w, top: 5.h),
                        child: GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                "/groupMember",
                                arguments: {
                                  "group": group,
                                },
                              );
                              GroupInfoController(context: context).handleGetAdmin(group.id, 0);
                              GroupInfoController(context: context).handleGetMember(group.id, 0);
                            },
                            child: Text(
                              translate('see_all'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                color: AppColors.element,
                                decorationColor: AppColors.textBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            )),
                      ),
                    ],
                  ),
                  if (BlocProvider.of<GroupInfoBloc>(context)
                          .state
                          .members
                          .length >
                      0)
                    Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        height: 25.h,
                        child: Stack(
                          children: [
                            for (var i = 0;
                                i <
                                    BlocProvider.of<GroupInfoBloc>(context)
                                        .state
                                        .members
                                        .length;
                                i += 1)
                              Positioned(
                                left: (0 + i * 20).w,
                                child: CircleAvatar(
                                  radius: 15,
                                  child: null,
                                  backgroundImage: NetworkImage(
                                      BlocProvider.of<GroupInfoBloc>(context)
                                          .state
                                          .members[i]
                                          .user
                                          .avatarUrl),
                                ),
                              )
                          ],
                        )),
                  if (BlocProvider.of<GroupInfoBloc>(context)
                          .state
                          .members
                          .length >
                      0)
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(

  BlocProvider.of<GroupInfoBloc>(context).state.members.length > 1 ? '${BlocProvider.of<GroupInfoBloc>(context).state.members[0].user.fullName} và người bạn khác đã tham gia' : '${BlocProvider.of<GroupInfoBloc>(context).state.members[0].user.fullName} đã tham gia',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                    ),
                ],
              ),
            if (group.isJoined || group.privacy == 'PUBLIC')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (BlocProvider.of<GroupInfoBloc>(context)
                          .state
                          .admins
                          .length >
                      0)
                    Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        height: 25.h,
                        child: Stack(
                          children: [
                            for (var i = 0;
                                i <
                                    BlocProvider.of<GroupInfoBloc>(context)
                                        .state
                                        .admins
                                        .length;
                                i += 1)
                              Positioned(
                                left: (0 + i * 20).w,
                                child: CircleAvatar(
                                  radius: 15,
                                  child: null,
                                  backgroundImage: NetworkImage(
                                      BlocProvider.of<GroupInfoBloc>(context)
                                          .state
                                          .admins[i]
                                          .user
                                          .avatarUrl),
                                ),
                              )
                          ],
                        )),
                  if (BlocProvider.of<GroupInfoBloc>(context)
                          .state
                          .admins
                          .length >
                      0)
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        BlocProvider.of<GroupInfoBloc>(context)
                                    .state
                                    .admins
                                    .length >
                                1
                            ? '${BlocProvider.of<GroupInfoBloc>(context).state.admins[0].user.fullName} và ${BlocProvider.of<GroupInfoBloc>(context).state.admins.length - 1} người khác là quản trị viên'
                            : '${BlocProvider.of<GroupInfoBloc>(context).state.admins[0].user.fullName} là quản trị viên',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    ],
  );
}
