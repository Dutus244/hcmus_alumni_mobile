import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/request_group.dart';
import 'package:hcmus_alumni_mobile/pages/group_member_approve/group_member_approve_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/group.dart';
import '../bloc/group_member_approve_blocs.dart';
import '../bloc/group_member_approve_states.dart';

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
                "/groupManagement",
                    (route) => false,
                arguments: {
                  "group": group,
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
            'Phê duyệt thành viên',
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

Widget listRequest(
    BuildContext context, ScrollController _scrollController, String groupId) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<GroupMemberApproveBloc>(context)
                  .state
                  .requests
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (
                BlocProvider.of<GroupMemberApproveBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<GroupMemberApproveBloc>(context)
                    .state
                    .requests
                    .isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'Không có yêu cầu phê duyệt thành viên nào',
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
                    BlocProvider.of<GroupMemberApproveBloc>(context)
                        .state
                        .requests
                        .length) {
                  if (BlocProvider.of<GroupMemberApproveBloc>(context)
                      .state
                      .hasReachedMaxRequest) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        request(
                            context,
                            BlocProvider.of<GroupMemberApproveBloc>(context)
                                .state
                                .requests[index], groupId),
                      ],
                    );
                  } else {
                    return request(
                        context,
                        BlocProvider.of<GroupMemberApproveBloc>(context)
                            .state
                            .requests[index], groupId);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget request(BuildContext context, RequestGroup request, String groupId) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
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
                      backgroundImage:
                          NetworkImage(request.participant.avatarUrl),
                    ),
                  ),
                  Container(
                    width: 10.w,
                  ),
                  Text(
                    request.participant.fullName,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: AppFonts.Header2,
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            height: 10.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  GroupMemberApproveController(context: context).handleApprovedRequest(groupId, request.participant.id);
                },
                child: Container(
                  width: 160.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Phê duyệt',
                      style: TextStyle(
                          fontFamily: AppFonts.Header1,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBackground),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  GroupMemberApproveController(context: context).handleDeneidRequest(groupId, request.participant.id);
                },
                child: Container(
                  width: 160.w,
                  height: 30.h,
                  margin: EdgeInsets.only(left: 10.w),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Từ chối',
                      style: TextStyle(
                          fontFamily: AppFonts.Header1,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color:
                          AppColors.primaryText),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            height: 1.h,
            color: AppColors.primarySecondaryElement,
          )
        ],
      ),
    ),
  );
}
