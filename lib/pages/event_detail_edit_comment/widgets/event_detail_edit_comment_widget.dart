import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/widgets/loading_widget.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../global.dart';
import '../../../model/event.dart';
import '../bloc/event_detail_edit_comment_blocs.dart';
import '../bloc/event_detail_edit_comment_events.dart';
import '../event_detail_edit_comment_controller.dart';
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
          style: AppTextStyle.medium(context).wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buildTextField(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func) {
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
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<EventDetailEditCommentBloc>(context).state.comment,
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
                hintStyle: AppTextStyle.small(context).withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget header(BuildContext context, Event event) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
        child: Text(
          event.title,
          style: AppTextStyle.base(context).wSemiBold(),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
        child: Text(
          translate('edit_comment'),
          style: AppTextStyle.xxLarge(context).wSemiBold(),
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
              style: AppTextStyle.small(context).wSemiBold(),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buttonEdit(BuildContext context, Event event, Comment Comment) {
  String comment =
      BlocProvider.of<EventDetailEditCommentBloc>(context).state.comment;
  return GestureDetector(
    onTap: () {
      if (comment != "") {
        EventDetailEditCommentController(context: context)
            .handleEditComment(event.id, Comment.id);
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
              translate('save'),
              style: AppTextStyle.base(context).wSemiBold().withColor(comment != ""
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

Widget eventDetailEditComment(BuildContext context, Event? event, Comment? comment) {
  if (event == null || comment == null) {
    return loadingWidget();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(context, event),
            buildTextField(context, translate('your_comment'), 'comment', '',
                (value) {
              context
                  .read<EventDetailEditCommentBloc>()
                  .add(CommentEvent(value));
            }),
          ],
        ),
      ),
      buttonEdit(context, event, comment),
    ],
  );
}
