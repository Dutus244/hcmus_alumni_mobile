import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/group_member_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/member.dart';
import '../bloc/group_member_blocs.dart';
import '../bloc/group_member_states.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('group_member'),
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
  );
}

Widget listMember(BuildContext context, ScrollController _scrollController,
    Group group) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<GroupMemberBloc>(context)
                  .state
                  .admins
                  .length +
              BlocProvider.of<GroupMemberBloc>(context).state.members.length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<GroupMemberBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .admins
                            .length +
                        BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .members
                            .length ==
                    0) {
                  return Column(
                    children: [
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .admins
                            .length +
                        BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .members
                            .length) {
                  if (BlocProvider.of<GroupMemberBloc>(context)
                      .state
                      .hasReachedMaxMember) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (BlocProvider.of<GroupMemberBloc>(context)
                              .state
                              .admins
                              .length !=
                          0 &&
                      index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.w, top: 10.h, bottom: 5.h),
                          child: Text(
                            translate('admin'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ),
                        member(
                            context,
                            BlocProvider.of<GroupMemberBloc>(context)
                                .state
                                .admins[index],
                            group),
                      ],
                    );
                  } else if (index -
                          BlocProvider.of<GroupMemberBloc>(context)
                              .state
                              .admins
                              .length ==
                      0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.w, top: 10.h, bottom: 5.h),
                          child: Text(
                            translate('member'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ),
                        member(
                            context,
                            BlocProvider.of<GroupMemberBloc>(context)
                                    .state
                                    .members[
                                index -
                                    BlocProvider.of<GroupMemberBloc>(context)
                                        .state
                                        .admins
                                        .length],
                            group),
                      ],
                    );
                  } else if (BlocProvider.of<GroupMemberBloc>(context)
                          .state
                          .admins
                          .length >
                      index) {
                    return member(
                        context,
                        BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .admins[index],
                        group);
                  } else {
                    return member(
                        context,
                        BlocProvider.of<GroupMemberBloc>(context).state.members[
                            index -
                                BlocProvider.of<GroupMemberBloc>(context)
                                    .state
                                    .admins
                                    .length],
                        group);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget member(BuildContext context, Member member, Group group) {
  return GestureDetector(
    onTap: () {
      if (member.user.id ==
          Global.storageService.getUserId()) {
        Navigator.pushNamed(
          context,
          "/myProfilePage",
        );
      } else {
        Navigator.pushNamed(context, "/otherProfilePage",
            arguments: {
              "id": member.user.id,
            });
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                child: CircleAvatar(
                  radius: 10,
                  child: null,
                  backgroundImage: NetworkImage(member.user.avatarUrl),
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
                    member.user.fullName,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: AppFonts.Header,
                    ),
                  ),
                  if (member.role == 'ADMIN' || member.role == 'CREATOR')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/star_circle.svg",
                          width: 12.w,
                          height: 12.h,
                          color: AppColors.textGrey,
                        ),
                        Container(
                          width: 2.w,
                        ),
                        Text(
                          translate('admin'),
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      ],
                    ),
                  if (member.role == 'MEMBER')
                    Text(
                      translate('member'),
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (group.userRole == 'ADMIN' || group.userRole == 'CREATOR')
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => memberManagement(context, member, group.id),
                );
              },
              child: Container(
                width: 17.w,
                height: 17.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/3dot.png"))),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget memberManagement(BuildContext context, Member member, String groupId) {
  return Container(
    height: 120.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    member.user.fullName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  GroupMemberController(context: context)
                      .handleDeleteMemeber(groupId, member.user.id);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/delete_user.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_member'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (member.role == 'MEMBER') {
                    GroupMemberController(context: context).handleChangeRole(
                        groupId, member.user.id, 'ADMIN');
                  } else {
                    GroupMemberController(context: context).handleChangeRole(
                        groupId, member.user.id, 'MEMBER');
                  }
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/star_circle.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        member.role == 'MEMBER'
                            ? translate('invite_admin')
                            : translate('remove_admin'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
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
    ),
  );
}
