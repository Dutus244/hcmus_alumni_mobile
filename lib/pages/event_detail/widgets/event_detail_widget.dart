import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/model/participant.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';

import '../../../common/function/handle_html_content.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../bloc/event_detail_blocs.dart';
import '../bloc/event_detail_states.dart';
import '../event_detail_controller.dart';

AppBar buildAppBar(BuildContext context, int route) {
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
                  "/applicationPage", (route) => false,
                  arguments: {"route": route, "secondRoute": 1});
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
            'Sự kiện',
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
              children: [

              ],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget buildButtonChooseInfoOrParticipant(
    BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => func!(0),
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<EventDetailBloc>(context).state.page == 1
                  ? AppColors.primarySecondaryElement
                  : AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Thông tin',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<EventDetailBloc>(context).state.page ==
                                1
                            ? AppColors.primaryElement
                            : AppColors.primaryBackground),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => func!(1),
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<EventDetailBloc>(context).state.page == 1
                  ? AppColors.primaryElement
                  : AppColors.primarySecondaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Người tham gia',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<EventDetailBloc>(context).state.page ==
                                1
                            ? AppColors.primaryBackground
                            : AppColors.primaryElement),
              ),
            ),
          ),
        )
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
          "Khoa " + event.faculty.name,
          style: TextStyle(
            fontFamily: AppFonts.Header3,
            color: Color.fromARGB(255, 51, 58, 73),
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Text(
          event.title,
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/clock.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.primarySecondaryText,
                ),
                Container(
                  width: 5.w,
                ),
                Text(
                  handleDatetime(event.publishedAt),
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
            Container(
              width: 10.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/view.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.primarySecondaryText,
                ),
                Container(
                  width: 5.w,
                ),
                Text(
                  event.views.toString(),
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/location.svg",
              width: 12.w,
              height: 12.h,
              color: Color.fromARGB(255, 255, 95, 92),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Địa điểm: ',
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
                      ),
                    ),
                    TextSpan(
                      text: event.organizationLocation,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
                      ),
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
                "assets/icons/time.svg",
                width: 12.w,
                height: 12.h,
                color: Color.fromARGB(255, 153, 214, 216),
              ),
              Container(
                width: 5.w,
              ),
              Text(
                'Thời gian:',
                maxLines: 1,
                style: TextStyle(
                  fontFamily: AppFonts.Header3,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 63, 63, 70),
                ),
              ),
              Container(
                width: 5.w,
              ),
              Text(
                handleDatetime(event.organizationTime),
                maxLines: 1,
                style: TextStyle(
                  fontFamily: AppFonts.Header3,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 63, 63, 70),
                ),
              ),
            ],
          )),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/participant.svg",
              width: 50.w,
              height: 50.h,
              color: AppColors.primarySecondaryText,
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
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    color: AppColors.primaryElement,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'Người tham gia',
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    color: AppColors.primarySecondaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      Center(
        child: BlocProvider.of<EventDetailBloc>(context).state.isParticipated
            ? GestureDetector(
                onTap: () {
                  EventDetailController(context: context)
                      .hanldeExitEvent(event.id);
                },
                child: Container(
                  width: 165.w,
                  height: 30.h,
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: AppColors.primaryElement,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Bỏ tham gia',
                      style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryElement),
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  EventDetailController(context: context)
                      .hanldeJoinEvent(event.id);
                },
                child: Container(
                  width: 165.w,
                  height: 30.h,
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Tham gia ngay',
                      style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBackground),
                    ),
                  ),
                ),
              ),
      ),
      Container(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        child: Text(
          'Thông tin chi tiết',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
        child: Html(
          data: htmlFix,
          style: {
            "span": Style(fontSize: FontSize.medium, fontFamily: "Roboto")
          },
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
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                color: Color.fromARGB(255, 51, 58, 73),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 10.h, left: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/tag.svg",
              width: 12.w,
              height: 12.h,
              color: AppColors.primarySecondaryText,
            ),
            for (int i = 0; i < event.tags.length; i += 1)
              Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Text(
                  event.tags[i].name,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 5, 90, 188),
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

Widget detail(BuildContext context, Event? event,
    ScrollController _scrollController, int route) {
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
              BlocProvider.of<EventDetailBloc>(context).state.comments, route),
          // listRelatedEvent(context,
          //     BlocProvider.of<EventDetailBloc>(context).state.relatedEvent)
        ],
      )),
    ]);
  }
}

Widget listComment(
    BuildContext context, Event? event, List<Comment> commentList, int route) {
  if (event == null) {
    return Column(
      children: [],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/eventDetailWriteComment",
              (route) => false,
              arguments: {
                "route": route,
                "event": event,
              },
            );
          },
          child: Container(
              width: 340.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: Color.fromARGB(255, 245, 245, 245),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Container(
                height: 20.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Viết bình luận',
                      style: TextStyle(
                        fontFamily: AppFonts.Header2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/send.svg",
                      width: 15.w,
                      height: 15.h,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.h, left: 10.w, bottom: 10.h),
          child: Text(
            "Bình luận (${event.childrenCommentNumber})",
            style: TextStyle(
              fontFamily: AppFonts.Header1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < commentList.length; i += 1)
              buildCommentWidget(context, event, commentList[i], 0, route)
          ],
        ),
        if (event.childrenCommentNumber > 5 &&
            !BlocProvider.of<EventDetailBloc>(context)
                .state
                .hasReachedMaxComment)
          GestureDetector(
            onTap: () {
              EventDetailController(context: context).handleGetComment(event.id,
                  BlocProvider.of<EventDetailBloc>(context).state.indexComment);
            },
            child: Container(
              width: 340.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: Color.fromARGB(255, 230, 240, 251),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  'Xem thêm bình luận',
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 43, 107, 182),
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
    BuildContext context, Event event, Comment comment, int index, int route) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 35.h,
          margin: EdgeInsets.only(top: 5.h),
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 35.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: GestureDetector(
                    onTap: () {
                      // Xử lý khi người dùng tap vào hình ảnh
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                      NetworkImage(comment.creator.avatarUrl ?? ""),
                    )),
              ),
              Container(
                width: 270.w,
                height: 35.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: Text(
                        comment.creator.fullName,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                        handleDatetime(comment.updateAt),
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.primarySecondaryText,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.Header3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 5.h,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          width: (340 - 10 * index).w,
          child: Text(
            comment.content,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              fontFamily: AppFonts.Header3,
            ),
          ),
        ),
        if (index <= 1)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        EventDetailController(context: context)
                            .handleGetChildrenComment(comment.id);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/comment.svg",
                              width: 11.w,
                              height: 11.h,
                              color: Colors.black.withOpacity(0.8),
                            ),
                            Container(
                              width: 3.w,
                            ),
                            Text(
                              "${comment.childrenCommentNumber.toString()} trả lời",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 50.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          "/eventDetailWriteChildrenComment",
                              (route) => false,
                          arguments: {
                            "route": route,
                            "event": event,
                            "comment": comment,
                          },
                        );
                      },
                      child: Text(
                        'Trả lời',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ),
                    if (comment.permissions.edit)
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "/eventDetailEditComment",
                                    (route) => false,
                                arguments: {
                                  "route": route,
                                  "event": event,
                                  "comment": comment,
                                },
                              );
                            },
                            child: Text(
                              'Chỉnh sửa',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (comment.permissions.delete)
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              EventDetailController(context: context).handleDeleteComment(event.id, comment.id);
                            },
                            child: Text(
                              'Xoá',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header2,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            children: [
              for (int i = 0; i < comment.childrenComments.length; i += 1)
                IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(width: 1, color: Colors.black),
                        // This is divider
                        Container(
                            child: buildCommentWidget(context, event,
                                comment.childrenComments[i], index + 1, route)),
                      ],
                    ))
            ],
          ),
        ),
      ],
    ),
  );
}

Widget listRelatedEvent(BuildContext context, List<Event> eventList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 10.h),
        child: Text(
          "Tin tức liên quan",
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < eventList.length; i += 1)
            Container(
              padding: EdgeInsets.only(left: 0.w, right: 0.w),
              child: event(context, eventList[i]),
            ),
        ],
      )
    ],
  );
}

Widget event(BuildContext context, Event event) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/eventDetail",
        (route) => false,
        arguments: {"route": 1, "event": event},
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      handleDatetime(event.publishedAt),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 10.w,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/view.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.views.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 10.w,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/participant.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.participants.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/tag.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.primarySecondaryText,
                ),
                for (int i = 0; i < event.tags.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Text(
                      event.tags[i].name,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 5, 90, 188),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 3.h),
              height: 15.h,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    width: 12.w,
                    height: 12.h,
                    color: Color.fromARGB(255, 255, 95, 92),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Địa điểm:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Container(
                    width: 250.w,
                    child: Text(
                      event.organizationLocation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              height: 15.h,
              margin: EdgeInsets.only(top: 3.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/time.svg",
                    width: 12.w,
                    height: 12.h,
                    color: Color.fromARGB(255, 153, 214, 216),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Thời gian:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    handleDatetime(event.organizationTime),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Stack(
              children: [
                Container(
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 20.h,
                    margin: EdgeInsets.only(left: 10.w, top: 5.h),
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, bottom: 2.h, top: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      shape: BoxShape.rectangle,
                      color: AppColors.primaryElement,
                    ),
                    child: Text(
                      event.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10.h,
          ),
          Container(
            height: 1.h,
            color: AppColors.primarySecondaryElement,
          ),
          Container(
            height: 10.h,
          ),
        ],
      ),
    ),
  );
}

Widget listParticipant(
    BuildContext context, ScrollController _scrollController, int route) {
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
                          'Không có người tham gia',
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
                  backgroundImage: NetworkImage(participant.avatarUrl),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                participant.fullName,
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
    ),
  );
}

Widget navigation(BuildContext context, int route) {
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
                      "/applicationPage", (route) => false,
                      arguments: {"route": route, "secondRoute": 1});
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
