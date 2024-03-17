import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: Image.asset("assets/images/logos/logo.png"),
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

Widget buildCreatePostButton() {
  return Container(
    height: 40.h,
    padding: EdgeInsets.only(top: 0.h, bottom: 5.h),
    child: Row(
      children: [
        Container(
          width: 35.w,
          height: 35.h,
          margin: EdgeInsets.only(left: 15.w, right: 15.w),
          child: MaterialButton(
            onPressed: () {

            },
            color: AppColors.primaryBackground,
            textColor: Colors.white,
            padding: EdgeInsets.all(2),
            shape: CircleBorder(),
            child: ClipOval(
              child: Image.asset(
                'assets/images/test.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: 250.w,
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
                  'Tâm trạng của bạn bây giờ là gì?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
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
  );
}

Widget listEvent() {
  return Container(
    padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 5.w, right: 5.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Sự kiện',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
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
  return Stack(
    children: [
      Container(
        width: 100.w,
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/test.png'),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Lễ tốt nghiệp thạc sĩ, tiến sĩ 20233',
            maxLines: 3,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    ],
  );
}