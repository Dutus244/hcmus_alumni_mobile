import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/widgets/loading_widget.dart';
import 'package:hcmus_alumni_mobile/model/alumni.dart';
import 'package:hcmus_alumni_mobile/model/alumni_verification.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../model/achievement.dart';
import '../../../model/education.dart';
import '../../../model/job.dart';
import 'dart:io';

import '../../../model/user.dart';
import '../bloc/other_profile_detail_blocs.dart';

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
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget otherProfileDetail(BuildContext context) {
  User? user = BlocProvider.of<OtherProfileDetailBloc>(context).state.user;
  if (user == null) {
    return loadingWidget();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              profile(context, user),
              contact(context, user),
              aboutMe(context, user),
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

Widget profile(BuildContext context, User user) {
  String faculty = translate('choose_faculty');
  AlumniVerification? alumniVerification = BlocProvider.of<OtherProfileDetailBloc>(context).state.alumniVerification;
  Alumni? alumni = BlocProvider.of<OtherProfileDetailBloc>(context).state.alumni;
  switch (user.faculty != null ? user.faculty!.id : 0) {
    case 1:
      faculty = "Công nghệ thông tin";
    case 2:
      faculty = "Vật lý – Vật lý kỹ thuật";
    case 3:
      faculty = "Địa chất";
    case 4:
      faculty = "Toán – Tin học";
    case 5:
      faculty = "Điện tử - Viễn thông";
    case 6:
      faculty = "Khoa học & Công nghệ Vật liệu";
    case 7:
      faculty = "Hóa học";
    case 8:
      faculty = "Sinh học – Công nghệ Sinh học";
    case 9:
      faculty = "Môi trường";
  }

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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
                    user.fullName,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('full_name'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('faculty'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
            (user.sex != null ? user.sex!.name : "Nam") == "Nam"
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
                    user.sex != null ? user.sex!.name : "Nam",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('sex'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    user.dob !=
                        ""
                        ? user.dob
                        : '',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('birthday'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    user.socialMediaLink,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('social_network'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    alumniVerification != null ? alumniVerification.studentId! : "",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('student_id'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    alumni != null ? alumni.alumClass : "",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('class'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    alumniVerification != null ? alumniVerification.beginningYear.toString() : "",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('year_admission'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    alumni != null ? alumni.graduationYear.toString() : "",
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('graduation_year'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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

Widget contact(BuildContext context, User user) {
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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
                    user.email,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('email'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
                    user.phone,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('phone'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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

Widget aboutMe(BuildContext context, User user) {
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
              translate('about_me'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Text(
          user.aboutMe,
          style: TextStyle(
            color: AppColors.textBlack,
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.normal,
            fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
          ),
        ),
      ),
    ],
  );
}

Widget jobs(BuildContext context) {
  List<Job> jobs = BlocProvider.of<OtherProfileDetailBloc>(context).state.jobs;

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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
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
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    job.position,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    '${job.startTime} - ${job.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
  List<Education> educations = BlocProvider.of<OtherProfileDetailBloc>(context).state.educations;

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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
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
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    education.degree,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    '${education.startTime} - ${education.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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
  List<Achievement> achievements = BlocProvider.of<OtherProfileDetailBloc>(context).state.achievements;

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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
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
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    achievement.type,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    achievement.time,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
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