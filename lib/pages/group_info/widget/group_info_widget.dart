import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../model/group.dart';

Widget navigation(BuildContext context, Group group, int secondRoute) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          height: 1.h,
          color: AppColors.primarySecondaryElement,
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/groupDetail",
                        (route) => false,
                    arguments: {
                      "id": group.id,
                      "secondRoute": secondRoute,
                    },
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget infoGroup(BuildContext context, Group group, int secondRoute) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w, top: 5.h),
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
            if (group.privacy == 'PRIVATE')
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
            if (group.privacy == 'PUBLIC')
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/earth.svg",
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
                            'Công khai',
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
                              'Bất kỳ ai cũng có thể nhìn thấy mọi người trong nhóm và những gì họ đăng',
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
                            'Ngày tạo nhóm ${timeCreateGroup(group.createAt)}',
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
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 5.h),
              height: 1.h,
              color: AppColors.primarySecondaryElement,
            ),
            if (group.isJoined || group.privacy == 'PUBLIC')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        margin: EdgeInsets.only(right: 15.w, top: 5.h),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "/groupMember",
                                    (route) => false,
                                arguments: {
                                  "group": group,
                                  "secondRoute": secondRoute,
                                },
                              );
                            },
                            child: Text(
                              "Xem tất cả",
                              style: TextStyle(
                                fontFamily: AppFonts.Header1,
                                color: AppColors.primaryElement,
                                decorationColor: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            )),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.w, top: 5.h),
                      height: 25.h,
                      child: Stack(
                        children: [
                          for (var i = 0; i < 10; i += 1)
                            Positioned(
                              left: (0 + i * 20).w,
                              child: CircleAvatar(
                                radius: 15,
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
            if (group.isJoined || group.privacy == 'PUBLIC')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10.w, top: 5.h),
                      height: 25.h,
                      child: Stack(
                        children: [
                          for (var i = 0; i < 10; i += 1)
                            Positioned(
                              left: (0 + i * 20).w,
                              child: CircleAvatar(
                                radius: 15,
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
                      'Quý Trung và 3 người khác là quảng trị viên',
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
          ],
        ),
      ),
      navigation(context, group, secondRoute)
    ],
  );
}
