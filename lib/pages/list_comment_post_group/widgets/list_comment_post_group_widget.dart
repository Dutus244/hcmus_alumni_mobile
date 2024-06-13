import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/comment.dart';
import '../../../model/creator.dart';
import '../bloc/list_comment_post_group_blocs.dart';
import '../bloc/list_comment_post_group_events.dart';
import '../bloc/list_comment_post_group_states.dart';
import '../list_comment_post_group_controller.dart';

Widget listComment(BuildContext context, ScrollController _scrollController,
    String id, void Function(String value)? func) {
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
                      color: AppColors.primarySecondaryElement,
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
                        color: AppColors.primarySecondaryElement,
                      ),
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
                          color: AppColors.primarySecondaryElement,
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
      navigation(context, content, comment, id, func)
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
                        ListCommentPostAdviseController(context: context)
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
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ChildrenEvent(comment));
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ContentEvent(comment.content));
                        context
                            .read<ListCommentPostGroupBloc>()
                            .add(ReplyEvent(1));
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
                              ListCommentPostAdviseController(context: context)
                                  .handleDeleteComment(id, comment.id);
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
                              child: buildCommentWidget(context,
                                  comment.childrenComments[i], index + 1, id)),
                        ],
                      ))
              ],
            ),
          ),
      ],
    ),
  );
}

Widget buildTextFieldContent1(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 300.w,
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

Widget buildTextFieldContent2(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<ListCommentPostGroupBloc>(context)
          .state
          .content);

  return Container(
      width: 300.w,
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
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
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
                buildTextFieldContent1(
                    context, 'Bình luận của bạn', 'comment', '', (value) {
                  context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
                }),
                GestureDetector(
                  onTap: () {
                    if (content != "") {
                      ListCommentPostAdviseController(context: context)
                          .handleLoadWriteComment(id);
                    }
                  },
                  child: SvgPicture.asset(
                    "assets/icons/send.svg",
                    width: 15.w,
                    height: 15.h,
                    color: content != ""
                        ? AppColors.primaryElement
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
                        'Đang trả lời',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
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
                        fontFamily: AppFonts.Header2,
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
                        context.read<ListCommentPostGroupBloc>().add(
                            ChildrenEvent(Comment('', Creator('', '', ''), '',
                                0, '', '', Permissions(false, false))));
                      },
                      child: Text(
                        '- Huỷ',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppColors.primarySecondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTextFieldContent2(
                        context, 'Bình luận của bạn', 'comment', '', (value) {
                      context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: () {
                        if (content != "") {
                          ListCommentPostAdviseController(context: context)
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
                        width: 15.w,
                        height: 15.h,
                        color: content != ""
                            ? AppColors.primaryElement
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
                        'Chỉnh sửa bình luận',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
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
                        context.read<ListCommentPostGroupBloc>().add(
                            ChildrenEvent(Comment('', Creator('', '', ''), '',
                                0, '', '', Permissions(false, false))));
                      },
                      child: Text(
                        '- Huỷ',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppColors.primarySecondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTextFieldContent2(
                        context, 'Bình luận của bạn', 'comment', '', (value) {
                      context.read<ListCommentPostGroupBloc>().add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: BlocProvider.of<ListCommentPostGroupBloc>(context)
                          .state
                          .reply ==
                          1
                          ? () {
                        if (content != "") {
                          ListCommentPostAdviseController(
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
                          ListCommentPostAdviseController(
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
                        width: 15.w,
                        height: 15.h,
                        color: content != ""
                            ? AppColors.primaryElement
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
    backgroundColor: AppColors.primaryBackground,
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
            'Bình luận',
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
