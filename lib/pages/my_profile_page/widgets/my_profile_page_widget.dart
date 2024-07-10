import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/function/handle_percentage_vote.dart';
import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/alumni_verification.dart';
import '../../../model/event.dart';
import '../../../model/post.dart';
import '../../../model/user.dart';
import '../bloc/my_profile_page_blocs.dart';
import '../bloc/my_profile_page_states.dart';
import '../bloc/my_profile_page_events.dart';
import '../my_profile_page_controller.dart';

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
          Global.storageService.getUserFullName(),
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

Widget myProfile(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      header(context),
      detail(context),
      listFriend(context),
    ],
  );
}

Widget header(BuildContext context) {
  User? user = BlocProvider.of<MyProfilePageBloc>(context).state.user;
  AlumniVerification? alumniVerification =
      BlocProvider.of<MyProfilePageBloc>(context).state.alumniVerification;
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
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            Container(
              width: 5.w,
            ),
            if (alumniVerification != null &&
                (alumniVerification.status == "PENDING" ||
                    alumniVerification.status == "DENIED"))
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/cancel_circle1.svg",
                    width: 14.w,
                    height: 14.h,
                    color: Colors.red,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
                      child: Text(
                        translate('unverified_account'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (alumniVerification != null &&
                alumniVerification.status == "APPROVED")
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/tick_circle.svg",
                    width: 14.w,
                    height: 14.h,
                    color: Colors.green,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
                      child: Text(
                        translate('verified_account'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 0.h),
        child: Row(
          children: [
            Text(
              BlocProvider.of<MyProfilePageBloc>(context)
                  .state
                  .friendCount
                  .toString(),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            Text(
              ' ${translate('friends').toLowerCase()}',
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(
                context,
                "/myProfileEdit",
              );
              MyProfilePageController(context: context).handleGetProfile();
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              width: 290.w,
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
                      "assets/icons/edit.svg",
                      width: 14.w,
                      height: 14.h,
                      color: AppColors.textBlack,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      translate('edit_profile'),
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/optionPage",
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w, top: 10.h),
              width: 40.w,
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
                      "assets/icons/option.svg",
                      width: 14.w,
                      height: 14.h,
                      color: AppColors.textBlack,
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
              BlocProvider.of<MyProfilePageBloc>(context)
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
                  '${BlocProvider.of<MyProfilePageBloc>(context).state.educations[i].isLearning ? translate('studying_at') : translate('studied_at')} ${BlocProvider.of<MyProfilePageBloc>(context).state.educations[i].schoolName}',
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
          i < BlocProvider.of<MyProfilePageBloc>(context).state.jobs.length;
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
                  '${BlocProvider.of<MyProfilePageBloc>(context).state.jobs[i].isWorking ? translate('working_at') : translate('worked_at')} ${BlocProvider.of<MyProfilePageBloc>(context).state.jobs[i].companyName}',
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
              BlocProvider.of<MyProfilePageBloc>(context)
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
                  '${translate('has_achieved')} ${BlocProvider.of<MyProfilePageBloc>(context).state.achievements[i].name}',
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
          await Navigator.pushNamed(
            context,
            "/myProfileEdit",
          );
          MyProfilePageController(context: context).handleGetProfile();
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

Widget listFriend(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 10.h),
        child: Text(
          translate('friend'),
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 2.h),
        child: Text(
          '${BlocProvider.of<MyProfilePageBloc>(context).state.friendCount} ${translate('friends').toLowerCase()}',
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.textGrey,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0;
                i <
                    BlocProvider.of<MyProfilePageBloc>(context)
                        .state
                        .friends
                        .length;
                i += 1)
              if (i <= 2)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/otherProfilePage",
                        arguments: {
                          "id": BlocProvider.of<MyProfilePageBloc>(context)
                              .state
                              .friends[i]
                              .user
                              .id,
                        });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w),
                          image: DecorationImage(
                            image: NetworkImage(
                                BlocProvider.of<MyProfilePageBloc>(context)
                                    .state
                                    .friends[i]
                                    .user
                                    .avatarUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 90.h,
                        width: 90.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        width: 110.w,
                        height: 30.h,
                        child: Text(
                          BlocProvider.of<MyProfilePageBloc>(context)
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
          ],
        ),
      ),
      if (BlocProvider.of<MyProfilePageBloc>(context).state.friends.length > 3)
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 3;
                  i <
                      BlocProvider.of<MyProfilePageBloc>(context)
                          .state
                          .friends
                          .length;
                  i += 1)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/otherProfilePage",
                        arguments: {
                          "id": BlocProvider.of<MyProfilePageBloc>(context)
                              .state
                              .friends[i]
                              .user
                              .id,
                        });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w),
                          image: DecorationImage(
                            image: NetworkImage(
                                BlocProvider.of<MyProfilePageBloc>(context)
                                    .state
                                    .friends[i]
                                    .user
                                    .avatarUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 90.h,
                        width: 90.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        width: 110.w,
                        height: 30.h,
                        child: Text(
                          BlocProvider.of<MyProfilePageBloc>(context)
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
            ],
          ),
        ),
      GestureDetector(
        onTap: () async {
          Navigator.pushNamed(context, "/friendList",
              arguments: {"id": Global.storageService.getUserId()});
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
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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

Widget buildButtonChooseNewsOrEvent(
    BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (func != null) {
                if (BlocProvider.of<MyProfilePageBloc>(context).state.page !=
                    0) {
                  func(0);
                }
              }
            },
            child: Container(
              width: 165.w,
              height: 30.h,
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                color:
                    BlocProvider.of<MyProfilePageBloc>(context).state.page == 0
                        ? AppColors.element
                        : AppColors.elementLight,
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  translate('advise'),
                  style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: BlocProvider.of<MyProfilePageBloc>(context)
                                  .state
                                  .page ==
                              0
                          ? AppColors.background
                          : AppColors.element),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (func != null) {
                if (BlocProvider.of<MyProfilePageBloc>(context).state.page !=
                    1) {
                  func(1);
                }
              }
            },
            child: Container(
              width: 165.w,
              height: 30.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color:
                    BlocProvider.of<MyProfilePageBloc>(context).state.page == 1
                        ? AppColors.element
                        : AppColors.elementLight,
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  translate('events_participated'),
                  style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: BlocProvider.of<MyProfilePageBloc>(context)
                                  .state
                                  .page ==
                              1
                          ? AppColors.background
                          : AppColors.element),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (func != null) {
                if (BlocProvider.of<MyProfilePageBloc>(context).state.page !=
                    2) {
                  func(2);
                }
              }
            },
            child: Container(
              width: 165.w,
              height: 30.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                color:
                    BlocProvider.of<MyProfilePageBloc>(context).state.page == 2
                        ? AppColors.element
                        : AppColors.elementLight,
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  translate('comment_advise'),
                  style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: BlocProvider.of<MyProfilePageBloc>(context)
                                  .state
                                  .page ==
                              2
                          ? AppColors.background
                          : AppColors.element),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget listEvent(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<MyProfilePageBloc>(context).state.events.length +
                  1,
          itemBuilder: (BuildContext context, int index) {
            switch (
                BlocProvider.of<MyProfilePageBloc>(context).state.statusEvent) {
              case Status.loading:
                return Column(
                  children: [
                    myProfile(context),
                    Container(
                      height: 10.h,
                    ),
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<MyProfilePageBloc>().add(PageEvent(value));
                    }),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<MyProfilePageBloc>(context)
                    .state
                    .events
                    .isEmpty) {
                  return Column(
                    children: [
                      myProfile(context),
                      Container(
                        height: 10.h,
                      ),
                      buildButtonChooseNewsOrEvent(context, (value) {
                        context.read<MyProfilePageBloc>().add(PageEvent(value));
                      }),
                      Container(
                        height: 10.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_event'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<MyProfilePageBloc>(context)
                        .state
                        .events
                        .length) {
                  if (BlocProvider.of<MyProfilePageBloc>(context)
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
                      children: [
                        myProfile(context),
                        Container(
                          height: 10.h,
                        ),
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context
                              .read<MyProfilePageBloc>()
                              .add(PageEvent(value));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        event(
                            context,
                            BlocProvider.of<MyProfilePageBloc>(context)
                                .state
                                .events[index]),
                      ],
                    );
                  } else {
                    return event(
                        context,
                        BlocProvider.of<MyProfilePageBloc>(context)
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
      Navigator.pushNamed(
        context,
        "/eventDetail",
        arguments: {"id": event.id},
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
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textGrey,
                      ),
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
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textGrey,
                      ),
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
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textGrey,
                      ),
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
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
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
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
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
                    '${translate('time')}:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto',
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
                      fontFamily: 'Roboto',
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
                      color: AppColors.element,
                    ),
                    child: Text(
                      event.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
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

Widget listPosts(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<MyProfilePageBloc>(context).state.posts.length +
                  1,
          itemBuilder: (BuildContext context, int index) {
            switch (
                BlocProvider.of<MyProfilePageBloc>(context).state.statusPost) {
              case Status.loading:
                return Column(
                  children: [
                    myProfile(context),
                    Container(
                      height: 10.h,
                    ),
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<MyProfilePageBloc>().add(PageEvent(value));
                    }),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<MyProfilePageBloc>(context)
                    .state
                    .posts
                    .isEmpty) {
                  return Column(
                    children: [
                      myProfile(context),
                      Container(
                        height: 10.h,
                      ),
                      buildButtonChooseNewsOrEvent(context, (value) {
                        context.read<MyProfilePageBloc>().add(PageEvent(value));
                      }),
                      Container(
                        height: 10.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_posts'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<MyProfilePageBloc>(context)
                        .state
                        .posts
                        .length) {
                  if (BlocProvider.of<MyProfilePageBloc>(context)
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
                        myProfile(context),
                        Container(
                          height: 10.h,
                        ),
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context
                              .read<MyProfilePageBloc>()
                              .add(PageEvent(value));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        post(
                            context,
                            BlocProvider.of<MyProfilePageBloc>(context)
                                .state
                                .posts[index]),
                      ],
                    );
                  } else {
                    return post(
                        context,
                        BlocProvider.of<MyProfilePageBloc>(context)
                            .state
                            .posts[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget postOption(BuildContext context, Post post) {
  return Container(
    height: post.votes.length == 0 ? 90.h : 50.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (post.votes.length == 0)
                GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      "/editPostAdvise",
                      arguments: {
                        "post": post,
                      },
                    );
                    MyProfilePageController(context: context)
                        .handleLoadPostData(0);
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
                  bool shouldDelete =
                      await MyProfilePageController(context: context)
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

Widget post(BuildContext context, Post post) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        "/postAdviseDetail",
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
                        builder: (ctx) => postOption(context, post),
                      );
                    },
                    child: Container(
                      width: 17.w,
                      height: 17.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/3dot.png"))),
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
                          if (Global.storageService.permissionCounselVote())
                            Radio(
                              value: post.votes[i].name,
                              groupValue: post.voteSelectedOne,
                              onChanged: (value) {
                                if (post.voteSelectedOne == "") {
                                  MyProfilePageController(context: context)
                                      .handleVote(post.id, post.votes[i].id);
                                } else {
                                  for (int j = 0;
                                      j < post.votes.length;
                                      j += 1) {
                                    if (post.votes[j].name ==
                                        post.voteSelectedOne) {
                                      MyProfilePageController(context: context)
                                          .handleUpdateVote(
                                              post.id,
                                              post.votes[j].id,
                                              post.votes[i].id);
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
                                  MyProfilePageController(context: context)
                                      .handleVote(post.id, post.votes[i].id);
                                } else {
                                  MyProfilePageController(context: context)
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
                if (post.votes.length >= 10) {
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
                    MyProfilePageController(context: context)
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
                                image:
                                    NetworkImage(post.pictures[1].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[2].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[0].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[1].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[2].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[3].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[0].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[1].pictureUrl),
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
                                image:
                                    NetworkImage(post.pictures[2].pictureUrl),
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
                                    image: NetworkImage(
                                        post.pictures[3].pictureUrl),
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
                      if (Global.storageService
                          .permissionCounselReactionCreate())
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              MyProfilePageController(context: context)
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
                      if (Global.storageService
                          .permissionCounselCommentCreate())
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
                                    child:
                                        Image.asset('assets/icons/comment.png'),
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
              ],
            ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            height: 5.h,
            color: AppColors.elementLight,
          ),
        ],
      ),
    ),
  );
}

Widget listCommentAdvise(
    BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<MyProfilePageBloc>(context)
                  .state
                  .commentAdvises
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<MyProfilePageBloc>(context)
                .state
                .statusCommentAdvise) {
              case Status.loading:
                return Column(
                  children: [
                    myProfile(context),
                    Container(
                      height: 10.h,
                    ),
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<MyProfilePageBloc>().add(PageEvent(value));
                    }),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<MyProfilePageBloc>(context)
                    .state
                    .commentAdvises
                    .isEmpty) {
                  return Column(
                    children: [
                      myProfile(context),
                      Container(
                        height: 10.h,
                      ),
                      buildButtonChooseNewsOrEvent(context, (value) {
                        context.read<MyProfilePageBloc>().add(PageEvent(value));
                      }),
                      Container(
                        height: 10.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<MyProfilePageBloc>(context)
                        .state
                        .commentAdvises
                        .length) {
                  if (BlocProvider.of<MyProfilePageBloc>(context)
                      .state
                      .hasReachedMaxCommentAdvise) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        myProfile(context),
                        Container(
                          height: 10.h,
                        ),
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context
                              .read<MyProfilePageBloc>()
                              .add(PageEvent(value));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        commentAdvise(
                            context,
                            BlocProvider.of<MyProfilePageBloc>(context)
                                .state
                                .commentAdvises[index]),
                      ],
                    );
                  } else {
                    return commentAdvise(
                        context,
                        BlocProvider.of<MyProfilePageBloc>(context)
                            .state
                            .commentAdvises[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget commentAdvise(BuildContext context, Comment comment) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        "/postAdviseDetail",
        arguments: {
          "id": comment.post!.id,
        },
      );
    },
    child: Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(bottom: 0.h),
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
                  width: 55.w,
                  height: 55.h,
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
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 260.w,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 5.w, right: 10.w, top: 2.h, bottom: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${comment.creator.fullName}',
                                        style: TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          // Make this part bold
                                          fontFamily: AppFonts.Header,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' đã bình luận trong bài viết ',
                                        style: TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: AppFonts.Header,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${comment.post!.title}',
                                        style: TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          // Make this part bold
                                          fontFamily: AppFonts.Header,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              // Khoảng cách giữa tên và nội dung
                              Text(
                                comment.content,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: AppFonts.Header,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2.h),
                                child: Text(
                                  handleDateTime1(comment.createAt),
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: AppFonts.Header,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
        ],
      ),
    ),
  );
}
