import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_participant_count.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/group_page_controller.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/group_page_blocs.dart';
import '../bloc/group_page_events.dart';
import '../bloc/group_page_states.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
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
                    arguments: {"route": 0},
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
              if (Global.storageService.permissionGroupCreate())
                Container(
                  width: 30.w,
                ),
            ],
          ),
          Text(
            translate('group'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
              color: AppColors.secondaryHeader,
            ),
          ),
          Container(
            width:
                (Global.storageService.permissionGroupCreate() ? 30.w : 0.w) +
                    60.w,
            child: Row(
              children: [
                if (Global.storageService.permissionGroupCreate())
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            "/groupCreate",
                          );
                          GroupPageController(context: context)
                              .handleLoadGroupDiscoverData(0);
                          GroupPageController(context: context)
                              .handleLoadGroupJoinedData(0);
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
                    ],
                  ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/chatPage");
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/chat.png"))),
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
                Container(
                  width: 20.w,
                  height: 20.w,
                  margin: EdgeInsets.only(),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/myProfilePage",
                        );
                      },
                      child: CircleAvatar(
                        radius: 10,
                        child: null,
                        backgroundImage: NetworkImage(
                            Global.storageService.getUserAvatarUrl()),
                      )),
                ),
                SizedBox(width: 10.w),
              ],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget buildButton(BuildContext context, String buttonText, String iconName) {
  return Container(
    width: 340.w,
    height: 40.h,
    margin: EdgeInsets.only(bottom: 10.h, top: 0.h),
    child: ElevatedButton(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          "/groupSearch",
        );
        GroupPageController(context: context)
            .handleLoadGroupDiscoverData(0);
        GroupPageController(context: context)
            .handleLoadGroupJoinedData(0);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.element,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          side: BorderSide(color: AppColors.primaryFourthElementText),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            buttonText,
            style: TextStyle(
              fontFamily: AppFonts.Header,
              color: AppColors.textBlack,
              fontWeight: FontWeight.normal,
              fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
            ),
          ),
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(right: 10.w),
            child: Image.asset("assets/icons/$iconName.png"),
          ),
        ],
      ),
    ),
  );
}

Widget buildButtonChoose(BuildContext context, void Function(int value)? func) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => {
            if (BlocProvider.of<GroupPageBloc>(context).state.page != 0)
              {func!(0)}
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('discover'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<GroupPageBloc>(context).state.page == 0
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<GroupPageBloc>(context).state.page == 0)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => {
            if (BlocProvider.of<GroupPageBloc>(context).state.page != 1)
              {func!(1)}
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('your_group'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<GroupPageBloc>(context).state.page == 1
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<GroupPageBloc>(context).state.page == 1)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget listGroupDiscover(
    BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: (BlocProvider.of<GroupPageBloc>(context)
                          .state
                          .groupDiscovers
                          .length +
                      1) ~/
                  2 +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<GroupPageBloc>(context)
                .state
                .statusGroupDiscover) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<GroupPageBloc>().add(PageEvent(1));
                    }),
                    Container(
                      height: 5.h,
                    ),
                    buildButton(context, 'Tìm kiếm nhóm', 'search'),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<GroupPageBloc>(context)
                    .state
                    .groupDiscovers
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<GroupPageBloc>().add(PageEvent(1));
                      }),
                      Container(
                        height: 5.h,
                      ),
                      buildButton(context, 'Tìm kiếm nhóm', 'search'),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                11.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<GroupPageBloc>(context)
                            .state
                            .groupDiscovers
                            .length /
                        2) {
                  if (BlocProvider.of<GroupPageBloc>(context)
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
                          height: 5.h,
                        ),
                        buildButton(context, 'Tìm kiếm nhóm', 'search'),
                        Container(
                          height: 5.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 10.w, left: 10.w, bottom: 5.h),
                          child: Row(
                            children: [
                              groupDiscover(
                                  context,
                                  (BlocProvider.of<GroupPageBloc>(context)
                                      .state
                                      .groupDiscovers[firstIndex])),
                              Container(
                                width: 10.w,
                              ),
                              if (secondIndex <
                                  BlocProvider.of<GroupPageBloc>(context)
                                      .state
                                      .groupDiscovers
                                      .length)
                                groupDiscover(
                                    context,
                                    BlocProvider.of<GroupPageBloc>(context)
                                        .state
                                        .groupDiscovers[secondIndex]),
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
                              (BlocProvider.of<GroupPageBloc>(context)
                                  .state
                                  .groupDiscovers[firstIndex])),
                          Container(
                            width: 10.w,
                          ),
                          if (secondIndex <
                              BlocProvider.of<GroupPageBloc>(context)
                                  .state
                                  .groupDiscovers
                                  .length)
                            groupDiscover(
                                context,
                                BlocProvider.of<GroupPageBloc>(context)
                                    .state
                                    .groupDiscovers[secondIndex]),
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
    typeGroup = '${translate('group')} ${translate('public')}';
  } else {
    typeGroup = '${translate('group')} ${translate('private')}';
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
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
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
                    fontSize: 13.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Text(
                  typeGroup +
                      ' - ${handleParticipantCount(group.participantCount)} ${translate('members').toLowerCase()}',
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.Header,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/tag.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 2.w),
                      width: 125.w,
                      child: Text(
                        group.tags.map((tag) => tag.name).join(' '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize:
                              10.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 5, 90, 188),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // if (group.privacy == 'PUBLIC')
              //   Container(
              //     margin: EdgeInsets.only(left: 10.w, top: 2.h, right: 10.w),
              //     height: 35.h,
              //     child: Row(
              //       children: [
              //         Container(
              //             margin: EdgeInsets.only(top: 5.h),
              //             width: 40.w,
              //             child: Stack(
              //               children: [
              //                 for (var i = 0; i < 2; i += 1)
              //                   Positioned(
              //                     left: (0 + i * 16).w,
              //                     child: CircleAvatar(
              //                       radius: 12,
              //                       child: null,
              //                       backgroundImage:
              //                           AssetImage("assets/images/test1.png"),
              //                     ),
              //                   )
              //               ],
              //             )),
              //         Container(
              //           width: 90.w,
              //           child: Text(
              //             'Trần Phúc và 27 người bạn là thành viên',
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //             style: TextStyle(
              //               color: AppColors.textGrey,
              //               fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
              //               fontWeight: FontWeight.normal,
              //               fontFamily: AppFonts.Header,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
            ],
          ),
          if (Global.storageService.permissionGroupJoin())
            Positioned(
              bottom: 5.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                width: 145.w,
                height: 30.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (BlocProvider.of<GroupPageBloc>(context)
                        .state
                        .isLoading) {
                      return;
                    }
                    if (group.isRequestPending) {
                      return;
                    }
                    GroupPageController(context: context)
                        .handleRequestJoinGroup(group);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: group.isRequestPending
                        ? Color.fromARGB(255, 230, 230, 230)
                        : AppColors.element,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    padding: EdgeInsets.zero, // Remove default padding
                    minimumSize: Size(145.w, 30.h), // Set button size
                  ),
                  child: Center(
                    child: Text(
                      group.isRequestPending
                          ? translate('waiting_approval')
                          : translate('join'),
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize:
                            12.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: group.isRequestPending
                            ? AppColors.textBlack
                            : AppColors.background,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!Global.storageService.permissionGroupJoin())
            Positioned(
              bottom: 5.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                width: 145.w,
                height: 30.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/myProfileEdit",
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black.withOpacity(0.5),
                    backgroundColor: Color.fromARGB(255, 245, 245, 245),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    padding: EdgeInsets.zero, // Remove default padding
                    minimumSize: Size(145.w, 30.h), // Set button size
                  ),
                  child: Center(
                    child: Text(
                      'Xét duyệt để tham gia',
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontSize:
                        12.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack.withOpacity(0.5),
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
    typeGroup = '${translate('group')} ${translate('public')}';
  } else {
    typeGroup = '${translate('group')} ${translate('private')}';
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
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    "/groupDetail",
                    arguments: {
                      "id": group.id,
                    },
                  );
                  GroupPageController(context: context)
                      .handleLoadGroupDiscoverData(0);
                  GroupPageController(context: context)
                      .handleLoadGroupJoinedData(0);
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
                    fontSize: 20.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Text(
                  typeGroup +
                      ' - ${handleParticipantCount(group.participantCount)} ${translate('members').toLowerCase()}',
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.Header,
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
                      width: 125.w,
                      child: Text(
                        group.tags.map((tag) => tag.name).join(' '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.xSmall(context)
                            .withColor(AppColors.tag),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                height: 1.h,
                color: AppColors.textGrey.withOpacity(0.2),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Text(
                  translate('introduce'),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
                width: MediaQuery.of(context).size.width,
                child: ExpandableText(
                  group.description,
                  maxLines: 3,
                  expandText: translate('see_more'),
                  collapseText: translate('collapse'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
              // if (group.privacy == 'PUBLIC')
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(left: 10.w, top: 5.h),
              //         child: Text(
              //           translate('member'),
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
              //             fontWeight: FontWeight.bold,
              //             fontFamily: AppFonts.Header,
              //           ),
              //         ),
              //       ),
              //       Container(
              //           margin: EdgeInsets.only(left: 10.w, top: 5.h),
              //           height: 25.h,
              //           child: Stack(
              //             children: [
              //               for (var i = 0; i < 10; i += 1)
              //                 Positioned(
              //                   left: (0 + i * 16).w,
              //                   child: CircleAvatar(
              //                     radius: 12,
              //                     child: null,
              //                     backgroundImage:
              //                         AssetImage("assets/images/test1.png"),
              //                   ),
              //                 )
              //             ],
              //           )),
              //       Container(
              //         margin: EdgeInsets.only(left: 10.w, right: 10.w),
              //         child: Text(
              //           'Nguyễn Đinh Quang Khánh. Minh Phúc và 9 người bạn khác đã tham gia',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
              //             fontWeight: FontWeight.normal,
              //             fontFamily: AppFonts.Header,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.h),
                child: Text(
                  translate('group_activities'),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
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
                      color: AppColors.textBlack,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      '${translate('total')} ${handleParticipantCount(group.participantCount)} ${translate('members').toLowerCase()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            12.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header,
                      ),
                    )
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
                      color: AppColors.textBlack,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      '${translate('created_about')} ${handleTimeDifference1(group.createAt)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            12.sp / MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 70.h,
              )
            ],
          ),
        ),
        if (Global.storageService.permissionGroupJoin())
          Positioned(
            bottom: 0.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              height: 60.h,
              color: AppColors.background,
              child: Container(
                margin: EdgeInsets.only(
                    left: 10.w, right: 10.w, bottom: 20.h),
                height: 30.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (BlocProvider.of<GroupPageBloc>(context)
                        .state
                        .isLoading) {
                      return;
                    }
                    if (group.isRequestPending) {
                      return;
                    }
                    GroupPageController(context: context).handleRequestJoinGroup(group);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: group.isRequestPending
                        ? Color.fromARGB(255, 230, 230, 230)
                        : AppColors.element,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    padding: EdgeInsets.zero, // Remove default padding
                    minimumSize: Size(double.infinity, 30.h), // Set button height
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
                    child: Center(
                      child: Text(
                        group.isRequestPending ? translate('waiting_approval') : translate('join'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: group.isRequestPending ? AppColors.textBlack : AppColors.background,
                        ),
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

Widget listGroupJoined(
    BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: (BlocProvider.of<GroupPageBloc>(context)
                          .state
                          .groupJoineds
                          .length +
                      1) ~/
                  2 +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<GroupPageBloc>(context)
                .state
                .statusGroupJoined) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<GroupPageBloc>().add(PageEvent(0));
                    }),
                    Container(
                      height: 5.h,
                    ),
                    buildButton(context, 'Tìm kiếm nhóm', 'search'),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<GroupPageBloc>(context)
                    .state
                    .groupJoineds
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<GroupPageBloc>().add(PageEvent(0));
                      }),
                      Container(
                        height: 5.h,
                      ),
                      buildButton(context, 'Tìm kiếm nhóm', 'search'),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                11.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<GroupPageBloc>(context)
                            .state
                            .groupJoineds
                            .length /
                        2) {
                  if (BlocProvider.of<GroupPageBloc>(context)
                      .state
                      .hasReachedMaxGroupJoined) {
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
                          context.read<GroupPageBloc>().add(PageEvent(0));
                        }),
                        Container(
                          height: 5.h,
                        ),
                        buildButton(context, 'Tìm kiếm nhóm', 'search'),
                        Container(
                          height: 5.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 10.w, left: 10.w, bottom: 5.h),
                          child: Row(
                            children: [
                              groupJoined(
                                  context,
                                  (BlocProvider.of<GroupPageBloc>(context)
                                      .state
                                      .groupJoineds[firstIndex])),
                              Container(
                                width: 10.w,
                              ),
                              if (secondIndex <
                                  BlocProvider.of<GroupPageBloc>(context)
                                      .state
                                      .groupJoineds
                                      .length)
                                groupJoined(
                                    context,
                                    BlocProvider.of<GroupPageBloc>(context)
                                        .state
                                        .groupJoineds[secondIndex]),
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
                          groupJoined(
                              context,
                              (BlocProvider.of<GroupPageBloc>(context)
                                  .state
                                  .groupJoineds[firstIndex])),
                          Container(
                            width: 10.w,
                          ),
                          if (secondIndex <
                              BlocProvider.of<GroupPageBloc>(context)
                                  .state
                                  .groupJoineds
                                  .length)
                            groupJoined(
                                context,
                                BlocProvider.of<GroupPageBloc>(context)
                                    .state
                                    .groupJoineds[secondIndex]),
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

Widget groupJoined(BuildContext context, Group group) {
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = '${translate('group')} ${translate('public')}';
  } else {
    typeGroup = '${translate('group')} ${translate('private')}';
  }

  return GestureDetector(
    onTap: () async {
      await Navigator.pushNamed(
        context,
        "/groupDetail",
        arguments: {
          "id": group.id,
        },
      );
      GroupPageController(context: context).handleLoadGroupDiscoverData(0);
      GroupPageController(context: context).handleLoadGroupJoinedData(0);
    },
    child: Container(
      width: 165.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
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
                    fontSize: 13.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                child: Text(
                  typeGroup +
                      ' - ${handleParticipantCount(group.participantCount)} ${translate('members').toLowerCase()}',
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.Header,
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
                      width: 125.w,
                      child: Text(
                        group.tags.map((tag) => tag.name).join(' '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.xSmall(context)
                            .withColor(AppColors.tag),
                      ),
                    ),
                  ],
                ),
              ),
              // if (group.privacy == 'PUBLIC')
              //   Container(
              //     margin: EdgeInsets.only(left: 10.w, top: 2.h, right: 10.w),
              //     height: 35.h,
              //     child: Row(
              //       children: [
              //         Container(
              //             margin: EdgeInsets.only(top: 5.h),
              //             width: 40.w,
              //             child: Stack(
              //               children: [
              //                 for (var i = 0; i < 2; i += 1)
              //                   Positioned(
              //                     left: (0 + i * 16).w,
              //                     child: CircleAvatar(
              //                       radius: 12,
              //                       child: null,
              //                       backgroundImage:
              //                           AssetImage("assets/images/test1.png"),
              //                     ),
              //                   )
              //               ],
              //             )),
              //         Container(
              //           width: 90.w,
              //           child: Text(
              //             'Trần Phúc và 27 người bạn là thành viên',
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //             style: TextStyle(
              //               color: AppColors.textGrey,
              //               fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
              //               fontWeight: FontWeight.normal,
              //               fontFamily: AppFonts.Header,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    ),
  );
}
