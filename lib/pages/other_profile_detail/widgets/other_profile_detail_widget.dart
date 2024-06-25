import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../model/achievement.dart';
import '../../../model/education.dart';
import '../../../model/job.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('personal_information'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header3,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget otherProfileDetail(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              profile(context),
              contact(context),
              aboutMe(context),
              jobs(context),
              educations(context),
              achievements(context),
              Container(
                height: 30.h,
              )
            ],
          )),
    ],
  );
}

Widget profile(BuildContext context) {
  String faculty = "Chọn khoa";
  switch ("1") {
    case "1":
      faculty = "Công nghệ thông tin";
    case "2":
      faculty = "Vật lý – Vật lý kỹ thuật";
    case "3":
      faculty = "Địa chất";
    case "4":
      faculty = "Toán – Tin học";
    case "5":
      faculty = "Điện tử - Viễn thông";
    case "6":
      faculty = "Khoa học & Công nghệ Vật liệu";
    case "7":
      faculty = "Hóa học";
    case "8":
      faculty = "Sinh học – Công nghệ Sinh học";
    case "9":
      faculty = "Môi trường";
  }
  String name = 'Đặng Nguyễn Duy';
  String sex = 'Nam';
  String birthday = '24/04/2002';

  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('basic_information'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/user.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: 232.w,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('full_name'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Colors.transparent,
        margin:
        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: 232.w,
                  child: Text(
                    faculty,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('faculty'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            sex == "Nam"
                ? SvgPicture.asset(
              "assets/icons/men.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            )
                : SvgPicture.asset(
              "assets/icons/women.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: 232.w,
                  child: Text(
                    sex,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('sex'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/calendar.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    birthday !=
                        ""
                        ? birthday
                        : '',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('birthday'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/social_network.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    'dutus24',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('social_network'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    '20127013',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('student_id'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    '20CLC11',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('class'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    '2020',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('year_admission'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    '2024',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('graduation_year'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget contact(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('contact_info'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin:
        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/email.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    'test@gmail.com',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('email'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/phone.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    '0123456789',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('phone'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget aboutMe(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('about_me'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Text(
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
          style: TextStyle(
            color: AppColors.textBlack,
            fontFamily: AppFonts.Header3,
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
          ),
        ),
      ),
    ],
  );
}

Widget jobs(BuildContext context) {
  List<Job> jobs = [];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('job'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
      i < jobs.length;
      i += 1)
        job(context, jobs[i]),
      if (jobs.length == 0)
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Text(
              translate('no_job'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ),
        )
    ],
  );
}

Widget job(BuildContext context, Job job) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/work.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    job.companyName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    job.position,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    '${job.startTime} - ${job.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}

Widget educations(BuildContext context) {
  List<Education> educations = [];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('education'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
      i <
          educations
              .length;
      i += 1)
        education(
            context,
            educations[i]),
      if (educations.length == 0)
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Text(
              translate('no_education'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ),
        )
    ],
  );
}

Widget education(BuildContext context, Education education) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/work.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    education.schoolName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    education.degree,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    '${education.startTime} - ${education.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}

Widget achievements(BuildContext context) {
  List<Achievement> achievements = [];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('achievement'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
      i <
          achievements.length;
      i += 1)
        achievement(
            context,
            achievements[i]),
      if (achievements.length == 0)
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Text(
              translate('no_achievement'),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ),
        )
    ],
  );
}

Widget achievement(BuildContext context, Achievement achievement) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/achievement.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    achievement.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    achievement.type,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    achievement.time,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}