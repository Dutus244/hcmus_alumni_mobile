import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import '../../../model/news.dart';
import '../bloc/news_detail_write_children_comment_blocs.dart';
import '../bloc/news_detail_write_children_comment_events.dart';
import '../news_detail_write_children_comment_controller.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5.w,
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
            width: 60.w,
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 300.w,
      height: 300.h,
      margin: EdgeInsets.only(top: 5.h, left: 20.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 300.w,
            height: 400.h,
            child: TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget header(News news, Comment comment) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
        child: Text(
          news.title,
          style: TextStyle(
            fontFamily: AppFonts.Header1,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
        child: Text(
          'Gửi bình luận',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
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
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 5.h),
        child: Row(
          children: [
            Transform.rotate(
              angle: 1 * pi, // Xoay 90 độ
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(1, -1, 1), // Flip ngang
                child: SvgPicture.asset(
                  "assets/icons/enter.svg",
                  width: 11.w,
                  height: 11.h,
                  color: Colors.red[600],
                ),
              ),
            ),
            Container(
              width: 5.w,
            ),
            Text(
              'Gửi bình luận đến ${comment.creator.fullName}',
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                fontFamily: AppFonts.Header3,
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Row(
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              margin: EdgeInsets.only(left: 20.w, right: 10.w),
              child: GestureDetector(
                  onTap: () {
                    // Xử lý khi người dùng tap vào hình ảnh
                  },
                  child: CircleAvatar(
                    radius: 10,
                    child: null,
                    backgroundImage:
                        NetworkImage(Global.storageService.getUserAvatarUrl()),
                  )),
            ),
            Text(
              Global.storageService.getUserFullName(),
              maxLines: 1,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.Header2,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buttonSend(BuildContext context, News news, Comment Comment) {
  String comment = BlocProvider.of<NewsDetailWriteChildrenCommentBloc>(context)
      .state
      .comment;
  return GestureDetector(
    onTap: () {
      if (comment != "") {
        NewsDetailWriteChildrenCommentController(context: context)
            .handleLoadWriteComment(news.id, Comment.id);
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: comment != ""
            ? AppColors.primaryElement
            : AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.primarySecondaryElement,
        ),
      ),
      child: Center(
          child: Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gửi',
              style: TextStyle(
                  fontFamily: AppFonts.Header1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: comment != ""
                      ? AppColors.primaryBackground
                      : Colors.black.withOpacity(0.3)),
            ),
            Container(
              width: 6.w,
            ),
            SvgPicture.asset(
              "assets/icons/send.svg",
              width: 15.w,
              height: 15.h,
              color: comment != ""
                  ? AppColors.primaryBackground
                  : Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      )),
    ),
  );
}

Widget newsDetailWriteChildrenComment(
    BuildContext context, News news, Comment comment) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(news, comment),
            buildTextField('Bình luận của bạn', 'comment', '', (value) {
              context
                  .read<NewsDetailWriteChildrenCommentBloc>()
                  .add(CommentEvent(value));
            }),
          ],
        ),
      ),
      buttonSend(context, news, comment),
    ],
  );
}
