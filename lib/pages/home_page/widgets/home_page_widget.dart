import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';

import '../../../global.dart';

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
          Container(
            width: Global.storageService.getUserIsLoggedIn() ? 30.w : 17.w,
            height: Global.storageService.getUserIsLoggedIn() ? 30.h : 17.w,
            margin: EdgeInsets.only(),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/signIn");
              },
              child: Global.storageService.getUserIsLoggedIn()
                  ? CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage: AssetImage("assets/images/test1.png"),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/login.png"))),
                    ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: Global.storageService.getUserIsLoggedIn() ? 30.w : 43.w),
            child: SizedBox(
              width: 120.w,
              height: 120.h,
              child: Image.asset("assets/images/logos/logo.png"),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  width: 17.w,
                  height: 17.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/search.png"))),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                child: Container(
                  width: 17.w,
                  height: 17.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/chat.png"))),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget listEvent(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                'Sự kiện nổi bật',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/applicationPage",
                      (route) => false,
                      arguments: {"route": 1, "secondRoute": 1},
                    );
                  },
                  child: Text(
                    "Xem tất cả",
                    style: TextStyle(
                      fontFamily: 'Roboto',
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
          height: 5.h,
        ),
        SizedBox(
          height: 150.h, // Đặt chiều cao cho ListView
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10.w, right: 5.w),
                child: event(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: event(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: event(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: event(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: event(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: event(),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget event() {
  return GestureDetector(
    onTap: () {},
    child: Stack(
      children: [
        Container(
          width: 340.w,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/test1.png'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 35.h),
            child: Text(
              'Lễ tốt nghiệp thạc sĩ, tiến sĩ 2023',
              maxLines: 3,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 20.h),
            child: Text(
              '01/04/2023 - 10:00',
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
            child: Text(
              'Hội trường I - CS NVC',
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget listNews(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
    padding: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      borderRadius: BorderRadius.circular(15.w),
      border: Border.all(
        color: AppColors.primarySecondaryElement,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 0.w),
              child: Text(
                'Tin tức nổi bật',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 5.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/applicationPage",
                      (route) => false,
                      arguments: {"route": 1, "secondRoute": 0},
                    );
                  },
                  child: Text(
                    "Xem tất cả",
                    style: TextStyle(
                      fontFamily: 'Roboto',
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
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            news(),
            news(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            news(),
            news(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            news(),
            news(),
          ],
        ),
        Container(
          height: 5.h,
        )
      ],
    ),
  );
}

Widget news() {
  return Container(
    margin: EdgeInsets.only(top: 0.h, left: 2.w, right: 2.w),
    width: 160.w,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h), // Adjust as desired
            image: DecorationImage(
              image: AssetImage('assets/images/test1.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: 160.w,
          height: 80.h,
        ),
        Container(
          height: 5.h,
        ),
        Align(
          alignment: Alignment.topLeft, // Align to top left
          child: Text(
            'Từ học trò tỉnh lẹ thành giáo sư đại học Mỹ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft, // Align to top left
          child: Text(
            '01/04/2024',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Container(
          height: 5.h,
        )
      ],
    ),
  );
}

Widget listHof() {
  return Container(
    padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                'Sinh viên tiêu biểu',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15.w),
              child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Xem tất cả",
                    style: TextStyle(
                      fontFamily: 'Roboto',
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
          height: 5.h,
        ),
        SizedBox(
          height: 120.h, // Đặt chiều cao cho ListView
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10.w, right: 5.w),
                child: hof(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: hof(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: hof(),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: hof(),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget hof() {
  return Container(
    margin: EdgeInsets.only(top: 0.h, left: 2.w, right: 2.w),
    width: 160.w,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h), // Adjust as desired
            image: DecorationImage(
              image: AssetImage('assets/images/test1.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: 160.w,
          height: 80.h,
        ),
        Container(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row content
          children: [
            Text(
              'Lê Yến Thanh',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row content
          children: [
            Text(
              'Khoá 2014 - Khoa Công nghệ thông tin',
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 8.sp,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
        Container(
          height: 5.h,
        )
      ],
    ),
  );
}

Widget advise() {
  return Container(
    padding: EdgeInsets.only(top: 0.h, bottom: 5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                'Tư vấn/Cố vấn',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 5.h,
        ),
        Stack(
          children: [
            Container(
              height: 100.h,
              margin: EdgeInsets.only(top: 0.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: AppColors.primarySecondaryElement,
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                  color: AppColors.primarySecondaryElement,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h), // Adjust as desired
                  image: DecorationImage(
                    image: AssetImage('assets/images/test1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 160.w,
                height: 80.h,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                width: 150.w,
                child: Text(
                  'Giải đáp thắc mắc và tư vấn cùng đội ngũ sinh viên xịn xò',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  width: 100.w,
                  height: 30.h,
                  margin: EdgeInsets.only(top: 55.h, left: 20.w, right: 45.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Tư vấn',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBackground),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}