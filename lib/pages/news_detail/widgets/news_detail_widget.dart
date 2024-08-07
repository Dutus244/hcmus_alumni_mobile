import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
          translate('news'),
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
            "${translate('faculty_of')} " + news.faculty.name,
            style: TextStyle(
              fontFamily: AppFonts.Header,
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
              fontFamily: AppFonts.Header,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: getTitleFontSize(
                  BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 3.h, left: 10.w),
          child: Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/clock.svg",
                    width: 12.w,
                    height: 12.h,
                    color: AppColors.textGrey,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    handleDateTime1(news.publishedAt),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
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
                    color: AppColors.textGrey,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    news.views.toString(),
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
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
          padding: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/tag.svg",
                width: 12.w,
                height: 12.h,
                color: AppColors.textGrey,
              ),
              for (int i = 0; i < news.tags.length; i += 1)
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: Text(
                    news.tags[i].name,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 5, 90, 188),
                    ),
                  ),
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
                  fontFamily: AppFonts.Header,
                  color: Color.fromARGB(255, 51, 58, 73),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
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
    BuildContext context, News? news, List<Comment> commentList) {
  if (news == null) {
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
                  "/newsDetailWriteComment",
                  arguments: {
                    "news": news,
                  },
                );
                NewsDetailController(context: context)
                    .handleGetComment(news.id, 0);
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
                        : 'Xét duyệt để bình luận',
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
            "${translate('comment')} (${news.childrenCommentNumber})",
            style: TextStyle(
              fontFamily: AppFonts.Header,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < commentList.length; i += 1)
              buildCommentWidget(context, news, commentList[i], 0)
          ],
        ),
        if (news.childrenCommentNumber > 5 &&
            !BlocProvider.of<NewsDetailBloc>(context)
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
                if (!BlocProvider.of<NewsDetailBloc>(context).state.isLoading) {
                  NewsDetailController(context: context).handleGetComment(
                    news.id,
                    BlocProvider.of<NewsDetailBloc>(context).state.indexComment,
                  );
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
        Container(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
          height: 2.h,
          color: AppColors.elementLight,
        )
      ],
    );
  }
}

Widget buildCommentWidget(
    BuildContext context, News news, Comment comment, int index) {
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
                                      "/newsDetailWriteChildrenComment",
                                      arguments: {
                                        "news": news,
                                        "comment": comment,
                                      },
                                    );
                                    NewsDetailController(context: context)
                                        .handleGetComment(news.id, 0);
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
                                      "/newsDetailEditComment",
                                      arguments: {
                                        "news": news,
                                        "comment": comment,
                                      },
                                    );
                                    NewsDetailController(context: context)
                                        .handleGetComment(news.id, 0);
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
                                    NewsDetailController(context: context)
                                        .handleDeleteComment(
                                            news.id, comment.id);
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
                                    'Xét duyệt để bình luận',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
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
                                      "/newsDetailEditComment",
                                      arguments: {
                                        "news": news,
                                        "comment": comment,
                                      },
                                    );
                                    NewsDetailController(context: context)
                                        .handleGetComment(news.id, 0);
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
                                    NewsDetailController(context: context)
                                        .handleDeleteComment(
                                            news.id, comment.id);
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
                          child: buildCommentWidget(context, news,
                              comment.childrenComments[i], index + 1)),
                    ],
                  ))
              ],
            ),
          ),
        if (comment.childrenComments.length != comment.childrenCommentNumber)
          GestureDetector(
            onTap: () {
              if (!BlocProvider.of<NewsDetailBloc>(context).state.isLoading) {
                NewsDetailController(context: context)
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

Widget listRelatedNews(BuildContext context, List<News> newsList) {
  if (newsList.isEmpty) {
    return Container();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 10.h),
        child: Text(
          translate('related_news'),
          style: TextStyle(
            fontFamily: AppFonts.Header,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
      Navigator.pushNamed(
        context,
        "/newsDetail",
        arguments: {
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
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      handleDateTime1(news.publishedAt),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize:
                            10.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textGrey,
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
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      news.views.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize:
                            10.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textGrey,
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
                  color: AppColors.textGrey,
                ),
                for (int i = 0; i < news.tags.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Text(
                      news.tags[i].name,
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize:
                            10.sp / MediaQuery.of(context).textScaleFactor,
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
                fontFamily: AppFonts.Header,
                fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
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
                fontFamily: AppFonts.Header,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.normal,
                color: AppColors.textBlack,
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
                      color: Colors.grey,
                    ),
                    child: Text(
                      news.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            11.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header,
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
            color: AppColors.elementLight,
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
          color: AppColors.elementLight,
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
                            translate('choose_font_size'),
                            style: TextStyle(
                              fontFamily: AppFonts.Header,
                              fontSize: 16.sp /
                                  MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.normal,
                              color: AppColors.element,
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
                              color: AppColors.elementLight,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/aa.svg",
                              width: 10.w,
                              height: 10.h,
                              color: AppColors.element,
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
                              activeColor: AppColors.element,
                              inactiveColor: AppColors.elementLight,
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
                                  color: AppColors.elementLight,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/aa_big.svg",
                                  width: 10.w,
                                  height: 10.h,
                                  color: AppColors.element,
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
                                    color: AppColors.elementLight,
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/refresh.svg",
                                    width: 10.w,
                                    height: 10.h,
                                    color: AppColors.element,
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

Widget newsDetail(BuildContext context) {
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
                BlocProvider.of<NewsDetailBloc>(context).state.comments),
            listRelatedNews(context,
                BlocProvider.of<NewsDetailBloc>(context).state.relatedNews),
          ],
        ),
      ),
      // Container nằm dưới cùng của màn hình
    ],
  );
}
