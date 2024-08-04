import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/model/participant.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';

import '../../../common/function/handle_html_content.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/event_detail_blocs.dart';
import '../bloc/event_detail_states.dart';
import '../event_detail_controller.dart';
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
          translate('event'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium(context).wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buildButtonChooseInfoOrParticipant(
    BuildContext context, void Function(int value)? func) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => func!(0),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('information'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<EventDetailBloc>(context).state.page != 1
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<EventDetailBloc>(context).state.page != 1)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => func!(1),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('participants'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<EventDetailBloc>(context).state.page == 1
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<EventDetailBloc>(context).state.page == 1)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget eventContent(BuildContext context, Event event) {
  String htmlContent = event.content;
  String htmlFix = '';
  htmlFix = handleHtmlContent(htmlContent);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        width: 340.w,
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(event.thumbnail),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Text(
          "${translate('faculty_of')} " + event.faculty.name,
          style: AppTextStyle.small(context).withColor(AppColors.textGrey),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Text(
          event.title,
          style: AppTextStyle.large(context).wSemiBold(),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 3.h, left: 10.w),
        child: Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.clockIconS,
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.textGrey,
                ),
                Container(
                  width: 5.w,
                ),
                Text(
                  handleDateTime1(event.publishedAt),
                  style: AppTextStyle.small(context),
                ),
              ],
            ),
            Container(
              width: 10.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.viewIconS,
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.textGrey,
                ),
                Container(
                  width: 5.w,
                ),
                Text(
                  event.views.toString(),
                  maxLines: 2,
                  style: AppTextStyle.small(context),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.tagIconS,
              width: 12.w,
              height: 12.h,
              color: AppColors.textGrey,
            ),
            Container(
              margin: EdgeInsets.only(left: 2.w),
              width: 300.w,
              child: Text(
                event.tags.map((tag) => tag.name).join(' '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.small(context).withColor(AppColors.tag),
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.locationIconS,
              width: 12.w,
              height: 12.h,
              color: AppColors.red,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Container(
                        width: 65.w, // Đặt chiều rộng cụ thể tại đây
                        child: Text(
                          '${translate('location')}: ',
                          style: AppTextStyle.small(context),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: event.organizationLocation,
                      style: AppTextStyle.small(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.timeIconS,
                width: 12.w,
                height: 12.h,
                color: AppColors.timeIcon,
              ),
              Container(
                width: 5.w,
              ),
              Container(
                width: 60.w,
                child: Text(
                  '${translate('time')}:',
                  maxLines: 1,
                  style: AppTextStyle.small(context),
                ),
              ),
              Container(
                width: 5.w,
              ),
              Text(
                handleDateTime1(event.organizationTime),
                maxLines: 1,
                style: AppTextStyle.small(context),
              ),
            ],
          )),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.participantIconS,
              width: 50.w,
              height: 50.h,
              color: AppColors.textGrey,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  event.participants.toString(),
                  style: AppTextStyle.base(context)
                      .wSemiBold()
                      .withColor(AppColors.element),
                ),
                Text(
                  translate('participants'),
                  style: AppTextStyle.base(context)
                      .wSemiBold()
                      .withColor(AppColors.textGrey),
                ),
              ],
            )
          ],
        ),
      ),
      if (Global.storageService.permissionEventParticipantCreate())
        Center(
          child: event.isParticipated
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 230, 230, 230),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    minimumSize: Size(165.w, 30.h),
                    padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  ),
                  onPressed: () {
                    if (!BlocProvider.of<EventDetailBloc>(context)
                        .state
                        .isLoading) {
                      EventDetailController(context: context)
                          .handleExitEvent(event.id);
                    }
                  },
                  child: Text(
                    translate('cancel'),
                    style: AppTextStyle.small(context).wSemiBold(),
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.background,
                    backgroundColor: AppColors.element,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                    minimumSize: Size(165.w, 30.h),
                    padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  ),
                  onPressed: () {
                    if (!BlocProvider.of<EventDetailBloc>(context)
                        .state
                        .isLoading) {
                      EventDetailController(context: context)
                          .handleJoinEvent(event.id);
                    }
                  },
                  child: Text(
                    translate('join'),
                    style: AppTextStyle.small(context)
                        .wSemiBold()
                        .withColor(AppColors.background),
                  ),
                ),
        ),
      if (!Global.storageService.permissionEventParticipantCreate())
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.element,
              backgroundColor: Color.fromARGB(255, 230, 230, 230),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w),
              ),
              minimumSize: Size(200.w, 30.h),
              padding: EdgeInsets.only(
                  top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/myProfileEdit",
              );
            },
            child: Text(
              'Cần xét duyệt để tham gia',
              style: AppTextStyle.small(context).wSemiBold().withColor(AppColors.textBlack.withOpacity(0.5)),
            ),
          ),
        ),
      Container(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        child: Text(
          translate('detail'),
          style: AppTextStyle.medium(context).wSemiBold(),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
        child: Text(
          event.content,
          style: AppTextStyle.small(context),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100.w,
            ),
            Text(
              event.creator.fullName,
              style: AppTextStyle.base(context),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget detail(
    BuildContext context, Event? event, ScrollController _scrollController) {
  if (event == null) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: ListView(
        controller: _scrollController,
        children: [
          buildButtonChooseInfoOrParticipant(context, (value) {
            context.read<EventDetailBloc>().add(PageEvent(value));
          }),
          loadingWidget()
        ],
      )),
    ]);
  } else {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: ListView(
        controller: _scrollController,
        children: [
          buildButtonChooseInfoOrParticipant(context, (value) {
            context.read<EventDetailBloc>().add(PageEvent(value));
          }),
          eventContent(context, event),
          listComment(context, event,
              BlocProvider.of<EventDetailBloc>(context).state.comments),
          // listRelatedEvent(context,
          //     BlocProvider.of<EventDetailBloc>(context).state.relatedEvent)
        ],
      )),
    ]);
  }
}

Widget listComment(
    BuildContext context, Event? event, List<Comment> commentList) {
  if (event == null) {
    return Column(
      children: [],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 340.w,
          height: 40.h,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black.withOpacity(0.5),
              backgroundColor: Color.fromARGB(255, 245, 245, 245),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w),
              ),
              side: BorderSide(
                color: Colors.transparent,
              ),
              padding: EdgeInsets.zero, // Remove default padding
            ),
            onPressed: () async {
              if (Global.storageService.permissionNewsCommentCreate()) {
                await Navigator.pushNamed(
                  context,
                  "/eventDetailWriteComment",
                  arguments: {
                    "event": event,
                  },
                );
                EventDetailController(context: context)
                    .handleGetComment(event.id, 0);
              } else {
                Navigator.pushNamed(
                  context,
                  "/myProfileEdit",
                );
              }
            },
            child: Container(
              height: 20.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Global.storageService.permissionNewsCommentCreate()
                        ? translate('write_comment')
                        : 'Cần xét duyệt để bình luận',
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/send.svg",
                    width: 15.w,
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.h, left: 10.w, bottom: 10.h),
          child: Text(
            "${translate('comment')} (${event.childrenCommentNumber})",
            style: AppTextStyle.large(context).wSemiBold(),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < commentList.length; i += 1)
              buildCommentWidget(context, event, commentList[i], 0)
          ],
        ),
        if (event.childrenCommentNumber > 5 &&
            !BlocProvider.of<EventDetailBloc>(context)
                .state
                .hasReachedMaxComment)
          Container(
            width: 340.w,
            height: 40.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 43, 107, 182),
                backgroundColor: Color.fromARGB(255, 230, 240, 251),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                padding: EdgeInsets.zero,
                side: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              onPressed: () {
                if (!BlocProvider.of<EventDetailBloc>(context)
                    .state
                    .isLoading) {
                  EventDetailController(context: context).handleGetComment(
                      event.id,
                      BlocProvider.of<EventDetailBloc>(context)
                          .state
                          .indexComment);
                }
              },
              child: Container(
                child: Center(
                  child: Text(
                    translate('more_comment'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 43, 107, 182),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Widget buildCommentWidget(
    BuildContext context, Event event, Comment comment, int index) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: index <= 0 ? 35.w : 25.w,
                height: index <= 0 ? 35.h : 25.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: GestureDetector(
                    onTap: () {
                      // Xử lý khi người dùng tap vào hình ảnh
                      if (comment.creator.id ==
                          Global.storageService.getUserId()) {
                        Navigator.pushNamed(
                          context,
                          "/myProfilePage",
                        );
                      } else {
                        Navigator.pushNamed(context, "/otherProfilePage",
                            arguments: {
                              "id": comment.creator.id,
                            });
                      }
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                          NetworkImage(comment.creator.avatarUrl ?? ""),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhiteDark,
                      borderRadius: BorderRadius.circular(10.w),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: (280 -
                                (index == 2
                                    ? 100
                                    : 0 + index == 1
                                        ? 55
                                        : 0))
                            .w,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                comment.creator.fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 12.sp /
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: AppFonts.Header,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            // Khoảng cách giữa tên và nội dung
                            Text(
                              comment.content,
                              style: TextStyle(
                                color: AppColors.textBlack,
                                fontSize: 12.sp /
                                    MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (index <= 1)
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0.w),
                            child: Text(
                              handleTimeDifference3(comment.createAt),
                              maxLines: 1,
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12.sp /
                                    MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                          Container(
                            width: 20.w,
                          ),
                          if (Global.storageService
                              .permissionNewsCommentCreate())
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      "/eventDetailWriteChildrenComment",
                                      arguments: {
                                        "event": event,
                                        "comment": comment,
                                      },
                                    );
                                    EventDetailController(context: context)
                                        .handleGetComment(event.id, 0);
                                  },
                                  child: Text(
                                    translate('reply'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: AppFonts.Header,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20.w,
                                ),
                              ],
                            ),
                          if (comment.permissions.edit)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      "/eventDetailEditComment",
                                      arguments: {
                                        "event": event,
                                        "comment": comment,
                                      },
                                    );
                                    EventDetailController(context: context)
                                        .handleGetComment(event.id, 0);
                                  },
                                  child: Text(
                                    translate('edit'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: AppFonts.Header,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20.w,
                                ),
                              ],
                            ),
                          if (comment.permissions.delete)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    EventDetailController(context: context)
                                        .handleDeleteComment(
                                            event.id, comment.id);
                                  },
                                  child: Text(
                                    translate('delete'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: AppFonts.Header,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (!Global.storageService
                              .permissionNewsCommentCreate())
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/myProfileEdit",
                                    );
                                  },
                                  child: Text(
                                    'Cần xét duyệt để bình luận',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 11.sp /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: AppFonts.Header,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20.w,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  if (index > 1 &&
                      (comment.permissions.edit || comment.permissions.delete))
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.w),
                            child: Text(
                              handleTimeDifference3(comment.createAt),
                              maxLines: 1,
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12.sp /
                                    MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                          Container(
                            width: 20.w,
                          ),
                          if (comment.permissions.edit)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      "/eventDetailEditComment",
                                      arguments: {
                                        "event": event,
                                        "comment": comment,
                                      },
                                    );
                                    EventDetailController(context: context)
                                        .handleGetComment(event.id, 0);
                                  },
                                  child: Text(
                                    translate('edit'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: AppFonts.Header,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20.w,
                                ),
                              ],
                            ),
                          if (comment.permissions.delete)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    EventDetailController(context: context)
                                        .handleDeleteComment(
                                            event.id, comment.id);
                                  },
                                  child: Text(
                                    translate('delete'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
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
              ),
            ],
          ),
        ),
        Container(
          height: 5.h,
        ),
        if (comment.childrenComments.length > 0)
          Container(
            padding:
                EdgeInsets.only(left: index == 1 ? 45.w : 60.w, bottom: 10.h),
            child: Column(
              children: [
                for (int i = 0; i < comment.childrenComments.length; i += 1)
                  IntrinsicHeight(
                      child: Row(
                    children: [
                      Container(width: 1, color: Colors.grey),
                      // This is divider
                      Container(
                          child: buildCommentWidget(context, event,
                              comment.childrenComments[i], index + 1)),
                    ],
                  ))
              ],
            ),
          ),
        if (comment.childrenComments.length != comment.childrenCommentNumber)
          GestureDetector(
            onTap: () {
              if (!BlocProvider.of<EventDetailBloc>(context).state.isLoading) {
                EventDetailController(context: context)
                    .handleGetChildrenComment(comment);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: index == 1 ? 45.w : 55.w),
              child: Text(
                '${translate('see')} ${comment.childrenCommentNumber - comment.childrenComments.length} ${translate('comments').toLowerCase()}',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppFonts.Header,
                ),
              ),
            ),
          )
      ],
    ),
  );
}

Widget listParticipant(
    BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<EventDetailBloc>(context)
                  .state
                  .participants
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<EventDetailBloc>(context)
                .state
                .statusParticipant) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChooseInfoOrParticipant(context, (value) {
                      context.read<EventDetailBloc>().add(PageEvent(value));
                    }),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<EventDetailBloc>(context)
                    .state
                    .participants
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChooseInfoOrParticipant(context, (value) {
                        context.read<EventDetailBloc>().add(PageEvent(value));
                      }),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_participants'),
                          style: AppTextStyle.small(context),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<EventDetailBloc>(context)
                        .state
                        .participants
                        .length) {
                  if (BlocProvider.of<EventDetailBloc>(context)
                      .state
                      .hasReachedMaxParticipant) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChooseInfoOrParticipant(context, (value) {
                          context.read<EventDetailBloc>().add(PageEvent(value));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        participant(
                            context,
                            BlocProvider.of<EventDetailBloc>(context)
                                .state
                                .participants[index]),
                      ],
                    );
                  } else {
                    return participant(
                        context,
                        BlocProvider.of<EventDetailBloc>(context)
                            .state
                            .participants[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget participant(BuildContext context, Participant participant) {
  return GestureDetector(
    onTap: () {
      if (participant.user.id == Global.storageService.getUserId()) {
        Navigator.pushNamed(
          context,
          "/myProfilePage",
        );
      } else {
        Navigator.pushNamed(context, "/otherProfilePage", arguments: {
          "id": participant.user.id,
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
                  backgroundImage: NetworkImage(participant.user.avatarUrl),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                participant.user.fullName,
                style: AppTextStyle.small(context).wSemiBold(),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
