import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popover/popover.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/function/handle_percentage_vote.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/event.dart';
import '../../../model/post.dart';
import '../bloc/my_profile_page_blocs.dart';
import '../bloc/my_profile_page_states.dart';
import '../bloc/my_profile_page_events.dart';
import '../my_profile_page_controller.dart';

AppBar buildAppBar(BuildContext context, int route) {
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/applicationPage", (route) => false,
                  arguments: {"route": route, "secondRoute": 0});
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
            'Nguyễn Duy',
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
              children: [

              ],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget myProfile(BuildContext context, int route) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      header(context, route),
      detail(context, route),
    ],
  );
}

Widget header(BuildContext context, int route) {
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
                  image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/groups/35765714-67c9-4852-8298-bc65ba6bf503/cover'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 180.h,
              width: double.infinity,
            ),
            Positioned(
              left: 10.w,
              bottom: 0.h, // Đẩy CircleAvatar xuống dưới một nửa chiều cao của nó để nó nằm ở mép
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/groups/35765714-67c9-4852-8298-bc65ba6bf503/cover'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(65.w),
                  border: Border.all(
                    color: Colors.white,
                    width: 5.w, // Thay đổi giá trị width để làm cho viền dày hơn
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
              'Nguyễn Duy',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            Container(
              width: 5.w,
            ),
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
                margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
                child: Text(
                  'Tài khoản chưa xác thực',
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 0.h),
        child: Row(
          children: [
            Text(
              '300',
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            Text(
              ' bạn bè',
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: AppColors.primarySecondaryText,
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/myProfileEdit", (route) => false,
                  arguments: {"route": route});
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
                      color: AppColors.primaryText,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      'Chỉnh sửa trang cá nhân',
                      style: TextStyle(
                        fontFamily: AppFonts.Header2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/optionPage", (route) => false,
                  arguments: {"route": route});
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
                      color: AppColors.primaryText,
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
        color: AppColors.primarySecondaryElement,
      ),
    ],
  );
}

Widget detail(BuildContext context, int route) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 10.h),
        child:  Text(
          'Chi tiết',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
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
                'Học tại Trường Đại học Khoa học Tự nhiên, Đại học Quốc gia TP.HCM',
                style: TextStyle(
                  fontFamily: AppFonts.Header2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryText,
                ),
              ),
            )
          ],
        ),
      ),
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
                'Đã làm việc tại Trường Đại học Khoa học Tự nhiên, Đại học Quốc gia TP.HCM',
                style: TextStyle(
                  fontFamily: AppFonts.Header2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryText,
                ),
              ),
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/myProfileEdit", (route) => false,
              arguments: {"route": route});
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
          child: Row(
            children: [
              Container(
                width: 17.w,
                height: 17.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/3dot.png"))),
              ),
              Container(
                width: 10.w,
              ),
              Container(
                width: 310.w,
                child: Text(
                  'Xem thông tin giới thiệu của bạn',
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryText,
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
        color: AppColors.primarySecondaryElement,
      ),
    ],
  );
}

Widget listFriend(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 10.h),
        child:  Text(
          'Bạn bè',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, top: 2.h),
        child:  Text(
          '300 người bạn',
          style: TextStyle(
            fontFamily: AppFonts.Header3,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.primarySecondaryText,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    image: DecorationImage(
                      image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90.h,
                  width: 90.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    'Phạm Huỳnh Bảo Anh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    image: DecorationImage(
                      image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90.h,
                  width: 90.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    'Phạm Huỳnh Bảo Anh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    image: DecorationImage(
                      image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90.h,
                  width: 90.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    'Phạm Huỳnh Bảo Anh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    image: DecorationImage(
                      image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90.h,
                  width: 90.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    'Phạm Huỳnh Bảo Anh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    image: DecorationImage(
                      image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90.h,
                  width: 90.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    'Phạm Huỳnh Bảo Anh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    image: DecorationImage(
                      image: NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90.h,
                  width: 90.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 110.w,
                  height: 30.h,
                  child: Text(
                    'Phạm Huỳnh Bảo Anh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildButtonChooseNewsOrEvent(
    BuildContext context, void Function(int value)? func) {
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
              color: BlocProvider.of<MyProfilePageBloc>(context).state.page == 1
                  ? AppColors.primarySecondaryElement
                  : AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Tư vấn & cố vấn',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: BlocProvider.of<MyProfilePageBloc>(context)
                        .state
                        .page ==
                        1
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
              color: BlocProvider.of<MyProfilePageBloc>(context).state.page == 1
                  ? AppColors.primaryElement
                  : AppColors.primarySecondaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Sự kiện đã tham gia',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: BlocProvider.of<MyProfilePageBloc>(context)
                        .state
                        .page ==
                        1
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

Widget listEvent(BuildContext context, ScrollController _scrollController, int route) {
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
                    myProfile(context, route),
                    Container(
                      height: 10.h,
                    ),
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<MyProfilePageBloc>().add(PageEvent(0));
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
                      myProfile(context, route),
                      Container(
                        height: 10.h,
                      ),
                      buildButtonChooseNewsOrEvent(context, (value) {
                        context.read<MyProfilePageBloc>().add(PageEvent(0));
                      }),
                      Container(
                        height: 10.h,
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
                        myProfile(context, route),
                        Container(
                          height: 10.h,
                        ),
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context.read<MyProfilePageBloc>().add(PageEvent(0));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        event(
                            context,
                            BlocProvider.of<MyProfilePageBloc>(context)
                                .state
                                .events[index], route),
                      ],
                    );
                  } else {
                    return event(
                        context,
                        BlocProvider.of<MyProfilePageBloc>(context)
                            .state
                            .events[index], route);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget event(BuildContext context, Event event, int route) {
  return GestureDetector(
    onTap: () {
      // context.read<MyProfilePageBloc>().add(NewsEventPageResetEvent());
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/eventDetail",
            (route) => false,
        arguments: {"route": route, "id": event.id, "profile": 1},
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
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      handleDatetime(event.publishedAt),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
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
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.views.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
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
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.participants.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
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
                  color: AppColors.primarySecondaryText,
                ),
                for (int i = 0; i < event.tags.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Text(
                      event.tags[i].name,
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
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
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
                    'Địa điểm:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
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
                        fontFamily: AppFonts.Header3,
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
                    'Thời gian:',
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
                    handleDatetime(event.organizationTime),
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
                      color: AppColors.primaryElement,
                    ),
                    child: Text(
                      event.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header3,
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
            color: AppColors.primarySecondaryElement,
          ),
          Container(
            height: 10.h,
          ),
        ],
      ),
    ),
  );
}

Widget listPosts(BuildContext context, ScrollController _scrollController, int route) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
          BlocProvider.of<MyProfilePageBloc>(context).state.posts.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<MyProfilePageBloc>(context).state.statusPost) {
              case Status.loading:
                return Column(
                  children: [
                    myProfile(context, route),
                    Container(
                      height: 10.h,
                    ),
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<MyProfilePageBloc>().add(PageEvent(1));
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
                      myProfile(context, route),
                      Container(
                        height: 10.h,
                      ),
                      buildButtonChooseNewsOrEvent(context, (value) {
                        context.read<MyProfilePageBloc>().add(PageEvent(1));
                      }),
                      Container(
                        height: 10.h,
                      ),
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
                        myProfile(context, route),
                        Container(
                          height: 10.h,
                        ),
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context.read<MyProfilePageBloc>().add(PageEvent(1));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        post(
                            context,
                            BlocProvider.of<MyProfilePageBloc>(context)
                                .state
                                .posts[index], route),
                      ],
                    );
                  } else {
                    return post(
                        context,
                        BlocProvider.of<MyProfilePageBloc>(context)
                            .state
                            .posts[index], route);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget postOption(BuildContext context, Post post, int route) {
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
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/editPostAdvise",
                        (route) => false,
                    arguments: {
                      "route": route,
                      "post": post,
                      "profile": 1,
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
              BlocBuilder<MyProfilePageBloc, MyProfilePageState>(
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
                          if (post.permissions.delete)
                            GestureDetector(
                              onTap: () {
                                MyProfilePageController(context: context)
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

Widget post(BuildContext context, Post post, int route) {
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
                      builder: (ctx) => postOption(context, post, route),
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
                              for (int j = 0; j < post.votes.length; j += 1) {
                                if (post.votes[j].name == post.voteSelectedOne) {
                                  MyProfilePageController(context: context)
                                      .handleUpdateVote(post.id, post.votes[j].id, post.votes[i].id);
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
                              fontFamily: AppFonts.Header2,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primarySecondaryText),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/advisePageListVoters",
                            (route) => false,
                        arguments: {
                          "vote": post.votes[i],
                          "post": post,
                          "profile": 1,
                          "route": route,
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                          style: TextStyle(
                              fontFamily: AppFonts.Header2,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElement),
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
        Container(
          height: 5.h,
        ),
        if (post.pictures.length == 1)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/listPicturePostAdvise",
                    (route) => false,
                arguments: {
                  "post": post,
                  "profile": 1,
                  "route": route,
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
                "/listPicturePostAdvise",
                    (route) => false,
                arguments: {
                  "post": post,
                  "profile": 1,
                  "route": route,
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
                "/listPicturePostAdvise",
                    (route) => false,
                arguments: {
                  "post": post,
                  "profile": 1,
                  "route": route,
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
                "/listPicturePostAdvise",
                    (route) => false,
                arguments: {
                  "post": post,
                  "profile": 1,
                  "route": route,
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
                "/listPicturePostAdvise",
                    (route) => false,
                arguments: {
                  "post": post,
                  "profile": 1,
                  "route": route,
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
                    "/listInteractPostAdvise",
                        (route) => false,
                    arguments: {
                      "route": route,
                      "id": post.id,
                      "profile": 1,
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
                      "route": route,
                      "id": post.id,
                      "profile": 1,
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
        if (Global.storageService.permissionCounselReactionCreate() || Global.storageService.permissionCounselCommentCreate())
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5.h),
                height: 1.h,
                color: AppColors.primarySecondaryElement,
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
                    if (Global.storageService.permissionCounselCommentCreate())
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/listCommentPostAdvise",
                                  (route) => false,
                              arguments: {
                                "route": route,
                                "id": post.id,
                                "profile": 1,
                              },
                            );
                          },
                          child: Container(
                            margin: Global.storageService.permissionCounselReactionCreate() ? EdgeInsets.only(right: 40.w) : EdgeInsets.only(left: 40.w),
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
            ],
          ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          height: 5.h,
          color: AppColors.primarySecondaryElement,
        ),
      ],
    ),
  );
}