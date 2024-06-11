import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/event.dart';
import '../bloc/other_profile_page_blocs.dart';
import '../bloc/other_profile_page_states.dart';

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
  bool isFriend = true;
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
          if (!isFriend)
            GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              width: 160.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
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
                      color: AppColors.primaryBackground,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      'Thêm bạn bè',
                      style: TextStyle(
                        fontFamily: AppFonts.Header2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!isFriend)
            GestureDetector(
            onTap: () {

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
                      color: AppColors.primaryText,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      'Nhắn tin',
                      style: TextStyle(
                        fontFamily: AppFonts.Header2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isFriend)
            GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => deleteFriend(context),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
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
                      "assets/icons/friend.svg",
                      width: 20.w,
                      height: 20.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      'Bạn bè',
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
          if (isFriend)
            GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w, top: 10.h),
              width: 160.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
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
                      color: AppColors.primaryBackground,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      'Nhắn tin',
                      style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBackground
                      ),
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
            "/otherProfileDetail",
                (route) => false,
            arguments: {"route": route},
          );
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
                  'Xem thông tin giới thiệu của Nguyễn Duy',
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

Widget deleteFriend(BuildContext context) {
  return GestureDetector(
    onTap: () {

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
              color: AppColors.primaryText,
            ),
            Container(
              width: 10.w,
            ),
            Text(
              'Huỷ kết bạn',
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

Widget listEvent(BuildContext context, ScrollController _scrollController, int route) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
          BlocProvider.of<OtherProfilePageBloc>(context).state.events.length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (
            BlocProvider.of<OtherProfilePageBloc>(context).state.statusEvent) {
              case Status.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    myProfile(context, route),
                    Container(
                      height: 10.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        'Hoạt động Nguyễn Duy đã tham gia',
                        style: TextStyle(
                          fontFamily: AppFonts.Header0,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: AppColors.secondaryHeader,
                        ),
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
                      myProfile(context, route),
                      Container(
                        height: 10.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Hoạt động Nguyễn Duy đã tham gia',
                          style: TextStyle(
                            fontFamily: AppFonts.Header0,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.secondaryHeader,
                          ),
                        ),
                      ),
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
                        myProfile(context, route),
                        Container(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Hoạt động Nguyễn Duy đã tham gia',
                            style: TextStyle(
                              fontFamily: AppFonts.Header0,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.secondaryHeader,
                            ),
                          ),
                        ),
                        Container(
                          height: 10.h,
                        ),
                        event(
                            context,
                            BlocProvider.of<OtherProfilePageBloc>(context)
                                .state
                                .events[index], route),
                      ],
                    );
                  } else {
                    return event(
                        context,
                        BlocProvider.of<OtherProfilePageBloc>(context)
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
      // context.read<OtherProfilePageBloc>().add(NewsEventPageResetEvent());
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