import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page_controller.dart';
import 'package:popover/popover.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/advise_page_blocs.dart';
import '../bloc/advise_page_states.dart';

Widget buildCreatePostButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/writePostAdvise",
        (route) => false,
        arguments: {
          "route": 2,
        },
      );
    },
    child: Container(
      height: 40.h,
      padding: EdgeInsets.only(top: 0.h, bottom: 5.h, left: 10.w),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 300.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                // Căn giữa theo chiều dọc
                child: Container(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Bạn đang muốn được tư vấn điều gì?',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.Header2,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                'assets/icons/image.png',
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget listPost(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<AdvisePageBloc>(context).state.post.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<AdvisePageBloc>(context).state.statusPost) {
              case Status.loading:
                return Column(
                  children: [
                    buildCreatePostButton(context),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<AdvisePageBloc>(context)
                    .state
                    .post
                    .isEmpty) {
                  return Column(
                    children: [
                      buildCreatePostButton(context),
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
                    BlocProvider.of<AdvisePageBloc>(context)
                        .state
                        .post
                        .length) {
                  if (BlocProvider.of<AdvisePageBloc>(context)
                      .state
                      .hasReachedMaxPost) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildCreatePostButton(context),
                        post(
                            context,
                            BlocProvider.of<AdvisePageBloc>(context)
                                .state
                                .post[index]),
                      ],
                    );
                  } else {
                    return post(
                        context,
                        BlocProvider.of<AdvisePageBloc>(context)
                            .state
                            .post[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

class ButtonOptionPost extends StatefulWidget {
  final Post post;

  const ButtonOptionPost(this.post, {Key? key}) : super(key: key);

  @override
  State<ButtonOptionPost> createState() => _ButtonOptionPostState();
}

class _ButtonOptionPostState extends State<ButtonOptionPost> {
  @override
  Widget build(BuildContext context) {
    Post post = widget.post; // Accessing post from the widget instance
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) =>
              BlocBuilder<AdvisePageBloc, AdvisePageState>(
                builder: (context, state) {
                  return Container(
                    width: 130.w,
                    height: 45.h,
                    child: Container(
                      margin: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "/editPostAdvise",
                                    (route) => false,
                                arguments: {
                                  "route": 2,
                                  "post": post,
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/edit.svg",
                                  width: 16.w,
                                  height: 16.h,
                                  color: AppColors.primarySecondaryText,
                                ),
                                Container(
                                  width: 5.w,
                                ),
                                Text(
                                  'Chỉnh sửa bài viết',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFonts.Header2,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              AdvisePageController(context: context)
                                  .handleDeletePost(post.id);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/trash.svg",
                                  width: 16.w,
                                  height: 16.h,
                                  color: AppColors.primarySecondaryText,
                                ),
                                Container(
                                  width: 5.w,
                                ),
                                Text(
                                  'Xoá bài viết',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFonts.Header2,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          onPop: () {},
          direction: PopoverDirection.bottom,
          width: 170.w,
          height: 60.h,
        );
      },
      child: Container(
        width: 17.w,
        height: 17.h,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/icons/3dot.png"))),
      ),
    );
  }
}

Widget post(BuildContext context, Post post) {
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
                      // Xử lý khi người dùng tap vào hình ảnh
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
                      style: TextStyle(
                        fontFamily: AppFonts.Header2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          handleDatetime(post.publishedAt),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: AppFonts.Header3,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primarySecondaryText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ButtonOptionPost(post),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
          child: Text(
            post.title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: AppFonts.Header2,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/tag.svg",
                width: 12.w,
                height: 12.h,
                color: AppColors.primarySecondaryText,
              ),
              for (int i = 0; i < post.tags.length; i += 1)
                Container(
                  margin: EdgeInsets.only(left: 2.w),
                  child: Text(
                    post.tags[i].name,
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
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: ExpandableText(
            post.content,
            maxLines: 4,
            expandText: 'Xem thêm',
            collapseText: 'Thu gọn',
            style: TextStyle(
              fontFamily: AppFonts.Header3,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryText,
            ),
          ),
        ),
        Container(
          height: 5.h,
        ),
        if (post.picture.length == 1)
          Container(
            width: 340.w,
            height: 240.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(post.picture[0].pictureUrl),
              ),
            ),
          ),
        if (post.picture.length == 2)
          Container(
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
                      image: NetworkImage(post.picture[0].pictureUrl),
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
                      image: NetworkImage(post.picture[1].pictureUrl),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (post.picture.length == 3)
          Container(
            child: Column(
              children: [
                Container(
                  width: 340.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(post.picture[0].pictureUrl),
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
                            image: NetworkImage(post.picture[1].pictureUrl),
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
                            image: NetworkImage(post.picture[2].pictureUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (post.picture.length == 4)
          Container(
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
                            image: NetworkImage(post.picture[0].pictureUrl),
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
                            image: NetworkImage(post.picture[1].pictureUrl),
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
                            image: NetworkImage(post.picture[2].pictureUrl),
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
                            image: NetworkImage(post.picture[3].pictureUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (post.picture.length == 5)
          Container(
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
                            image: NetworkImage(post.picture[0].pictureUrl),
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
                            image: NetworkImage(post.picture[1].pictureUrl),
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
                            image: NetworkImage(post.picture[2].pictureUrl),
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
                                image: NetworkImage(post.picture[3].pictureUrl),
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
                                color: Color.fromARGB(255, 24, 59, 86)
                                    .withOpacity(0.5),
                              ),
                              child: Center(
                                child: Text(
                                  '+1',
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header2,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBackground,
                                  ),
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/listInteractPostAdvise",
                    (route) => false,
                    arguments: {
                      "route": 1,
                      "id": post.id,
                    },
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: SvgPicture.asset(
                        "assets/icons/like_react.svg",
                        height: 15.h,
                        width: 15.w,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        post.reactionCount.toString(),
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/listCommentPostAdvise",
                    (route) => false,
                    arguments: {
                      "route": 1,
                      "id": post.id,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    '${post.childrenCommentNumber} bình luận',
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          height: 1.h,
          color: AppColors.primarySecondaryElement,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    AdvisePageController(context: context)
                        .handleLikePost(post.id);
                  },
                  child: post.isReacted
                      ? Container(
                          margin: EdgeInsets.only(left: 40.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/like.svg",
                                width: 20.w,
                                height: 20.h,
                                color: AppColors.primaryElement,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'Thích',
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header2,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.primaryElement,
                                  ),
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
                                "assets/icons/like.svg",
                                width: 20.w,
                                height: 20.h,
                                color: AppColors.primaryText,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'Thích',
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header2,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 40.w),
                    child: Row(
                      children: [
                        Container(
                          height: 20.h,
                          width: 20.w,
                          child: Image.asset('assets/icons/comment.png'),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            'Bình luận',
                            style: TextStyle(
                              fontFamily: AppFonts.Header2,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 5.h,
          color: AppColors.primarySecondaryElement,
        ),
      ],
    ),
  );
}
