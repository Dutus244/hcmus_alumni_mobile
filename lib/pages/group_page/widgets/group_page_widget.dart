import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_participant_count.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/group_page_controller.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/group_page_blocs.dart';
import '../bloc/group_page_events.dart';
import '../bloc/group_page_states.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/applicationPage",
                        (route) => false,
                    arguments: {"route": 0, "secondRoute": 0},
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 0.w),
                  child: SizedBox(
                    width: 60.w,
                    height: 120.h,
                    child: Image.asset("assets/images/logos/logo.png"),
                  ),
                ),
              ),
              Container(
                width: 30.w,
              )
            ],
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
            width: 90.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/groupCreate",
                          (route) => false,
                      arguments: {"route": 3},
                    );
                  },
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/add.png"))),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/chat.png"))),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 20.w,
                  height: 20.w,
                  margin: EdgeInsets.only(),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/signIn");
                    },
                    child: Global.storageService.getUserIsLoggedIn()
                        ? CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                      AssetImage("assets/images/test1.png"),
                    )
                        : Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage("assets/icons/login.png"))),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget buildButtonChoose(BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            if (func != null) {
              func(0);
            }
          },
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider
                  .of<GroupPageBloc>(context)
                  .state
                  .page == 1
                  ? AppColors.primarySecondaryElement
                  : AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Khám phá',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                    BlocProvider
                        .of<GroupPageBloc>(context)
                        .state
                        .page == 1
                        ? AppColors.primaryElement
                        : AppColors.primaryBackground),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (func != null) {
              func(1);
            }
          },
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider
                  .of<GroupPageBloc>(context)
                  .state
                  .page == 1
                  ? AppColors.primaryElement
                  : AppColors.primarySecondaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Nhóm của bạn',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                    BlocProvider
                        .of<GroupPageBloc>(context)
                        .state
                        .page == 1
                        ? AppColors.primaryBackground
                        : AppColors.primaryElement),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget listGroupDiscover(BuildContext context,
    ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: (BlocProvider
              .of<GroupPageBloc>(context)
              .state
              .groupDiscover
              .length +
              1) ~/
              2 + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider
                .of<GroupPageBloc>(context)
                .state
                .statusGroupDiscover) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<GroupPageBloc>().add(PageEvent(1));
                    }),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider
                    .of<GroupPageBloc>(context)
                    .state
                    .groupDiscover
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<GroupPageBloc>().add(PageEvent(1));
                      }),
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
                    BlocProvider
                        .of<GroupPageBloc>(context)
                        .state
                        .groupDiscover
                        .length / 2) {
                  if (BlocProvider
                      .of<GroupPageBloc>(context)
                      .state
                      .hasReachedMaxGroupDiscover) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChoose(context, (value) {
                          context.read<GroupPageBloc>().add(PageEvent(1));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 10.w, left: 10.w, bottom: 5.h),
                          child: Row(
                            children: [
                              groupDiscover(
                                  context,
                                  (BlocProvider
                                      .of<GroupPageBloc>(context)
                                      .state
                                      .groupDiscover[firstIndex])),
                              Container(
                                width: 10.w,
                              ),
                              if (secondIndex <
                                  BlocProvider
                                      .of<GroupPageBloc>(context)
                                      .state
                                      .groupDiscover
                                      .length)
                                groupDiscover(
                                    context,
                                    BlocProvider
                                        .of<GroupPageBloc>(context)
                                        .state
                                        .groupDiscover[secondIndex]),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container(
                      margin:
                      EdgeInsets.only(right: 10.w, left: 10.w, bottom: 5.h),
                      child: Row(
                        children: [
                          groupDiscover(
                              context,
                              (BlocProvider
                                  .of<GroupPageBloc>(context)
                                  .state
                                  .groupDiscover[firstIndex])),
                          Container(
                            width: 10.w,
                          ),
                          if (secondIndex <
                              BlocProvider
                                  .of<GroupPageBloc>(context)
                                  .state
                                  .groupDiscover
                                  .length)
                            groupDiscover(
                                context,
                                BlocProvider
                                    .of<GroupPageBloc>(context)
                                    .state
                                    .groupDiscover[secondIndex]),
                        ],
                      ),
                    );
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget groupDiscover(BuildContext context, Group group) {
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = 'Nhóm Công khai';
  } else {
    typeGroup = 'Nhóm Riêng tư';
  }
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => infoGroup(context, group),
      );
    },
    child: Container(
      width: 165.w,
      height: 225.h,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.primarySecondaryElement,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  image: DecorationImage(
                    image: NetworkImage(group.coverUrl ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 165.w,
                height: 90.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                child: Text(
                  group.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Text(
                  typeGroup + ' - ${handleParticipantCount(group.participantCount)} thành viên',
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.Header3,
                  ),
                ),
              ),
              if (group.privacy == 'PUBLIC')
                Container(
                margin: EdgeInsets.only(left: 10.w, top: 2.h, right: 10.w),
                height: 25.h,
                child: Row(
                  children: [
                    Container(
                        width: 40.w,
                        child: Stack(
                          children: [
                            for (var i = 0; i < 2; i += 1)
                              Positioned(
                                left: (0 + i * 16).w,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: null,
                                  backgroundImage:
                                  AssetImage("assets/images/test1.png"),
                                ),
                              )
                          ],
                        )
                    ),
                    Container(
                      width: 90.w,
                      child: Text(
                        'Trần Phúc và 27 người bạn là thành viên',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.primarySecondaryText,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.Header3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5.h,
            left: 10.w,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                GroupPageController(context: context).handleRequestJoinGroup(group);
              },
              child: group.isRequestPending ? Container(
                width: 145.w,
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ) : Container(
                width: 145.w,
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
                    'Tham gia',
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBackground,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget infoGroup(BuildContext context, Group group) {
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = 'Nhóm Công khai';
  } else {
    typeGroup = 'Nhóm Riêng tư';
  }

  return Container(
    height: 600.h,
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
                    "/groupDetail",
                        (route) => false,
                    arguments: {
                      "id": group.id,
                      "secondRoute": 0,
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(group.coverUrl ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 150.h,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                child: Text(
                  group.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Text(
                  typeGroup + ' - ${handleParticipantCount(group.participantCount)} thành viên',
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.Header3,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                height: 1.h,
                color: AppColors.primarySecondaryText.withOpacity(0.2),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Text(
                  'Giới thiệu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ExpandableText(
                  group.description,
                  maxLines: 3,
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
              if (group.privacy == 'PUBLIC')
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 5.h),
                    child: Text(
                      'Thành viên',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 5.h),
                    height: 25.h,
                    child: Stack(
                      children: [
                        for (var i = 0; i < 10; i += 1)
                          Positioned(
                            left: (0 + i * 16).w,
                            child: CircleAvatar(
                              radius: 12,
                              child: null,
                              backgroundImage:
                              AssetImage("assets/images/test1.png"),
                            ),
                          )
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      'Nguyễn Đinh Quang Khánh. Minh Phúc và 9 người bạn khác đã tham gia',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Text(
                  'Hoạt động trong nhóm',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/user.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text('Tổng số ${handleParticipantCount(group.participantCount)} thành viên', style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header2,
                    ),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/group.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text('Tạo khoảng ${timeDifference(group.createAt)}', style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header2,
                    ),)
                  ],
                ),
              ),
              Container(
                height: 70.h,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0.h,
          left: 0.w,
          right: 0.w,
          child: Container(
            height: 60.h,
            color: AppColors.primaryBackground,
            child: GestureDetector(
              onTap: () {
                GroupPageController(context: context).handleRequestJoinGroup(group);
              },
              child: group.isRequestPending ? Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ) : Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBackground,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget listGroupJoined(BuildContext context,
    ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
          BlocProvider
              .of<GroupPageBloc>(context)
              .state
              .groupJoined
              .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider
                .of<GroupPageBloc>(context)
                .state
                .statusGroupJoined) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<GroupPageBloc>().add(PageEvent(0));
                    }),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider
                    .of<GroupPageBloc>(context)
                    .state
                    .groupJoined
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<GroupPageBloc>().add(PageEvent(0));
                      }),
                      Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: Text(
                              'Bạn chưa tham gia nhóm nào',
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
                    BlocProvider
                        .of<GroupPageBloc>(context)
                        .state
                        .groupJoined
                        .length) {
                  if (BlocProvider
                      .of<GroupPageBloc>(context)
                      .state
                      .hasReachedMaxGroupJoined) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChoose(context, (value) {
                          context.read<GroupPageBloc>().add(PageEvent(0));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        groupJoined(
                            context,
                            (BlocProvider
                                .of<GroupPageBloc>(context)
                                .state
                                .groupJoined[index])),
                      ],
                    );
                  } else {
                    return groupJoined(
                        context,
                        (BlocProvider
                            .of<GroupPageBloc>(context)
                            .state
                            .groupJoined[index]));
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget groupJoined(BuildContext context, Group group) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/groupDetail",
            (route) => false,
        arguments: {
          "id": group.id,
          "secondRoute": 1,
        },
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.h),
                  image: DecorationImage(
                    image: NetworkImage(group.coverUrl ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                group.name,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppFonts.Header2,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
