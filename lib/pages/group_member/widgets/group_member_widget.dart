import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/group_member_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/member.dart';
import '../bloc/group_member_blocs.dart';
import '../bloc/group_member_states.dart';

AppBar buildAppBar(BuildContext context, Group group, int secondRoute, int route) {
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
              if (route == 0) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/groupInfo",
                      (route) => false,
                  arguments: {
                    "group": group,
                    "secondRoute": secondRoute,
                  },
                );
              }
              else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/groupManagement",
                      (route) => false,
                  arguments: {
                    "group": group,
                    "secondRoute": secondRoute,
                  },
                );
              }
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
            'Thành viên',
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

Widget listMember(BuildContext context, ScrollController _scrollController,
    Group group, int secondRoute) {
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
                          'Không có thành viên nào',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header2,
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
                            'Quản trị viên',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
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
                            'Thành viên',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
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
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
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
                  backgroundImage: NetworkImage(member.participant.avatarUrl),
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
                    member.participant.fullName,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: AppFonts.Header2,
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
                          color: AppColors.primarySecondaryText,
                        ),
                        Container(
                          width: 2.w,
                        ),
                        Text(
                          'Quản trị viên',
                          style: TextStyle(
                            color: AppColors.primarySecondaryText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            fontFamily: AppFonts.Header2,
                          ),
                        ),
                      ],
                    ),
                  if (member.role == 'MEMBER')
                    Text(
                      'Thành viên',
                      style: TextStyle(
                        color: AppColors.primarySecondaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
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
                    member.participant.fullName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  GroupMemberController(context: context)
                      .handleDeleteMemeber(groupId, member.participant.id);
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
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Xoá thành viên',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
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
                        groupId, member.participant.id, 'ADMIN');
                  } else {
                    GroupMemberController(context: context).handleChangeRole(
                        groupId, member.participant.id, 'MEMBER');
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
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        member.role == 'MEMBER'
                            ? 'Mời làm quản trị viên'
                            : 'Gỡ vai trò quản trị viên',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70.h,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget navigation(BuildContext context, Group group, int secondRoute) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/groupInfo",
                    (route) => false,
                    arguments: {
                      "group": group,
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
