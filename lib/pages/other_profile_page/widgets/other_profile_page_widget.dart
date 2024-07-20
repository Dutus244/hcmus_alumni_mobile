import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/pages/other_profile_page/other_profile_page_controller.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/event.dart';
import '../../../model/user.dart';
import '../bloc/other_profile_page_blocs.dart';
import '../bloc/other_profile_page_states.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          BlocProvider.of<OtherProfilePageBloc>(context).state.user != null
              ? BlocProvider.of<OtherProfilePageBloc>(context)
                  .state
                  .user!
                  .fullName
              : '',
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

Widget myProfile(BuildContext context, String id) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      header(context),
      detail(context),
      listFriend(context, id),
    ],
  );
}

Widget listFriend(BuildContext context, String id) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 10.h),
        child: Text(
          translate('friend'),
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 2.h),
        child: Text(
          '${BlocProvider.of<OtherProfilePageBloc>(context).state.friendCount} ${translate('friends').toLowerCase()}',
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.textGrey,
          ),
        ),
      ),
      if (BlocProvider.of<OtherProfilePageBloc>(context).state.friends.length >
          0)
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              for (int i = 0;
                  i <
                      (BlocProvider.of<OtherProfilePageBloc>(context)
                                  .state
                                  .friends
                                  .length >
                              3
                          ? 3
                          : BlocProvider.of<OtherProfilePageBloc>(context)
                              .state
                              .friends
                              .length);
                  i += 1)
                if (i <= 2)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/otherProfilePage",
                          arguments: {
                            "id": BlocProvider.of<OtherProfilePageBloc>(context)
                                .state
                                .friends[i]
                                .user
                                .id,
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              image: DecorationImage(
                                image: NetworkImage(
                                    BlocProvider.of<OtherProfilePageBloc>(
                                            context)
                                        .state
                                        .friends[i]
                                        .user
                                        .avatarUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 100.h,
                            width: 100.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            width: 100.w,
                            height: 40.h,
                            child: Text(
                              BlocProvider.of<OtherProfilePageBloc>(context)
                                  .state
                                  .friends[i]
                                  .user
                                  .fullName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
            ],
          ),
        ),
      if (BlocProvider.of<OtherProfilePageBloc>(context).state.friends.length >
          3)
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 3;
                  i <
                      BlocProvider.of<OtherProfilePageBloc>(context)
                          .state
                          .friends
                          .length;
                  i += 1)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/otherProfilePage",
                        arguments: {
                          "id": BlocProvider.of<OtherProfilePageBloc>(context)
                              .state
                              .friends[i]
                              .user
                              .id,
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            image: DecorationImage(
                              image: NetworkImage(
                                  BlocProvider.of<OtherProfilePageBloc>(context)
                                      .state
                                      .friends[i]
                                      .user
                                      .avatarUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 100.h,
                          width: 100.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          width: 100.w,
                          height: 40.h,
                          child: Text(
                            BlocProvider.of<OtherProfilePageBloc>(context)
                                .state
                                .friends[i]
                                .user
                                .fullName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppFonts.Header,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      GestureDetector(
        onTap: () async {
          Navigator.pushNamed(context, "/friendList", arguments: {"id": id});
        },
        child: Container(
            width: 340.w,
            height: 40.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: Color.fromARGB(255, 230, 230, 230),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Container(
                height: 20.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Center(
                  child: Text(
                    translate('see_all_friends'),
                    style: AppTextStyle.base().wSemiBold(),
                  ),
                ))),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        height: 3.h,
        color: AppColors.elementLight,
      ),
    ],
  );
}

Widget deleteFriend(BuildContext context, String id) {
  return GestureDetector(
    onTap: () async {
      bool isDelete = await OtherProfilePageController(context: context)
          .handleDeleteFriend(id);
      if (isDelete) {
        Navigator.pop(context);
      }
    },
    child: Container(
      height: 60.h,
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 10.w, bottom: 20.h),
        color: Colors.transparent,
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/delete_friend.svg",
              width: 14.w,
              height: 14.h,
              color: AppColors.textBlack,
            ),
            Container(
              width: 10.w,
            ),
            Text(
              translate('unfriend'),
              style: AppTextStyle.medium().wSemiBold(),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget header(BuildContext context) {
  String isFriendStatus =
      BlocProvider.of<OtherProfilePageBloc>(context).state.isFriendStatus;
  User? user = BlocProvider.of<OtherProfilePageBloc>(context).state.user;
  if (user == null) {
    return loadingWidget();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 210.h,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(user.coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 180.h,
              width: double.infinity,
            ),
            Positioned(
              left: 10.w,
              bottom: 0.h,
              // Đẩy CircleAvatar xuống dưới một nửa chiều cao của nó để nó nằm ở mép
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(user.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(65.w),
                  border: Border.all(
                    color: Colors.white,
                    width:
                        5.w, // Thay đổi giá trị width để làm cho viền dày hơn
                  ),
                ),
                height: 130.w,
                width: 130.w,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
        child: Row(
          children: [
            Text(
              user.fullName,
              style: AppTextStyle.xLarge().wSemiBold(),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 0.h),
        child: Row(
          children: [
            Text(
              BlocProvider.of<OtherProfilePageBloc>(context)
                  .state
                  .friendCount
                  .toString(),
              style: AppTextStyle.base(),
            ),
            Text(
              ' ${translate('friend')}',
              style: AppTextStyle.base().withColor(AppColors.textGrey),
            ),
          ],
        ),
      ),
      Row(
        children: [
          if (isFriendStatus == "Not Friend")
            GestureDetector(
              onTap: () {
                OtherProfilePageController(context: context)
                    .handleSendRequest(user.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                width: 160.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/add_friend.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.background,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('add_friend'),
                        style: AppTextStyle.base()
                            .wSemiBold()
                            .withColor(AppColors.background),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isFriendStatus == "Not Friend")
            GestureDetector(
              onTap: () {
                OtherProfilePageController(context: context).handleInbox(user);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.w, top: 10.h),
                width: 160.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('chat'),
                        style: AppTextStyle.base().wSemiBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isFriendStatus == "true")
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => deleteFriend(context, user.id),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                width: 160.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/friend.svg",
                        width: 20.w,
                        height: 20.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('friend'),
                        style: AppTextStyle.base().wSemiBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isFriendStatus == "true")
            GestureDetector(
              onTap: () {
                OtherProfilePageController(context: context).handleInbox(user);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.w, top: 10.h),
                width: 160.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.background,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('chat'),
                        style: AppTextStyle.base()
                            .wSemiBold()
                            .withColor(AppColors.background),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isFriendStatus == "Pending")
            GestureDetector(
              onTap: () {
                OtherProfilePageController(context: context)
                    .handleSendRequest(user.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                width: 160.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/add_friend.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.background,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('cancel_invitation'),
                        style: AppTextStyle.base()
                            .wSemiBold()
                            .withColor(AppColors.background),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isFriendStatus == "Pending")
            GestureDetector(
              onTap: () {
                OtherProfilePageController(context: context).handleInbox(user);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.w, top: 10.h),
                width: 160.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 5.w,
                      ),
                      Text(
                        translate('chat'),
                        style: AppTextStyle.base().wSemiBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        height: 3.h,
        color: AppColors.elementLight,
      ),
    ],
  );
}

Widget detail(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 10.h),
        child: Text(
          translate('detail'),
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ),
      for (int i = 0;
          i <
              BlocProvider.of<OtherProfilePageBloc>(context)
                  .state
                  .educations
                  .length;
          i += 1)
        Container(
          margin: EdgeInsets.only(left: 10.w, top: 10.h, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/study.svg",
                width: 17.w,
                height: 17.h,
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                width: 10.w,
              ),
              Container(
                width: 310.w,
                child: Text(
                  '${BlocProvider.of<OtherProfilePageBloc>(context).state.educations[i].isLearning ? translate('studying_at') : translate('studied_at')} ${BlocProvider.of<OtherProfilePageBloc>(context).state.educations[i].schoolName}',
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBlack,
                  ),
                ),
              )
            ],
          ),
        ),
      for (int i = 0;
          i < BlocProvider.of<OtherProfilePageBloc>(context).state.jobs.length;
          i += 1)
        Container(
          margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/work.svg",
                width: 17.w,
                height: 17.h,
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                width: 10.w,
              ),
              Container(
                width: 310.w,
                child: Text(
                  '${BlocProvider.of<OtherProfilePageBloc>(context).state.jobs[i].isWorking ? translate('working_at') : translate('worked_at')} ${BlocProvider.of<OtherProfilePageBloc>(context).state.jobs[i].companyName}',
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBlack,
                  ),
                ),
              )
            ],
          ),
        ),
      for (int i = 0;
          i <
              BlocProvider.of<OtherProfilePageBloc>(context)
                  .state
                  .achievements
                  .length;
          i += 1)
        Container(
          margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/achievement.svg",
                width: 17.w,
                height: 17.h,
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                width: 10.w,
              ),
              Container(
                width: 310.w,
                child: Text(
                  '${translate('has_achieved')} ${BlocProvider.of<OtherProfilePageBloc>(context).state.achievements[i].name}',
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBlack,
                  ),
                ),
              )
            ],
          ),
        ),
      GestureDetector(
        onTap: () async {
          Navigator.pushNamed(context, "/otherProfileDetail", arguments: {
            "id": BlocProvider.of<OtherProfilePageBloc>(context).state.user!.id
          });
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
          child: Row(
            children: [
              Container(
                width: 17.w,
                height: 17.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/3dot.png"))),
              ),
              Container(
                width: 10.w,
              ),
              Container(
                width: 310.w,
                child: Text(
                  translate('view_your_referral_information'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBlack,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        height: 3.h,
        color: AppColors.elementLight,
      ),
    ],
  );
}

Widget listEvent(
    BuildContext context, ScrollController _scrollController, String id) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<OtherProfilePageBloc>(context)
                  .state
                  .events
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<OtherProfilePageBloc>(context)
                .state
                .statusEvent) {
              case Status.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    myProfile(context, id),
                    Container(
                      height: 10.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        translate('events_participated'),
                        style: AppTextStyle.large().wSemiBold(),
                      ),
                    ),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<OtherProfilePageBloc>(context)
                    .state
                    .events
                    .isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      myProfile(context, id),
                      Container(
                        height: 10.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Text(
                          translate('activities_participated'),
                          style: AppTextStyle.large().wSemiBold(),
                        ),
                      ),
                      Container(
                        height: 10.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_event_found'),
                          style: AppTextStyle.small(),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<OtherProfilePageBloc>(context)
                        .state
                        .events
                        .length) {
                  if (BlocProvider.of<OtherProfilePageBloc>(context)
                      .state
                      .hasReachedMaxEvent) {
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
                        myProfile(context, id),
                        Container(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            translate('activities_participated'),
                            style: AppTextStyle.large().wSemiBold(),
                          ),
                        ),
                        Container(
                          height: 10.h,
                        ),
                        event(
                            context,
                            BlocProvider.of<OtherProfilePageBloc>(context)
                                .state
                                .events[index]),
                      ],
                    );
                  } else {
                    return event(
                        context,
                        BlocProvider.of<OtherProfilePageBloc>(context)
                            .state
                            .events[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget event(BuildContext context, Event event) {
  return GestureDetector(
    onTap: () {
      // context.read<OtherProfilePageBloc>().add(NewsEventPageResetEvent());
      Navigator.pushNamed(
        context,
        "/eventDetail",
        arguments: {
          "id": event.id,
        },
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      handleDateTime1(event.publishedAt),
                      maxLines: 1,
                      style:
                          AppTextStyle.xSmall().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
                Container(
                  width: 10.w,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/view.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.views.toString(),
                      maxLines: 1,
                      style:
                          AppTextStyle.xSmall().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
                Container(
                  width: 10.w,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/participant.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.participants.toString(),
                      maxLines: 1,
                      style:
                          AppTextStyle.xSmall().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/tag.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.textGrey,
                ),
                for (int i = 0; i < event.tags.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Text(
                      event.tags[i].name,
                      style: AppTextStyle.xSmall().withColor(AppColors.tag),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.medium().wSemiBold(),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 3.h),
              height: 15.h,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    width: 12.w,
                    height: 12.h,
                    color: Color.fromARGB(255, 255, 95, 92),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    '${translate('location')}:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Container(
                    width: 250.w,
                    child: Text(
                      event.organizationLocation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              height: 15.h,
              margin: EdgeInsets.only(top: 3.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/time.svg",
                    width: 12.w,
                    height: 12.h,
                    color: Color.fromARGB(255, 153, 214, 216),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    translate('time'),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    handleDateTime1(event.organizationTime),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Stack(
              children: [
                Container(
                  width: 340.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(event.thumbnail),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 20.h,
                    margin: EdgeInsets.only(left: 10.w, top: 5.h),
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, bottom: 2.h, top: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                    ),
                    child: Text(
                      event.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10.h,
          ),
          Container(
            height: 1.h,
            color: AppColors.elementLight,
          ),
          Container(
            height: 10.h,
          ),
        ],
      ),
    ),
  );
}
