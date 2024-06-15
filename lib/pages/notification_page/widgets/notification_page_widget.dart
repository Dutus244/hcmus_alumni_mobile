import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/model/notification.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../bloc/notification_page_blocs.dart';
import '../bloc/notification_page_states.dart';

Widget listNotificaitons(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
          BlocProvider.of<NotificationPageBloc>(context).state.notifications.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (
            BlocProvider.of<NotificationPageBloc>(context).state.statusNotification) {
              case Status.loading:
                return Column(
                  children: [
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<NotificationPageBloc>(context)
                    .state
                    .notifications
                    .isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: Text(
                              'Không có dữ liệu',
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
                    BlocProvider.of<NotificationPageBloc>(context)
                        .state
                        .notifications
                        .length) {
                  if (BlocProvider.of<NotificationPageBloc>(context)
                      .state
                      .hasReachedMaxNotification) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        notification(
                            context,
                            BlocProvider.of<NotificationPageBloc>(context)
                                .state
                                .notifications[index]),
                      ],
                    );
                  } else {
                    return notification(
                        context,
                        BlocProvider.of<NotificationPageBloc>(context)
                            .state
                            .notifications[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget notification(BuildContext context, Notifications notifications) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, "",
          arguments: {

          });
    },
    child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
        color: notifications.isRead ? Colors.transparent : AppColors.primarySecondaryElement,
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              child: CircleAvatar(
                radius: 40,
                child: null,
                backgroundImage:
                NetworkImage(''),
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
                  margin: EdgeInsets.only(right: 10.w),
                  width: 250.w,
                  child: Text(
                    notifications.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 250.w,
                  child: Text(
                    notifications.createTime,
                    style: TextStyle(
                      color: AppColors.primarySecondaryText,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
    ),
  );
}