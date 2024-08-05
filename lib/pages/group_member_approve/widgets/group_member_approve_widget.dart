import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/group_request.dart';
import 'package:hcmus_alumni_mobile/pages/group_member_approve/group_member_approve_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/group.dart';
import '../bloc/group_member_approve_blocs.dart';
import '../bloc/group_member_approve_states.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('approve_group_members'),
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
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                12.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
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
                                .requests[index],
                            groupId),
                      ],
                    );
                  } else {
                    return request(
                        context,
                        BlocProvider.of<GroupMemberApproveBloc>(context)
                            .state
                            .requests[index],
                        groupId);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget request(BuildContext context, GroupRequest request, String groupId) {
  return GestureDetector(
    onTap: () {
      if (request.user.id == Global.storageService.getUserId()) {
        Navigator.pushNamed(
          context,
          "/myProfilePage",
        );
      } else {
        Navigator.pushNamed(context, "/otherProfilePage", arguments: {
          "id": request.user.id,
        });
      }
    },
    child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              child: CircleAvatar(
                radius: 40,
                child: null,
                backgroundImage: NetworkImage(request.user.avatarUrl),
              ),
            ),
            Container(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 255.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request.user.fullName,
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize:
                              12.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10.h,
                ),
                Container(
                  width: 255.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120.w,
                        height: 30.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (BlocProvider.of<GroupMemberApproveBloc>(context).state.isLoading){
                              return;
                            }
                            GroupMemberApproveController(context: context)
                                .handleApprovedRequest(groupId, request.user.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.element,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            minimumSize: Size(120.w, 30.h),
                          ),
                          child: Center(
                            child: Text(
                              translate('approve'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 11.sp /
                                    MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold,
                                color: AppColors.background,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            if (BlocProvider.of<GroupMemberApproveBloc>(context).state.isLoading){
                              return;
                            }
                            GroupMemberApproveController(context: context)
                                .handleDeniedRequest(groupId, request.user.id);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.textBlack, backgroundColor: Color.fromARGB(255, 230, 230, 230),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            minimumSize: Size(120.w, 30.h),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('deny'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}
