import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/model/notification.dart';
import 'package:hcmus_alumni_mobile/pages/notification_page/notification_page_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../bloc/notification_page_blocs.dart';
import '../bloc/notification_page_states.dart';

Widget listNotifications(BuildContext context, ScrollController _scrollController) {
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
                              translate('no_notification'),
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
      NotificationPageController(context: context).handleSeenNotification(notifications.id);
      switch (notifications.entityTable) {
        case "request_friend":
          Navigator.pushNamedAndRemoveUntil(context,
              "/applicationPage", (route) => false,
              arguments: {"route": 4});
          break;
        case "comment_event":
         Navigator.pushNamed(context,
            "/eventDetail",
            arguments: {"id": notifications.parentId},
          );
          break;
        case "comment_news":
         Navigator.pushNamed(context,
            "/newsDetail",
            arguments: {"id": notifications.parentId},
          );
          break;
        case "group":
         Navigator.pushNamed(context,
            "/groupDetail",
            arguments: {"id": notifications.entityId},
          );
          break;
        case "request_join_group":
          switch (notifications.notificationType) {
            case "CREATE":
             Navigator.pushNamed(context,
                "/groupMemberApprove",
                arguments: {"groupId": notifications.entityId},
              );
              break;
            case "UPDATE":
             Navigator.pushNamed(context,
                "/groupDetail",
                arguments: {"id": notifications.entityId},
              );
              break;
          }
        case "interact_post_group":
         Navigator.pushNamed(context,
            "/postGroupDetail",
            arguments: {"id": notifications.entityId},
          );
          break;
        case "comment_post_group":
         Navigator.pushNamed(context,
            "/postGroupDetail",
            arguments: {"id": notifications.parentId},
          );
          break;
        case "interact_post_advise":
         Navigator.pushNamed(context,
            "/postAdviseDetail",
            arguments: {"id": notifications.entityId},
          );
          break;
        case "comment_post_advise":
         Navigator.pushNamed(context,
            "/postAdviseDetail",
            arguments: {"id": notifications.parentId},
          );
          break;
      }
    },
    child: Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
        color: notifications.status.name != "Chưa xem" ? Colors.transparent : AppColors.elementLight,
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              child: CircleAvatar(
                radius: 40,
                child: null,
                backgroundImage:
                NetworkImage(notifications.notificationImageUrl),
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
                  width: 270.w,
                  child: Text(
                    notifications.notificationMessage,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 12.sp,
                      fontWeight: notifications.status.name == "Chưa xem" ? FontWeight.bold : FontWeight.normal,
                      fontFamily: AppFonts.Header,
                    ),
                  ),
                ),
                Container(
                  height: 3.h,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 270.w,
                  child: Text(
                    handleDateTime1(notifications.createAt),
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 10.sp,
                      fontWeight:  notifications.status.name == "Chưa xem" ? FontWeight.bold : FontWeight.normal,
                      fontFamily: AppFonts.Header,
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