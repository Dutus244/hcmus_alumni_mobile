import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popover/popover.dart';
import '../../../common/function/handle_datetime.dart';
import '../../../common/function/handle_participant_count.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/group.dart';
import '../../../model/post.dart';
import '../bloc/group_detail_states.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail/bloc/group_detail_blocs.dart';

import '../group_detail_controller.dart';

AppBar buildAppBar(BuildContext context, int secondRoute, int search) {
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
              if (search == 0) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/applicationPage", (route) => false,
                    arguments: {"route": 3, "secondRoute": secondRoute});
              }
              else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/groupSearch", (route) => false);
              }
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
            'Nhóm',
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
              children: [],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget informationGroup(BuildContext context, Group group, int secondRoute) {
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = 'Nhóm Công khai';
  } else {
    typeGroup = 'Nhóm Riêng tư';
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 0.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(group.coverUrl ?? ""),
            fit: BoxFit.cover,
          ),
        ),
        height: 150.h,
      ),
      Container(
        margin: EdgeInsets.only(top: 0.h),
        decoration: BoxDecoration(
          color: AppColors.primaryText.withOpacity(0.8),
        ),
        height: 20.h,
        width: 400.w,
        child: Container(
          margin: EdgeInsets.only(left: 10.w, top: 2.h),
          child: Text(
            'Nhóm của ${group.creator.fullName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.Header2,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/groupInfo",
                (route) => false,
            arguments: {
              "group": group,
              "secondRoute": secondRoute,
            },
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
          color: AppColors.primaryBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Text(
                  group.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.h),
                child: Row(
                  children: [
                    if (group.privacy == 'PUBLIC')
                      SvgPicture.asset(
                        "assets/icons/earth.svg",
                        width: 11.w,
                        height: 11.h,
                        color: AppColors.primarySecondaryText,
                      ),
                    if (group.privacy == 'PRIVATE')
                      SvgPicture.asset(
                        "assets/icons/lock.svg",
                        width: 11.w,
                        height: 11.h,
                        color: AppColors.primarySecondaryText,
                      ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      typeGroup + ' - ',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primarySecondaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                    Text(
                      '${handleParticipantCount(group.participantCount)} ',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                    Text(
                      'thành viên',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primarySecondaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildCreatePostButton(BuildContext context, Group group, int secondRoute) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/writePostGroup",
            (route) => false,
        arguments: {
          "id": group.id,
          "secondRoute": secondRoute,
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

Widget joinGroup(BuildContext context, Group group) {
  return GestureDetector(
    onTap: () {
      GroupDetailController(context: context).handleRequestJoinGroup(group.id);
    },
    child: group.isRequestPending ? Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Center(
        child: Text(
          'Đang chờ duyệt',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
    ) : Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColors.primaryElement,
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Center(
        child: Text(
          'Tham gia nhóm',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBackground,
          ),
        ),
      ),
    ),
  );
}

Widget space() {
  return Column(
    children: [
      Container(
        height: 15.h,
      ),
      Container(
        margin: EdgeInsets.only(bottom: 10.h),
        height: 5.h,
        color: AppColors.primarySecondaryElement,
      )
    ],
  );
}

Widget joinedGroup(BuildContext context, Group group, int secondRoute) {
  return GestureDetector(
    onTap: () {
      if (group.userRole == 'MEMBER') {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => exitGroup(context, group, secondRoute),
        );
      }
      else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/groupManagement",
              (route) => false,
          arguments: {
            "group": group,
            "secondRoute": secondRoute,
          },
        );
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      width: 160.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: (group.userRole == 'MEMBER') ? Color.fromARGB(255, 230, 230, 230) : AppColors.primaryElement,
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (group.userRole == 'MEMBER')
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/tick.svg",
                    width: 14.w,
                    height: 14.h,
                    color: AppColors.primaryText,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Đã tham gia',
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  SvgPicture.asset(
                    "assets/icons/dropdown.svg",
                    width: 14.w,
                    height: 14.h,
                    color: AppColors.primaryText,
                  ),
                ],
              ),
            if (group.userRole == 'ADMIN' || group.userRole == 'CREATOR')
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/star_circle.svg",
                    width: 14.w,
                    height: 14.h,
                    color: AppColors.primaryBackground,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Quản lý',
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBackground,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}

Widget exitGroup(BuildContext context, Group group, int secondRoute) {
  return GestureDetector(
    onTap: () {
      GroupDetailController(context: context).handleExitGroup(group.id, secondRoute);
    },
    child: Container(
      height: 60.h,
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 10.w, bottom: 20.h),
        color: Colors.transparent,
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/exit.svg",
              width: 14.w,
              height: 14.h,
              color: AppColors.primaryText,
            ),
            Container(
              width: 10.w,
            ),
            Text(
              'Rời nhóm',
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget groupPrivateNotJoined(
    BuildContext context, Group? group, int secondRoute) {
  if (group == null) {
    return loadingWidget();
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              informationGroup(context, group, secondRoute),
              joinGroup(context, group),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 20.h),
                child: Text(
                  'Giới thiệu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
                width: MediaQuery.of(context).size.width,
                child: ExpandableText(
                  group.description,
                  maxLines: 4,
                  expandText: 'Xem thêm',
                  collapseText: 'Thu gọn',
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/lock.svg",
                      width: 11.w,
                      height: 13.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Riêng tư',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                          Container(
                            width: 300.w,
                            child: Text(
                              'Chỉ những thành viên mới nhìn thấy mọi người trong nhóm và những gì họ đăng',
                              style: TextStyle(
                                color: AppColors.primarySecondaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      width: 11.w,
                      height: 13.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lịch sử nhóm',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                          Container(
                            width: 300.w,
                            child: Text(
                              'Ngày tạo nhóm ${timeCreateGroup('2024-04-10 20:29:15')}',
                              style: TextStyle(
                                color: AppColors.primarySecondaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget group(BuildContext context, ScrollController _scrollController,
    Group? group, int secondRoute) {
  if (group == null) {
    return loadingWidget();
  } else {
    bool joined = group.isJoined;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount:
                BlocProvider.of<GroupDetailBloc>(context).state.posts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              switch (
                  BlocProvider.of<GroupDetailBloc>(context).state.statusPost) {
                case Status.loading:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      informationGroup(context, group, secondRoute),
                      if (!joined) joinGroup(context, group),
                      if (joined) joinedGroup(context, group, secondRoute),
                      space(),
                      if (joined) buildCreatePostButton(context, group, secondRoute),
                      loadingWidget(),
                    ],
                  );
                case Status.success:
                  if (BlocProvider.of<GroupDetailBloc>(context)
                      .state
                      .posts
                      .isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        informationGroup(context, group, secondRoute),
                        if (!joined) joinGroup(context, group),
                        if (joined) joinedGroup(context, group, secondRoute),
                        space(),
                        if (joined) buildCreatePostButton(context, group, secondRoute),
                        Center(
                            child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Text(
                            'Không có bài viết',
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
                      BlocProvider.of<GroupDetailBloc>(context)
                          .state
                          .posts
                          .length) {
                    if (BlocProvider.of<GroupDetailBloc>(context)
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          informationGroup(context, group, secondRoute),
                          if (!joined) joinGroup(context, group),
                          if (joined) joinedGroup(context, group, secondRoute),
                          space(),
                          if (joined) buildCreatePostButton(context, group, secondRoute),
                          post(
                              context,
                              BlocProvider.of<GroupDetailBloc>(context)
                                  .state
                                  .posts[index], group, secondRoute),
                        ],
                      );
                    } else {
                      return post(
                          context,
                          BlocProvider.of<GroupDetailBloc>(context)
                              .state
                              .posts[index], group, secondRoute);
                    }
                  }
              }
            },
          ),
        ),
      ],
    );
  }
}

class ButtonOptionPost extends StatefulWidget {
  final Post post;
  final String groupId;
  final int secondRoute;

  const ButtonOptionPost(this.post, this.groupId, this.secondRoute, {Key? key}) : super(key: key);

  @override
  State<ButtonOptionPost> createState() => _ButtonOptionPostState();
}

class _ButtonOptionPostState extends State<ButtonOptionPost> {
  @override
  Widget build(BuildContext context) {
    Post post = widget.post; // Accessing post from the widget instance
    String groupId = widget.groupId;
    int secondRoute = widget.secondRoute;
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) =>
              BlocBuilder<GroupDetailBloc, GroupDetailState>(
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
                      if (post.permissions.edit)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/editPostGroup",
                              (route) => false,
                              arguments: {
                                "id": groupId,
                                "secondRoute": secondRoute,
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
                      if (post.permissions.delete)
                        GestureDetector(
                          onTap: () {
                            GroupDetailController(context: context)
                                .handleDeletePost(post.id, groupId);
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

Widget postOption(BuildContext context, Post post, String groupId, int secondRoute) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/editPostGroup",
                        (route) => false,
                    arguments: {
                      "id": groupId,
                      "secondRoute": secondRoute,
                      "post": post,
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Chỉnh sửa bài viết',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool shouldDelete = await GroupDetailController(context: context)
                      .handleDeletePost(post.id, groupId);
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
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Xoá bài viết',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
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

Widget post(BuildContext context, Post post, Group group, int secondRoute) {
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
                          timePost(post.publishedAt),
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
              if (post.permissions.edit || post.permissions.delete)
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => postOption(context, post, group.id, secondRoute),
                    );
                  },
                  child: Container(
                    width: 17.w,
                    height: 17.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/icons/3dot.png"))),
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
        if (post.pictures.length == 1)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/listPicturePostGroup",
                (route) => false,
                arguments: {
                  "post": post,
                  "secondRoute": secondRoute,
                  "groupId": group.id,
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/listPicturePostGroup",
                (route) => false,
                arguments: {
                  "post": post,
                  "secondRoute": secondRoute,
                  "groupId": group.id,
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/listPicturePostGroup",
                (route) => false,
                arguments: {
                  "post": post,
                  "secondRoute": secondRoute,
                  "groupId": group.id,
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/listPicturePostGroup",
                (route) => false,
                arguments: {
                  "post": post,
                  "secondRoute": secondRoute,
                  "groupId": group.id,
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/listPicturePostGroup",
                (route) => false,
                arguments: {
                  "post": post,
                  "secondRoute": secondRoute,
                  "groupId": group.id,
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
                    "/listInteractPostGroup",
                    (route) => false,
                    arguments: {
                      "secondRoute": secondRoute,
                      "id": post.id,
                      "groupId": group.id,
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
                    "/listCommentPostGroup",
                    (route) => false,
                    arguments: {
                      "secondRoute": secondRoute,
                      "id": post.id,
                      "groupId": group.id,
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
                    // GroupDetailController(context: context)
                    //     .handleLikePost(post.id);
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
