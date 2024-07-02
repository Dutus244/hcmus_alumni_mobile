import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../bloc/my_profile_add_achievement_events.dart';
import '../bloc/my_profile_add_achievement_blocs.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('achievement'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget myProfileAddJob(BuildContext context) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            buildTextFieldName(context, translate('achievement_name'), '', '', (value) {
              context.read<MyProfileAddAchievementBloc>().add(NameEvent(value));
            }),
            buildTextFieldType(context, translate('type_achievement'), '', '', (value) {
              context.read<MyProfileAddAchievementBloc>().add(TypeEvent(value));
            }),
            buildTextFieldTime(context),
          ],
        )),
        buttonAdd(context)
      ]);
}

Widget buildTextFieldName(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileAddAchievementBloc>(context).state.name);

  return Container(
      width: 320.w,
      margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            child: SvgPicture.asset(
              "assets/icons/achievement.svg",
              width: 16.w,
              height: 16.h,
              color: Colors.black,
            ),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: null,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldType(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileAddAchievementBloc>(context).state.type);

  return Container(
      width: 320.w,
      margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            child: SvgPicture.asset(
              "assets/icons/achievement.svg",
              width: 16.w,
              height: 16.h,
              color: Colors.black,
            ),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: null,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldTime(
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => chooseTime(context),
      );
    },
    child: Container(
        width: 320.w,
        height: 40.h,
        margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          border: Border.all(color: AppColors.primaryFourthElementText),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: SvgPicture.asset(
                "assets/icons/calendar.svg",
                width: 16.w,
                height: 16.h,
                color: Colors.black,
              ),
            ),
            Container(
              width: 270.w,
              padding: EdgeInsets.only(top: 2.h, left: 10.w),
              child: Text(
                BlocProvider.of<MyProfileAddAchievementBloc>(context).state.time ==
                        ''
                    ? translate('choose_time')
                    : BlocProvider.of<MyProfileAddAchievementBloc>(context)
                        .state
                        .time,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontFamily: AppFonts.Header,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            )
          ],
        )),
  );
}

DateTime convertToDateTime(String dateString) {
  List<String> parts = dateString.split('/');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  return DateTime.utc(year, month, day);
}

String convertDateTimeToString(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  return '$day/$month/$year';
}

Widget chooseTime(BuildContext context) {
  late DateTime? _selectedDay;

  if (BlocProvider.of<MyProfileAddAchievementBloc>(context).state.time != "") {
    _selectedDay = convertToDateTime(
        BlocProvider.of<MyProfileAddAchievementBloc>(context).state.time);
  } else {
    _selectedDay = convertToDateTime("01/01/2000");
  }

  return Container(
    height: 210.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    translate('choose_time'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header,
                    ),
                  ),
                ),
              ),
              DatePickerWidget(
                looping: false,
                firstDate: DateTime(1950),
                lastDate: DateTime(2030),
                initialDate: _selectedDay,
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('vi'),
                onChange: (DateTime newDay, _) {
                  context
                      .read<MyProfileAddAchievementBloc>()
                      .add(TimeEvent(convertDateTimeToString(newDay)));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.element,
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translate('choose'),
                          style: TextStyle(
                            fontFamily: AppFonts.Header,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.background,
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
  );
}

Widget buttonAdd(BuildContext context) {
  String compayName = BlocProvider.of<MyProfileAddAchievementBloc>(context).state.name;
  return GestureDetector(
    onTap: () {
      if (compayName != "") {

      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: (compayName != "")
            ? AppColors.element
            : AppColors.background,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
        ),
      ),
      child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate('save'),
                  style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: (compayName != "")
                          ? AppColors.background
                          : Colors.black.withOpacity(0.3)),
                ),
                Container(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  "assets/icons/send.svg",
                  width: 15.w,
                  height: 15.h,
                  color: (compayName != "")
                      ? AppColors.background
                      : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          )),
    ),
  );
}