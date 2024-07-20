import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/comment.dart';
import '../../../model/faculty.dart';
import '../../../model/user.dart';
import '../bloc/list_comment_post_group_blocs.dart';
import '../bloc/list_comment_post_group_events.dart';
import '../bloc/list_comment_post_group_states.dart';
import '../list_comment_post_group_controller.dart';

Widget listComment(BuildContext context, ScrollController _scrollController,
    String id) {
  String content =
      BlocProvider.of<ListCommentPostGroupBloc>(context).state.content;
  Comment? comment =
      BlocProvider.of<ListCommentPostGroupBloc>(context).state.children;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<ListCommentPostGroupBloc>(context)
                  .state
                  .comments
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<ListCommentPostGroupBloc>(context)
                .state
                .statusComment) {
              case Status.loading:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                      height: 1.h,
                      color: AppColors.elementLight,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<ListCommentPostGroupBloc>(context)
                    .state
                    .comments
                    .isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                        height: 1.h,
                        color: AppColors.elementLight,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<ListCommentPostGroupBloc>(context)
                        .state
                        .comments
                        .length) {
                  if (BlocProvider.of<ListCommentPostGroupBloc>(context)
                      .state
                      .hasReachedMaxComment) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                          height: 1.h,
                          color: AppColors.elementLight,
                        ),
                        buildCommentWidget(
                            context,
                            BlocProvider.of<ListCommentPostGroupBloc>(context)
                                .state
                                .comments[index],
                            0,
                            id),
                      ],
                    );
                  } else {
                    return buildCommentWidget(
                        context,
                        BlocProvider.of<ListCommentPostGroupBloc>(context)
                            .state
                            .comments[index],
                        0,
                        id);
                  }
                }
            }
          },
        ),
      ),
      navigation(context, content, comment, id, (value) {
        context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
      })
    ],
  );
}

Widget buildCommentWidget(
    BuildContext context, Comment comment, int index, String id) {
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
                        maxWidth: (280 - (index == 2 ? 100 : 0 + index == 1 ? 55 : 0)).w,
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
                                  fontSize: 12.sp,
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
                                fontSize: 12.sp,
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
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                          Container(
                            width: 20.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ListCommentPostGroupBloc>()
                                  .add(ChildrenEvent(comment));
                              context
                                  .read<ListCommentPostGroupBloc>()
                                  .add(ReplyEvent(1));
                            },
                            child: Text(
                              translate('reply'),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 11.sp,
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
                                  onTap: () {
                                    context
                                        .read<ListCommentPostGroupBloc>()
                                        .add(ChildrenEvent(comment));
                                    context
                                        .read<ListCommentPostGroupBloc>()
                                        .add(ContentEvent(comment.content));
                                    context
                                        .read<ListCommentPostGroupBloc>()
                                        .add(ReplyEvent(2));
                                  },
                                  child: Text(
                                    translate('edit'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp,
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
                                    ListCommentPostGroupController(context: context)
                                        .handleDeleteComment(id, comment.id);
                                  },
                                  child: Text(
                                    translate('delete'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp,
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
                                fontSize: 12.sp,
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
                                  onTap: () {
                                    context
                                        .read<ListCommentPostGroupBloc>()
                                        .add(ChildrenEvent(comment));
                                    context
                                        .read<ListCommentPostGroupBloc>()
                                        .add(ContentEvent(comment.content));
                                    context
                                        .read<ListCommentPostGroupBloc>()
                                        .add(ReplyEvent(2));
                                  },
                                  child: Text(
                                    translate('edit'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp,
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
                                    ListCommentPostGroupController(context: context)
                                        .handleDeleteComment(id, comment.id);
                                  },
                                  child: Text(
                                    translate('delete'),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 11.sp,
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
            padding: EdgeInsets.only(left: index == 1 ? 45.w : 60.w, bottom: 10.h),
            child: Column(
              children: [
                for (int i = 0; i < comment.childrenComments.length; i += 1)
                  IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(width: 1, color: Colors.grey),
                          // This is divider
                          Container(
                              child: buildCommentWidget(context,
                                  comment.childrenComments[i], index + 1, id)),
                        ],
                      ))
              ],
            ),
          ),
        if (comment.childrenComments.length !=
            comment.childrenCommentNumber)
          GestureDetector(
            onTap: () {
              ListCommentPostGroupController(context: context)
                  .handleGetChildrenComment(comment);
            },
            child: Container(
              margin: EdgeInsets.only(left: index == 1 ? 45.w : 55.w),
              child: Text(
                '${translate('see')} ${comment.childrenCommentNumber - comment.childrenComments.length} ${translate('comments').toLowerCase()}',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12.sp,
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

Widget buildTextFieldContent(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 290.w,
      margin: EdgeInsets.only(top: 2.h, left: 10.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: Color.fromARGB(255, 245, 245, 245),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            width: 260.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<ListCommentPostGroupBloc>(context)
                  .state
                  .content,
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
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget navigation(BuildContext context, String content, Comment? comment,
    String id, void Function(String value)? func) {
  return Container(
    child: Column(
      children: [
        if (BlocProvider.of<ListCommentPostGroupBloc>(context).state.reply ==
            0)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTextFieldContent(
                    context, translate('your_comment'), 'comment', '', (value) {
                  context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
                }),
                GestureDetector(
                  onTap: () {
                    if (content != "") {
                      ListCommentPostGroupController(context: context)
                          .handleLoadWriteComment(id);
                    }
                  },
                  child: SvgPicture.asset(
                    "assets/icons/send.svg",
                    width: 20.w,
                    height: 20.h,
                    color: content != ""
                        ? AppColors.element
                        : Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        if (BlocProvider.of<ListCommentPostGroupBloc>(context).state.reply ==
            1)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w, bottom: 2.h),
                      child: Text(
                        translate('replying_to'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                          color: AppColors.secondaryHeader,
                        ),
                      ),
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      comment!.creator.fullName,
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: AppColors.secondaryHeader,
                      ),
                    ),
                    Container(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ReplyEvent(0));
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ContentEvent(''));
                      },
                      child: Text(
                        '- ${translate('cancel')}',
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTextFieldContent(
                        context, translate('your_comment'), 'comment', '', (value) {
                      context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: () {
                        if (content != "") {
                          ListCommentPostGroupController(context: context)
                              .handleLoadWriteChildrenComment(
                              id,
                              BlocProvider.of<ListCommentPostGroupBloc>(
                                  context)
                                  .state
                                  .children!
                                  .id);
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/send.svg",
                        width: 20.w,
                        height: 20.h,
                        color: content != ""
                            ? AppColors.element
                            : Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (BlocProvider.of<ListCommentPostGroupBloc>(context).state.reply ==
            2)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w, bottom: 2.h),
                      child: Text(
                        translate('edit_comment'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                          color: AppColors.secondaryHeader,
                        ),
                      ),
                    ),
                    Container(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ReplyEvent(0));
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ContentEvent(''));
                      },
                      child: Text(
                        '- ${translate('cancel')}',
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTextFieldContent(
                        context, translate('your_comment'), 'comment', '', (value) {
                      context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: BlocProvider.of<ListCommentPostGroupBloc>(context)
                          .state
                          .reply ==
                          1
                          ? () {
                        if (content != "") {
                          ListCommentPostGroupController(
                              context: context)
                              .handleLoadWriteChildrenComment(
                              id,
                              BlocProvider.of<
                                  ListCommentPostGroupBloc>(
                                  context)
                                  .state
                                  .children!
                                  .id);
                        }
                      }
                          : () {
                        if (content != "") {
                          ListCommentPostGroupController(
                              context: context)
                              .handleEditComment(
                              id,
                              BlocProvider.of<
                                  ListCommentPostGroupBloc>(
                                  context)
                                  .state
                                  .children!
                                  .id);
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/send.svg",
                        width: 20.w,
                        height: 20.h,
                        color: content != ""
                            ? AppColors.element
                            : Colors.black.withOpacity(0.5),
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
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 5.w,
          ),
          Text(
            translate('comment'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header,
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
