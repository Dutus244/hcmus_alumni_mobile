import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/model/notification.dart';

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
  return Container(
    child: Row(
      children: [

      ],
    ),
  );
}