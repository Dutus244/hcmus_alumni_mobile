import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../global.dart';
import '../../../model/event.dart';
import '../bloc/event_detail_write_comment_blocs.dart';
import '../bloc/event_detail_write_comment_events.dart';
import '../event_detail_write_comment_controller.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('event'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 320.w,
      height: 400.h,
      margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
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
                hintStyle: AppTextStyle.small().withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget header(Event event) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
        child: Text(
          event.title,
          style: AppTextStyle.base().wSemiBold(),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
        child: Text(
          translate('write_comment'),
          style: AppTextStyle.xLarge().wSemiBold(),
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
                    backgroundImage: NetworkImage(Global.storageService.getUserAvatarUrl()),
                  )),
            ),
            Text(
              Global.storageService.getUserFullName(),
              maxLines: 1,
              style: AppTextStyle.small().wSemiBold(),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buttonSend(BuildContext context, Event event) {
  String comment =
      BlocProvider.of<EventDetailWriteCommentBloc>(context).state.comment;
  return GestureDetector(
    onTap: () {
      if (comment != "") {
        EventDetailWriteCommentController(context: context)
            .handleLoadWriteComment(event.id);
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
                  style: AppTextStyle.base().wSemiBold().withColor(comment != ""
                      ? AppColors.background
                      : AppColors.textBlack.withOpacity(0.3)),
                ),
                Container(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  AppAssets.sendIconS,
                  width: 15.w,
                  height: 15.h,
                  color: comment != ""
                      ? AppColors.background
                      : AppColors.textBlack.withOpacity(0.5),
                ),
              ],
            ),
          )),
    ),
  );
}

Widget navigation(BuildContext context, Event event, int route, int profile) {
  String comment = BlocProvider.of<EventDetailWriteCommentBloc>(context)
      .state
      .comment;
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
                    "/eventDetail",
                        (route) => false,
                    arguments: {
                      "route": route,
                      "id": event.id,
                    },
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: AppColors.textBlack.withOpacity(0.5),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (comment != "") {
                    EventDetailWriteCommentController(context: context)
                        .handleLoadWriteComment(event.id);
                  }
                },
                child: Container(
                  width: 70.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: comment != ""
                        ? AppColors.element
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                      child: Container(
                    margin: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: Row(
                      children: [
                        Text(
                          translate('send'),
                          style: TextStyle(
                              fontFamily: AppFonts.Header,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: comment != ""
                                  ? AppColors.background
                                  : AppColors.textBlack.withOpacity(0.3)),
                        ),
                        Container(
                          width: 6.w,
                        ),
                        SvgPicture.asset(
                          AppAssets.sendIconS,
                          width: 15.w,
                          height: 15.h,
                          color: comment != ""
                              ? AppColors.background
                              : AppColors.textBlack.withOpacity(0.5),
                        ),
                      ],
                    ),
                  )),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget eventDetailWriteComment(BuildContext context, Event event) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(event),
            buildTextField(translate('your_comment'), 'comment', '',
                    (value) {
                  context
                      .read<EventDetailWriteCommentBloc>()
                      .add(CommentEvent(value));
                }),
          ],
        ),
      ),
     buttonSend(context, event)
    ],
  );
}
