import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import '../../../model/news.dart';
import '../bloc/news_detail_write_comment_blocs.dart';
import '../bloc/news_detail_write_comment_events.dart';
import '../news_detail_write_comment_controller.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
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

Widget buildTextField(BuildContext context, String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 320.w,
      height: 350.h,
      margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 300.w,
            height: 350.h,
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
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget header(BuildContext context, News news) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
        child: Text(
          news.title,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
        child: Text(
          translate('write_comment'),
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 20.sp / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
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
                        NetworkImage(Global.storageService.getUserAvatarUrl()),
                  )),
            ),
            Text(
              Global.storageService.getUserFullName(),
              maxLines: 1,
              style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.Header,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buttonSend(BuildContext context, News news) {
  String comment =
      BlocProvider.of<NewsDetailWriteCommentBloc>(context).state.comment;
  return GestureDetector(
    onTap: () {
      if (comment != "") {
        NewsDetailWriteCommentController(context: context)
            .handleLoadWriteComment(news.id);
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: comment != ""
            ? AppColors.element
            : AppColors.background,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
        ),
      ),
      child: Center(
          child: Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translate('send'),
              style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: comment != ""
                      ? AppColors.background
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
                  ? AppColors.background
                  : Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      )),
    ),
  );
}

Widget newsDetailWriteComment(BuildContext context, News news) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(context, news),
            buildTextField(context, translate('your_comment'), 'comment', '', (value) {
              context
                  .read<NewsDetailWriteCommentBloc>()
                  .add(CommentEvent(value));
            }),
          ],
        ),
      ),
      buttonSend(context, news),
    ],
  );
}
