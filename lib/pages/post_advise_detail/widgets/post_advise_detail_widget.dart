import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/function/handle_percentage_vote.dart';
import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/comment.dart';
import '../../../model/post.dart';
import '../bloc/post_advise_detail_blocs.dart';
import '../bloc/post_advise_detail_states.dart';
import '../bloc/post_advise_detail_events.dart';
import '../post_advise_detail_controller.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('post1'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

Widget listComment(
    BuildContext context, ScrollController _scrollController, String id) {
  String content = BlocProvider.of<PostAdviseDetailBloc>(context).state.content;
  Comment? comment =
      BlocProvider.of<PostAdviseDetailBloc>(context).state.children;
  Post? posts = BlocProvider.of<PostAdviseDetailBloc>(context).state.post;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<PostAdviseDetailBloc>(context)
                  .state
                  .comments
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<PostAdviseDetailBloc>(context)
                .state
                .statusComment) {
              case Status.loading:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    post(context, posts),
                    Container(
                      margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                      height: 1.h,
                      color: AppColors.elementLight,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<PostAdviseDetailBloc>(context)
                    .state
                    .comments
                    .isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      post(context, posts),
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
                    BlocProvider.of<PostAdviseDetailBloc>(context)
                        .state
                        .comments
                        .length) {
                  if (BlocProvider.of<PostAdviseDetailBloc>(context)
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
                        post(context, posts),
                        Container(
                          margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                          height: 1.h,
                          color: AppColors.elementLight,
                        ),
                        buildCommentWidget(
                            context,
                            BlocProvider.of<PostAdviseDetailBloc>(context)
                                .state
                                .comments[index],
                            0,
                            id),
                      ],
                    );
                  } else {
                    return buildCommentWidget(
                        context,
                        BlocProvider.of<PostAdviseDetailBloc>(context)
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
      if (Global.storageService.permissionCounselCommentCreate())
        navigation(context, content, comment, id, (value) {
          context.read<PostAdviseDetailBloc>().add(ContentEvent(value));
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
                          if (Global.storageService.permissionCounselCommentCreate())
                            Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<PostAdviseDetailBloc>()
                                      .add(ChildrenEvent(comment));
                                  context
                                      .read<PostAdviseDetailBloc>()
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
                            ],
                          ),
                          if (comment.permissions.edit)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PostAdviseDetailBloc>()
                                        .add(ChildrenEvent(comment));
                                    context
                                        .read<PostAdviseDetailBloc>()
                                        .add(ContentEvent(comment.content));
                                    context
                                        .read<PostAdviseDetailBloc>()
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
                                    PostAdviseDetailController(context: context)
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
                                        .read<PostAdviseDetailBloc>()
                                        .add(ChildrenEvent(comment));
                                    context
                                        .read<PostAdviseDetailBloc>()
                                        .add(ContentEvent(comment.content));
                                    context
                                        .read<PostAdviseDetailBloc>()
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
                                    PostAdviseDetailController(context: context)
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
              PostAdviseDetailController(context: context)
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
              initialValue: BlocProvider.of<PostAdviseDetailBloc>(context).state.content,
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
        if (BlocProvider.of<PostAdviseDetailBloc>(context).state.reply == 0)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTextFieldContent(
                    context, translate('your_comment'), 'comment', '', (value) {
                  context.read<PostAdviseDetailBloc>().add(ContentEvent(value));
                }),
                GestureDetector(
                  onTap: () {
                    if (content != "") {
                      PostAdviseDetailController(context: context)
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
        if (BlocProvider.of<PostAdviseDetailBloc>(context).state.reply == 1)
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
                        context.read<PostAdviseDetailBloc>().add(ReplyEvent(0));
                        context
                            .read<PostAdviseDetailBloc>()
                            .add(ContentEvent(''));
                        // context.read<PostAdviseDetailBloc>().add(
                        //     ChildrenEvent(Comment('', User('', '', '', '', '', '', '', Faculty(0,''), '', '', '', ''), '',
                        //         0, '', '', Permissions(false, false))));
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
                        context, translate('your_comment'), 'comment', '',
                        (value) {
                      context
                          .read<PostAdviseDetailBloc>()
                          .add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: () {
                        if (content != "") {
                          PostAdviseDetailController(context: context)
                              .handleLoadWriteChildrenComment(
                                  id,
                                  BlocProvider.of<PostAdviseDetailBloc>(context)
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
        if (BlocProvider.of<PostAdviseDetailBloc>(context).state.reply == 2)
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
                        context.read<PostAdviseDetailBloc>().add(ReplyEvent(0));
                        context
                            .read<PostAdviseDetailBloc>()
                            .add(ContentEvent(''));
                        // context.read<PostAdviseDetailBloc>().add(
                        //     ChildrenEvent(Comment('', User('', '', '', '', '', '', '', Faculty(0,''), '', '' '', '', ''), '',
                        //         0, '', '', Permissions(false, false))));
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
                        context, translate('your_comment'), 'comment', '',
                        (value) {
                      context
                          .read<PostAdviseDetailBloc>()
                          .add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: BlocProvider.of<PostAdviseDetailBloc>(context)
                                  .state
                                  .reply ==
                              1
                          ? () {
                              if (content != "") {
                                PostAdviseDetailController(context: context)
                                    .handleLoadWriteChildrenComment(
                                        id,
                                        BlocProvider.of<PostAdviseDetailBloc>(
                                                context)
                                            .state
                                            .children!
                                            .id);
                              }
                            }
                          : () {
                              if (content != "") {
                                PostAdviseDetailController(context: context)
                                    .handleEditComment(
                                        id,
                                        BlocProvider.of<PostAdviseDetailBloc>(
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

Widget postOption(BuildContext context, Post post) {
  return Container(
    height: (post.votes.length == 0 && post.permissions.edit) ? 90.h : 50.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (post.votes.length == 0 && post.permissions.edit)
                GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      "/editPostAdvise",
                      arguments: {
                        "post": post,
                      },
                    );
                    PostAdviseDetailController(context: context)
                        .handleLoadPostData(post.id);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, top: 10.h),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.editIconS,
                          width: 14.w,
                          height: 14.h,
                          color: AppColors.textBlack,
                        ),
                        Container(
                          width: 10.w,
                        ),
                        Text(
                          translate('edit_post'),
                          style: AppTextStyle.medium().wSemiBold(),
                        ),
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () async {
                  bool shouldDelete =
                      await PostAdviseDetailController(context: context)
                          .handleDeletePost(post.id);
                  if (shouldDelete) {
                    Navigator.pop(context); // Close the modal after deletion
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.trashIconS,
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_post'),
                        style: AppTextStyle.medium().wSemiBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget post(BuildContext context, Post? post) {
  if (post == null) {
    return loadingWidget();
  }
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
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
                      if (post.creator.id ==
                          Global.storageService.getUserId()) {
                        Navigator.pushNamed(
                          context,
                          "/myProfilePage",
                        );
                      } else {
                        Navigator.pushNamed(context, "/otherProfilePage",
                            arguments: {
                              "id": post.creator.id,
                            });
                      }
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                          NetworkImage(post.creator.avatarUrl ?? ""),
                    )),
              ),
              Container(
                width: 270.w,
                height: 35.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      post.creator.fullName,
                      maxLines: 1,
                      style: AppTextStyle.small().wSemiBold(),
                    ),
                    Row(
                      children: [
                        Text(
                          handleTimeDifference2(post.publishedAt),
                          maxLines: 1,
                          style: AppTextStyle.xSmall()
                              .withColor(AppColors.textGrey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (post.permissions.edit || post.permissions.delete)
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => postOption(context, post),
                    );
                  },
                  child: Container(
                    width: 17.w,
                    height: 17.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.thereDotIconP))),
                  ),
                ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
          child: Text(
            post.title,
            textAlign: TextAlign.left,
            style: AppTextStyle.small().wSemiBold(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
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
                  post.tags.map((tag) => tag.name).join(' '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.xSmall().withColor(AppColors.tag),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: ExpandableText(
            post.content,
            maxLines: 4,
            expandText: translate('see_more'),
            collapseText: translate('collapse'),
            style: AppTextStyle.small(),
          ),
        ),
        if (!post.allowMultipleVotes)
          for (int i = 0; i < post.votes.length; i += 1)
            Container(
              width: 350.w,
              height: 35.h,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (Global.storageService.permissionCounselVote())
                          Radio(
                            value: post.votes[i].name,
                            groupValue: post.voteSelectedOne,
                            onChanged: (value) {
                              if (post.voteSelectedOne == "") {
                                PostAdviseDetailController(context: context)
                                    .handleVote(post.id, post.votes[i].id);
                              } else {
                                for (int j = 0; j < post.votes.length; j += 1) {
                                  if (post.votes[j].name ==
                                      post.voteSelectedOne) {
                                    PostAdviseDetailController(context: context)
                                        .handleUpdateVote(post.id,
                                            post.votes[j].id, post.votes[i].id);
                                  }
                                }
                              }
                            },
                          ),
                        Container(
                          width: 220.w,
                          child: Text(
                            post.votes[i].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.small()
                                .withColor(AppColors.textGrey),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          "/advisePageListVoters",
                          arguments: {
                            "vote": post.votes[i],
                            "post": post,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                            style: AppTextStyle.small()
                                .withColor(AppColors.element),
                          ),
                          Container(
                            width: 5.w,
                          ),
                          SvgPicture.asset(
                            AppAssets.arrowNextIconS,
                            height: 15.h,
                            width: 15.w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        if (post.allowMultipleVotes)
          for (int i = 0; i < post.votes.length; i += 1)
            Container(
              width: 350.w,
              height: 35.h,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (Global.storageService.permissionCounselVote())
                          Checkbox(
                            checkColor: AppColors.background,
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return AppColors.element; // Selected color
                                }
                                return Colors.transparent; // Unselected color
                              },
                            ),
                            onChanged: (value) {
                              if (value! == true) {
                                PostAdviseDetailController(context: context)
                                    .handleVote(post.id, post.votes[i].id);
                              } else {
                                PostAdviseDetailController(context: context)
                                    .handleDeleteVote(
                                        post.id, post.votes[i].id);
                              }
                            },
                            value: post.voteSelectedMultiple
                                .contains(post.votes[i].name),
                          ),
                        Container(
                          width: 220.w,
                          child: Text(
                            post.votes[i].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.small()
                                .withColor(AppColors.textGrey),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/advisePageListVoters",
                          arguments: {
                            "vote": post.votes[i],
                            "post": post,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                            style: AppTextStyle.small()
                                .withColor(AppColors.element),
                          ),
                          Container(
                            width: 5.w,
                          ),
                          SvgPicture.asset(
                            AppAssets.arrowNextIconS,
                            height: 15.h,
                            width: 15.w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        if (post.votes.length > 0 && post.allowAddOptions)
          GestureDetector(
            onTap: () {
              if (post.votes.length >= 10) {
                toastInfo(msg: translate("option_above_10"));
                return;
              }
              TextEditingController textController = TextEditingController();

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(translate('add_option')),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: translate('add_option'),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(translate('cancel')),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, {
                        'confirmed': true,
                        'vote': textController.text,
                      }),
                      child: Text(translate('add')),
                    ),
                  ],
                ),
              ).then((result) {
                if (result != null && result['confirmed'] == true) {
                  String vote = result['vote'];
                  PostAdviseDetailController(context: context)
                      .handleAddVote(post.id, vote);
                } else {}
              });
            },
            child: Container(
              width: 350.w,
              height: 35.h,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.addIconS,
                      width: 14.w,
                      height: 14.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      translate('add_option'),
                      style: AppTextStyle.small(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Container(
          height: 5.h,
        ),
        if (post.pictures.length == 1)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              width: 340.w,
              height: 240.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(post.pictures[0].pictureUrl),
                ),
              ),
            ),
          ),
        if (post.pictures.length == 2)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Column(
                children: [
                  Container(
                    width: 340.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.pictures[0].pictureUrl),
                      ),
                    ),
                  ),
                  Container(
                    width: 340.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.pictures[1].pictureUrl),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (post.pictures.length == 3)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: 340.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.pictures[0].pictureUrl),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[1].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[2].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (post.pictures.length == 4)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[0].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[1].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[2].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[3].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (post.pictures.length == 5)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[0].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[1].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[2].pictureUrl),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 170.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(post.pictures[3].pictureUrl),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: 170.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color:
                                      AppColors.blurredPicture.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    '+1',
                                    style: AppTextStyle.xLarge()
                                        .size(32.sp)
                                        .wSemiBold(),
                                  ),
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
            ),
          ),
        Container(
          height: 5.h,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/listInteractPostAdvise",
                    arguments: {
                      "id": post.id,
                    },
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: SvgPicture.asset(
                        AppAssets.likeIconS1,
                        height: 15.h,
                        width: 15.w,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        post.reactionCount.toString(),
                        style: AppTextStyle.xSmall(),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    "/listCommentPostAdvise",
                    arguments: {
                      "id": post.id,
                    },
                  );
                  PostAdviseDetailController(context: context)
                      .handleLoadPostData(post.id);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    '${post.childrenCommentNumber} ${translate('comments').toLowerCase()}',
                    style: AppTextStyle.xSmall(),
                  ),
                ),
              )
            ],
          ),
        ),
        if (Global.storageService.permissionCounselReactionCreate() ||
            Global.storageService.permissionCounselCommentCreate())
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5.h),
                height: 1.h,
                color: AppColors.elementLight,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (Global.storageService.permissionCounselReactionCreate())
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            PostAdviseDetailController(context: context)
                                .handleLikePost(post.id);
                          },
                          child: post.isReacted
                              ? Container(
                                  margin: EdgeInsets.only(left: 40.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.likeIconS2,
                                        width: 20.w,
                                        height: 20.h,
                                        color: AppColors.element,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(
                                          translate('like'),
                                          style: AppTextStyle.xSmall()
                                              .withColor(AppColors.element),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 40.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.likeIconS2,
                                        width: 20.w,
                                        height: 20.h,
                                        color: AppColors.textBlack,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(translate('like'),
                                            style: AppTextStyle.xSmall()),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    if (Global.storageService.permissionCounselCommentCreate())
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "/listCommentPostAdvise",
                              arguments: {
                                "id": post.id,
                              },
                            );
                          },
                          child: Container(
                            margin: Global.storageService
                                    .permissionCounselReactionCreate()
                                ? EdgeInsets.only(right: 40.w)
                                : EdgeInsets.only(left: 40.w),
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Image.asset(AppAssets.commentIconP),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(translate('comment'),
                                      style: AppTextStyle.xSmall()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          height: 5.h,
          color: AppColors.elementLight,
        ),
      ],
    ),
  );
}
