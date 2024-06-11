import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_states.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/news_detail_controller.dart';
import 'package:popover/popover.dart';

import '../../../common/function/handle_html_content.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/news.dart';
import '../bloc/news_detail_events.dart';

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
                  arguments: {"route": route, "secondRoute": 0});
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
            'Tin tức',
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

FontSize getContentFontSize(double value) {
  switch (value) {
    case 0:
      return FontSize.xxSmall;
    case 20:
      return FontSize.xSmall;
    case 40:
      return FontSize.medium;
    case 60:
      return FontSize.xLarge;
    case 80:
      return FontSize.xxLarge;
    default:
      return FontSize.medium;
  }
}

double getTimeFontSize(double value) {
  switch (value) {
    case 0:
      return 9.sp;
    case 20:
      return 10.sp;
    case 40:
      return 11.sp;
    case 60:
      return 12.sp;
    case 80:
      return 13.sp;
    default:
      return 11.sp;
  }
}

double getFacultyFontSize(double value) {
  switch (value) {
    case 0:
      return 10.sp;
    case 20:
      return 11.sp;
    case 40:
      return 12.sp;
    case 60:
      return 13.sp;
    case 80:
      return 14.sp;
    default:
      return 12.sp; // Trường hợp mặc định
  }
}

double getTitleFontSize(double value) {
  switch (value) {
    case 0:
      return 16.sp;
    case 20:
      return 17.sp;
    case 40:
      return 18.sp;
    case 60:
      return 19.sp;
    case 80:
      return 20.sp;
    default:
      return 18.sp; // Trường hợp mặc định
  }
}

String getLabelFontSize(double value) {
  switch (value) {
    case 0:
      return "Nhỏ nhất";
    case 20:
      return "Nhỏ";
    case 40:
      return "Bình thường";
    case 60:
      return "Lớn";
    case 80:
      return "Lớn nhất";
    default:
      return "Bình thường"; // Trường hợp mặc định
  }
}

Widget newsContent(BuildContext context, News? news) {
  if (news == null) {
    return loadingWidget();
  } else {
    String htmlContent = news.content;
    String htmlFix = '';
    htmlFix = handleHtmlContent(htmlContent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w),
          child: Text(
            "Khoa " + news.faculty.name,
            style: TextStyle(
              fontFamily: AppFonts.Header3,
              color: Color.fromARGB(255, 51, 58, 73),
              fontWeight: FontWeight.w500,
              fontSize: getFacultyFontSize(
                  BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Text(
            news.title,
            style: TextStyle(
              fontFamily: AppFonts.Header2,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: getTitleFontSize(
                  BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
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
                    handleDatetime(news.publishedAt),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: getTimeFontSize(
                          BlocProvider.of<NewsDetailBloc>(context)
                              .state
                              .fontSize),
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
                    news.views.toString(),
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontSize: getTimeFontSize(
                          BlocProvider.of<NewsDetailBloc>(context)
                              .state
                              .fontSize),
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
          padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
          child: Html(
            data: htmlFix,
            style: {
              "span": Style(
                  fontSize: getContentFontSize(
                      BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
                  fontFamily:
                      BlocProvider.of<NewsDetailBloc>(context).state.fontFamily)
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
                news.creator.fullName,
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
              for (int i = 0; i < news.tags.length; i += 1)
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: Text(
                    news.tags[i].name,
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
}

Widget listComment(
    BuildContext context, News? news, List<Comment> commentList, int route) {
  if (news == null) {
    return Column(
      children: [],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (Global.storageService.permissionNewsCommentCreate())
          GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/newsDetailWriteComment",
              (route) => false,
              arguments: {
                "route": route,
                "news": news,
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
            "Bình luận (${news.childrenCommentNumber})",
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
              buildCommentWidget(context, news, commentList[i], 0, route)
          ],
        ),
        if (news.childrenCommentNumber > 5 &&
            !BlocProvider.of<NewsDetailBloc>(context)
                .state
                .hasReachedMaxComment)
          GestureDetector(
            onTap: () {
              NewsDetailController(context: context).handleGetComment(news.id,
                  BlocProvider.of<NewsDetailBloc>(context).state.indexComment);
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
        Container(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
          height: 2.h,
          color: AppColors.primarySecondaryElement,
        )
      ],
    );
  }
}

Widget buildCommentWidget(
    BuildContext context, News news, Comment comment, int index, int route) {
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
                      margin: EdgeInsets.only(top: 0.h),
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
                      margin: EdgeInsets.only(bottom: 0.h),
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
                        NewsDetailController(context: context)
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
                                fontFamily: 'Roboto',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (Global.storageService.permissionNewsCommentCreate())
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "/newsDetailWriteChildrenComment",
                                    (route) => false,
                                arguments: {
                                  "route": route,
                                  "news": news,
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
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
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
                                "/newsDetailEditComment",
                                (route) => false,
                                arguments: {
                                  "route": route,
                                  "news": news,
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
                              NewsDetailController(context: context)
                                  .handleDeleteComment(news.id, comment.id);
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
        if (index > 1)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
            child: Row(
              children: [
                Row(
                  children: [
                    if (comment.permissions.edit)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "/newsDetailEditComment",
                                    (route) => false,
                                arguments: {
                                  "route": route,
                                  "news": news,
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
                              NewsDetailController(context: context)
                                  .handleDeleteComment(news.id, comment.id);
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
        if (comment.childrenComments.length > 0)
          Container(
            padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
            child: Column(
              children: [
                for (int i = 0; i < comment.childrenComments.length; i += 1)
                  IntrinsicHeight(
                      child: Row(
                    children: [
                      Container(width: 1, color: Colors.black),
                      // This is divider
                      Container(
                          child: buildCommentWidget(context, news,
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

Widget listRelatedNews(BuildContext context, List<News> newsList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 10.h),
        child: Text(
          "Bài viết liên quan",
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
          for (int i = 0; i < newsList.length; i += 1)
            Container(
              padding: EdgeInsets.only(left: 0.w, right: 0.w),
              child: news(context, newsList[i]),
            ),
        ],
      )
    ],
  );
}

Widget news(BuildContext context, News news) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/newsDetail",
        (route) => false,
        arguments: {
          "route": 1,
          "id": news.id,
        },
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
                      handleDatetime(news.publishedAt),
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
                      news.views.toString(),
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
                for (int i = 0; i < news.tags.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Text(
                      news.tags[i].name,
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
              news.title,
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
            height: 33.h,
            child: Text(
              news.summary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryText,
              ),
            ),
          ),
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
                      image: NetworkImage(news.thumbnail),
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
                      news.faculty.name,
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

Widget navigation(BuildContext context, int route) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          height: 1.h,
          color: AppColors.primarySecondaryElement,
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/applicationPage", (route) => false,
                      arguments: {"route": route, "secondRoute": 0});
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Row(
              //   children: [
              //     ButtonEditText(),
              //     Container(
              //       width: 20.w,
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: SvgPicture.asset(
              //         "assets/icons/comment.svg",
              //         width: 25.w,
              //         height: 25.h,
              //         color: Colors.black.withOpacity(0.5),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        )
      ],
    ),
  );
}

class ButtonEditText extends StatefulWidget {
  const ButtonEditText({Key? key}) : super(key: key);

  @override
  State<ButtonEditText> createState() => _ButtonEditTextState();
}

class _ButtonEditTextState extends State<ButtonEditText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) =>
              BlocBuilder<NewsDetailBloc, NewsDetailState>(
            builder: (context, state) {
              return Container(
                width: 350.w,
                height: 150.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chọn cỡ chữ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElement,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              width: 20.w,
                              height: 20.h,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              color: AppColors.primarySecondaryElement,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/aa.svg",
                              width: 10.w,
                              height: 10.h,
                              color: AppColors.primaryElement,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: BlocProvider.of<NewsDetailBloc>(context)
                                  .state
                                  .fontSize,
                              max: 80,
                              divisions: 4,
                              label: getLabelFontSize(
                                  BlocProvider.of<NewsDetailBloc>(context)
                                      .state
                                      .fontSize),
                              onChanged: (double value) {
                                BlocProvider.of<NewsDetailBloc>(context)
                                    .add(FontSizeEvent(value));
                              },
                              activeColor: AppColors.primaryElement,
                              inactiveColor: AppColors.primarySecondaryElement,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 30.w,
                                height: 30.h,
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: AppColors.primarySecondaryElement,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/aa_big.svg",
                                  width: 10.w,
                                  height: 10.h,
                                  color: AppColors.primaryElement,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<NewsDetailBloc>(context)
                                      .add(FontSizeResetEvent());
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: AppColors.primarySecondaryElement,
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/refresh.svg",
                                    width: 10.w,
                                    height: 10.h,
                                    color: AppColors.primaryElement,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      margin: EdgeInsets.only(top: 5.h),
                      color: AppColors.primarySecondaryElement,
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chọn font chữ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElement,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<NewsDetailBloc>(context)
                                  .add(FontFamilyEvent("Roboto"));
                            },
                            child: Container(
                              width: 140.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: BlocProvider.of<NewsDetailBloc>(context)
                                            .state
                                            .fontFamily !=
                                        "Roboto"
                                    ? AppColors.primarySecondaryElement
                                    : AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(15.w),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Roboto',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: BlocProvider.of<NewsDetailBloc>(
                                                      context)
                                                  .state
                                                  .fontFamily !=
                                              "Roboto"
                                          ? AppColors.primaryElement
                                          : AppColors.primaryBackground),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<NewsDetailBloc>(context)
                                  .add(FontFamilyEvent("Times New Roman"));
                            },
                            child: Container(
                              width: 140.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: BlocProvider.of<NewsDetailBloc>(context)
                                            .state
                                            .fontFamily ==
                                        "Roboto"
                                    ? AppColors.primarySecondaryElement
                                    : AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(15.w),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Times New Roman',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: BlocProvider.of<NewsDetailBloc>(
                                                      context)
                                                  .state
                                                  .fontFamily ==
                                              "Roboto"
                                          ? AppColors.primaryElement
                                          : AppColors.primaryBackground),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          onPop: () {},
          direction: PopoverDirection.top,
          width: 300.w,
          height: 160.h,
        );
      },
      child: SvgPicture.asset(
        "assets/icons/aa.svg",
        width: 25,
        height: 25,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}

Widget newsDetail(BuildContext context, int route) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            newsContent(
                context, BlocProvider.of<NewsDetailBloc>(context).state.news),
            listComment(
                context,
                BlocProvider.of<NewsDetailBloc>(context).state.news,
                BlocProvider.of<NewsDetailBloc>(context).state.comments,
                route),
            listRelatedNews(context,
                BlocProvider.of<NewsDetailBloc>(context).state.relatedNews),
          ],
        ),
      ),
      // Container nằm dưới cùng của màn hình
    ],
  );
}
