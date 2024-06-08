import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';

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
      Expanded(child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          header(context, route),
          detail(context),
        ],
      )),
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
        margin: EdgeInsets.only(left: 10.w, top: 5.h),
        child: Text(
          'Nguyễn Duy',
          style: TextStyle(
            fontFamily: AppFonts.Header0,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppColors.secondaryHeader,
          ),
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
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/myProfileEdit", (route) => false,
              arguments: {"route": route});
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
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
      Container(
        margin: EdgeInsets.only(top: 10.h),
        height: 3.h,
        color: AppColors.primarySecondaryElement,
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