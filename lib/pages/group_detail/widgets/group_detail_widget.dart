import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../../common/function/handle_datetime.dart';
import '../../../common/function/handle_participant_count.dart';
import '../../../common/function/handle_percentage_vote.dart';
import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/group.dart';
import '../../../model/post.dart';
import '../bloc/group_detail_states.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail/bloc/group_detail_blocs.dart';

import '../group_detail_controller.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('group'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget informationGroup(BuildContext context, Group group) {
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = '${translate('group')} ${translate('public')}';
  } else {
    typeGroup = '${translate('group')} ${translate('private')}';
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
          color: AppColors.textBlack.withOpacity(0.8),
        ),
        height: 20.h,
        width: 400.w,
        child: Container(
          margin: EdgeInsets.only(left: 10.w, top: 2.h),
          child: Text(
            '${translate('group_of')} ${group.creator.fullName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.Header,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/groupInfo",
            arguments: {
              "group": group,
            },
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
          color: AppColors.background,
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
                    fontFamily: AppFonts.Header,
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
                        color: AppColors.textGrey,
                      ),
                    if (group.privacy == 'PRIVATE')
                      SvgPicture.asset(
                        "assets/icons/lock.svg",
                        width: 11.w,
                        height: 11.h,
                        color: AppColors.textGrey,
                      ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      typeGroup + ' - ',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header,
                      ),
                    ),
                    Text(
                      '${handleParticipantCount(group.participantCount)} ',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header,
                      ),
                    ),
                    Text(
                      translate('members').toLowerCase(),
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header,
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

Widget buildCreatePostButton(BuildContext context, Group group) {
  return GestureDetector(
    onTap: () async {
      await Navigator.pushNamed(
        context,
        "/writePostGroup",
        arguments: {
          "id": group.id,
        },
      );
      GroupDetailController(context: context).handleLoadPostData(group.id, 0);
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
                    translate('what_advise_do_you_want'),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.Header,
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
          translate('waiting_approval'),
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ),
    ) : Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColors.element,
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Center(
        child: Text(
          translate('join'),
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.background,
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
        color: AppColors.elementLight,
      )
    ],
  );
}

Widget joinedGroup(BuildContext context, Group group) {
  return GestureDetector(
    onTap: () {
      if (group.userRole == 'MEMBER') {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => exitGroup(context, group),
        );
      }
      else {
        Navigator.pushNamed(
          context,
          "/groupManagement",
          arguments: {
            "group": group,
          },
        );
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
      width: 160.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: (group.userRole == 'MEMBER') ? Color.fromARGB(255, 230, 230, 230) : AppColors.element,
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
                    color: AppColors.textBlack,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    translate('joined'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  SvgPicture.asset(
                    "assets/icons/dropdown.svg",
                    width: 14.w,
                    height: 14.h,
                    color: AppColors.textBlack,
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
                    color: AppColors.background,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    translate('manage'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
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

Widget exitGroup(BuildContext context, Group group) {
  return GestureDetector(
    onTap: () async {
      await GroupDetailController(context: context).handleExitGroup(group.id);
      Navigator.pop(context);
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
              color: AppColors.textBlack,
            ),
            Container(
              width: 10.w,
            ),
            Text(
              translate('exit_group'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget groupPrivateNotJoined(
    BuildContext context, Group? group) {
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
              informationGroup(context, group),
              joinGroup(context, group),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 20.h),
                child: Text(
                  translate('introduce'),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
                width: MediaQuery.of(context).size.width,
                child: ExpandableText(
                  group.description,
                  maxLines: 4,
                  expandText: translate('see_more'),
                  collapseText: translate('collapse'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBlack,
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
                      color: AppColors.textBlack,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('private'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            width: 300.w,
                            child: Text(
                              translate('private_description'),
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
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
                      color: AppColors.textBlack,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('group_history'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            width: 300.w,
                            child: Text(
                              '${translate('group_creation_date')} ${handleDateTime2('2024-04-10 20:29:15')}',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
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
    Group? group) {
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
                      informationGroup(context, group),
                      if (!joined) joinGroup(context, group),
                      if (joined) joinedGroup(context, group),
                      space(),
                      if (joined) buildCreatePostButton(context, group),
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
                        informationGroup(context, group),
                        if (!joined) joinGroup(context, group),
                        if (joined) joinedGroup(context, group),
                        space(),
                        if (joined) buildCreatePostButton(context, group),
                        Center(
                            child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Text(
                            translate('no_posts'),
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
                          informationGroup(context, group),
                          if (!joined) joinGroup(context, group),
                          if (joined) joinedGroup(context, group),
                          space(),
                          if (joined) buildCreatePostButton(context, group),
                          post(
                              context,
                              BlocProvider.of<GroupDetailBloc>(context)
                                  .state
                                  .posts[index], group),
                        ],
                      );
                    } else {
                      return post(
                          context,
                          BlocProvider.of<GroupDetailBloc>(context)
                              .state
                              .posts[index], group);
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

Widget postOption(BuildContext context, Post post, String groupId) {
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
                  Navigator.pushNamed(
                    context,
                    "/editPostGroup",
                    arguments: {
                      "id": groupId,
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
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('edit_post'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
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
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_post'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
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

Widget post(BuildContext context, Post post, Group group) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        "/postGroupDetail",
        arguments: {
          "id": post.id,
        },
      );
    },
    child: Container(
      color: Colors.transparent,
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
                          fontFamily: AppFonts.Header,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            handleTimeDifference2(post.publishedAt),
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: AppFonts.Header,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.textGrey,
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
                        builder: (ctx) => postOption(context, post, group.id),
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
                fontFamily: AppFonts.Header,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
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
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.textBlack,
              ),
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
                          Radio(
                              value: post.votes[i].name,
                              groupValue: post.voteSelectedOne,
                              onChanged: (value) {
                                if (post.voteSelectedOne == "") {
                                  GroupDetailController(context: context)
                                      .handleVote(group.id, post.id, post.votes[i].id);
                                } else {
                                  for (int j = 0; j < post.votes.length; j += 1) {
                                    if (post.votes[j].name == post.voteSelectedOne) {
                                      GroupDetailController(context: context)
                                          .handleUpdateVote(group.id, post.id, post.votes[j].id, post.votes[i].id);
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
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.textGrey),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/groupDetailListVoters",
                            arguments: {
                              "vote": post.votes[i],
                              "post": post,
                              "group": group,
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.element),
                            ),
                            Container(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              "assets/icons/arrow_next.svg",
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
                          Checkbox(
                              checkColor: AppColors.background,
                              fillColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColors.element; // Selected color
                                  }
                                  return Colors.transparent; // Unselected color
                                },
                              ),
                              onChanged: (value) {
                                if (value! == true) {
                                  GroupDetailController(context: context)
                                      .handleVote(group.id, post.id, post.votes[i].id);
                                } else {
                                  GroupDetailController(context: context)
                                      .handleDeleteVote(group.id, post.id, post.votes[i].id);
                                }
                              },
                              value: post.voteSelectedMultiple.contains(post.votes[i].name),
                            ),
                          Container(
                            width: 220.w,
                            child: Text(
                              post.votes[i].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.textGrey),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/groupDetailListVoters",
                            arguments: {
                              "vote": post.votes[i],
                              "post": post,
                              "group": group,
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.element),
                            ),
                            Container(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              "assets/icons/arrow_next.svg",
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
                if (post
                    .votes
                    .length >=
                    10) {
                  toastInfo(msg: translate('option_above_10'));
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
                    GroupDetailController(context: context)
                        .handleAddVote(group.id, post.id, vote);
                  } else {
                  }
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
                        "assets/icons/add.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textGrey,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('add_option'),
                        style: TextStyle(
                            fontFamily: AppFonts.Header,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textGrey),
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
                  "/listPicturePostGroup",
                  arguments: {
                    "post": post,
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
                Navigator.pushNamed(
                  context,
                  "/listPicturePostGroup",
                  arguments: {
                    "post": post,
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
                Navigator.pushNamed(
                  context,
                  "/listPicturePostGroup",
                  arguments: {
                    "post": post,
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
                Navigator.pushNamed(
                  context,
                  "/listPicturePostGroup",
                  arguments: {
                    "post": post,
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
                Navigator.pushNamed(
                  context,
                  "/listPicturePostGroup",
                  arguments: {
                    "post": post,
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
                                        fontFamily: AppFonts.Header,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.background,
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
                    Navigator.pushNamed(
                      context,
                      "/listInteractPostGroup",
                      arguments: {
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
                            fontFamily: AppFonts.Header,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      "/listCommentPostGroup",
                      arguments: {
                        "id": post.id,
                        "groupId": group.id,
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      '${post.childrenCommentNumber} ${translate('comments').toLowerCase()}',
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textBlack,
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
            color: AppColors.elementLight,
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
                      GroupDetailController(context: context)
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
                                  color: AppColors.element,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    translate('like'),
                                    style: TextStyle(
                                      fontFamily: AppFonts.Header,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.element,
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
                                  color: AppColors.textBlack,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    translate('like'),
                                    style: TextStyle(
                                      fontFamily: AppFonts.Header,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.textBlack,
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
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/listCommentPostGroup",
                        arguments: {
                          "id": post.id,
                          "groupId": group.id,
                        },
                      );
                    },
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
                              translate('comment'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.textBlack,
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
            color: AppColors.elementLight,
          ),
        ],
      ),
    ),
  );
}
