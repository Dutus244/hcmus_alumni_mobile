import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/common/values/fonts.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:intl/intl.dart';

import '../../../global.dart';
import '../../../model/hall_of_fame.dart';
import '../../../model/news.dart';

Widget listEvent(BuildContext context, List<Event> eventList) {
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
                  fontFamily: AppFonts.Header1,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColors.primaryHeader,
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
          height: 5.h,
        ),
        SizedBox(
          height: 150.h, // Đặt chiều cao cho ListView
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < eventList.length; i += 1)
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 5.w),
                  child: event(context, eventList[i]),
                ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget event(BuildContext context, Event event) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/eventDetail",
        (route) => false,
        arguments: {
          "route": 0,
          "event": event,
        },
      );
    },
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
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            height: 150.h,
            padding: EdgeInsets.only(left: 10.w, right: 5.w, bottom: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 24, 59, 86).withOpacity(0.6),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 20.h,
            margin: EdgeInsets.only(left: 10.w, top: 5.h),
            padding:
                EdgeInsets.only(left: 10.w, right: 10.w, bottom: 2.h, top: 2.h),
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
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            padding: EdgeInsets.only(left: 10.w, right: 5.w, bottom: 35.h),
            child: Text(
              event.title,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.Header2,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            padding: EdgeInsets.only(left: 10.w, right: 5.w, bottom: 20.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/location.svg",
                  width: 12.w,
                  height: 12.h,
                  color: Color.fromARGB(255, 255, 95, 92),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  width: 300.w,
                  child: Text(
                    event.organizationLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 340.w,
            padding: EdgeInsets.only(left: 10.w, right: 5.w, bottom: 5.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/time.svg",
                  width: 12.w,
                  height: 12.h,
                  color: Color.fromARGB(255, 153, 214, 216),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  handleDatetime(event.organizationTime),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.Header3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget listNews(BuildContext context, List<News> newsList) {
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
                  fontFamily: AppFonts.Header1,
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
                    fontFamily: AppFonts.Header1,
                    color: AppColors.primaryElement,
                    decorationColor: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 5.h,
        ),
        for (int i = 0; i < newsList.length; i += 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              news(context, newsList[i]),
              if (i + 1 < newsList.length) news(context, newsList[i + 1]),
            ],
          ),
        Container(
          height: 5.h,
        ),
      ],
    ),
  );
}

Widget news(BuildContext context, News news) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/newsDetail",
        (route) => false,
        arguments: {
          "route": 0,
          "id": news.id,
        },
      );
    },
    child: Container(
      margin: EdgeInsets.only(top: 0.h, left: 2.w, right: 2.w),
      width: 160.w,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  // Adjust as desired
                  image: DecorationImage(
                    image: NetworkImage(news.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 160.w,
                height: 80.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 15.h,
                  margin: EdgeInsets.only(left: 5.w, top: 5.h),
                  padding: EdgeInsets.only(
                      left: 2.w, right: 2.w, bottom: 2.h, top: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    shape: BoxShape.rectangle,
                    color: AppColors.primaryElement,
                  ),
                  child: Text(
                    news.faculty.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.topLeft, // Align to top left
            child: Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.Header2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft, // Align to top left
            child: Text(
              handleDatetime(news.publishedAt),
              style: TextStyle(
                color: AppColors.primarySecondaryText,
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                fontFamily: AppFonts.Header3,
              ),
            ),
          ),
          Container(
            height: 5.h,
          )
        ],
      ),
    ),
  );
}

Widget listHof(BuildContext context, List<HallOfFame> hallOfFameList) {
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
                'Gương thành công',
                style: TextStyle(
                  fontFamily: AppFonts.Header1,
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
                      "/hofPage",
                      (route) => false,
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
          height: 5.h,
        ),
        SizedBox(
          height: 120.h, // Đặt chiều cao cho ListView
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < hallOfFameList.length; i += 1)
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 5.w),
                  child: hof(context, hallOfFameList[i]),
                ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget hof(BuildContext context, HallOfFame hallOfFame) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/hofDetail",
            (route) => false,
        arguments: {
          "route": 0,
          "id": hallOfFame.id,
        },
      );
    },
    child: Container(
      margin: EdgeInsets.only(top: 0.h, left: 2.w, right: 2.w),
      width: 160.w,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  // Adjust as desired
                  image: DecorationImage(
                    image: NetworkImage(
                        hallOfFame.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 160.w,
                height: 80.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 15.h,
                  margin: EdgeInsets.only(left: 5.w, top: 5.h),
                  padding: EdgeInsets.only(
                      left: 2.w, right: 2.w, bottom: 2.h, top: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    shape: BoxShape.rectangle,
                    color: AppColors.primaryElement,
                  ),
                  child: Text(
                    hallOfFame.faculty.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.Header3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Center the row content
            children: [
              Text(
                hallOfFame.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.Header2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Center the row content
            children: [
              Text(
                'Khoá ${hallOfFame.beginningYear}',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppFonts.Header3,
                ),
              ),
            ],
          ),
          Container(
            height: 5.h,
          )
        ],
      ),
    ),
  );
}

Widget advise(BuildContext context) {
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
                  fontFamily: AppFonts.Header1,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: 0.h, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  // Adjust as desired
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
                margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                width: 170.w,
                child: Text(
                  'Giải đáp thắc mắc và tư vấn cùng đội ngũ sinh viên xịn xò',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100.w,
                  height: 30.h,
                  margin: EdgeInsets.only(top: 45.h, left: 20.w, right: 45.w),
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
                          fontFamily: AppFonts.Header2,
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
