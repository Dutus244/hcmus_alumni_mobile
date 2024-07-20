import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../bloc/my_profile_add_education_events.dart';
import '../bloc/my_profile_add_education_blocs.dart';
import 'dart:io';

import '../my_profile_add_education_controller.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('education'),
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

Widget myProfileAddEducation(BuildContext context, int option, String id) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            if (option == 0)
              buildTextFieldSchoolName1(context, translate('school_name'), '', '', (value) {
              context.read<MyProfileAddEducationBloc>().add(SchoolNameEvent(value));
            }),
            if (option == 1)
              buildTextFieldSchoolName2(context, translate('school_name'), '', '', (value) {
                context.read<MyProfileAddEducationBloc>().add(SchoolNameEvent(value));
              }),
            if (option == 0)
              buildTextFieldDegree1(context, translate('degree_name'), '', '', (value) {
              context.read<MyProfileAddEducationBloc>().add(DegreeEvent(value));
            }),
            if (option == 1)
              buildTextFieldDegree2(context, translate('degree_name'), '', '', (value) {
                context.read<MyProfileAddEducationBloc>().add(DegreeEvent(value));
              }),
            // buildTextFieldStartTime(context),
            if (option == 0)
              buildTextFieldStartTime1(context, translate('choose_start_time'), (value) {
                context.read<MyProfileAddEducationBloc>().add(StartTimeEvent(value));
              }),
            if (option == 1)
              buildTextFieldStartTime2(context, translate('choose_start_time'), (value) {
                context.read<MyProfileAddEducationBloc>().add(StartTimeEvent(value));
              }),
            isWorking(context, (value) {
              context.read<MyProfileAddEducationBloc>().add(IsStudyingEvent(value));
            }),
            // if (!BlocProvider.of<MyProfileAddEducationBloc>(context).state.isStudying)
            //   buildTextFieldEndTime(context),
            if (!BlocProvider.of<MyProfileAddEducationBloc>(context).state.isStudying && option == 0)
              buildTextFieldEndTime1(context, translate('choose_end_time'), (value) {
                context.read<MyProfileAddEducationBloc>().add(EndTimeEvent(value));
              }),
            if (!BlocProvider.of<MyProfileAddEducationBloc>(context).state.isStudying && option == 1)
              buildTextFieldEndTime2(context, translate('choose_end_time'), (value) {
                context.read<MyProfileAddEducationBloc>().add(EndTimeEvent(value));
              }),
          ],
        )),
        buttonAdd(context, option, id)
      ]);
}

Widget buildTextFieldSchoolName1(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {

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
              "assets/icons/study.svg",
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
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
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

Widget buildTextFieldSchoolName2(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
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
              "assets/icons/study.svg",
              width: 16.w,
              height: 16.h,
              color: Colors.black,
            ),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<MyProfileAddEducationBloc>(context).state.schoolName,
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

Widget buildTextFieldDegree1(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {

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
              "assets/icons/study.svg",
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
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
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

Widget buildTextFieldDegree2(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
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
              "assets/icons/study.svg",
              width: 16.w,
              height: 16.h,
              color: Colors.black,
            ),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<MyProfileAddEducationBloc>(context).state.degree,
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

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Only allow digits
    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Insert slash at the correct position for MM/yyyy format
    if (newText.length >= 3) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    // Limit to 7 characters (MM/yyyy)
    if (newText.length > 7) {
      newText = newText.substring(0, 7);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

Widget buildTextFieldStartTime1(BuildContext context, String hintText, void Function(String value)? func) {
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
            "assets/icons/work.svg",
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
            onChanged: (value) => func!(value),
            keyboardType: TextInputType.datetime,
            maxLines: 1,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10), // Limit length to 10 characters
              DateInputFormatter(), // Custom date formatter
            ],
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
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
        ),
      ],
    ),
  );
}

Widget buildTextFieldStartTime2(BuildContext context, String hintText, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileAddEducationBloc>(context).state.startTime);

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
              "assets/icons/work.svg",
              width: 16.w,
              height: 16.h,
              color: Colors.black,
            ),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              initialValue: BlocProvider.of<MyProfileAddEducationBloc>(context).state.startTime,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10), // Limit length to 10 characters
                DateInputFormatter(), // Custom date formatter
              ],
              keyboardType: TextInputType.datetime,
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

Widget buildTextFieldEndTime1(BuildContext context, String hintText, void Function(String value)? func) {
  return Container(
    width: 320.w,
    margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
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
            "assets/icons/work.svg",
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
            onChanged: (value) => func!(value),
            keyboardType: TextInputType.datetime,
            maxLines: 1,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10), // Limit length to 10 characters
              DateInputFormatter(), // Custom date formatter
            ],
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
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
        ),
      ],
    ),
  );
}

Widget buildTextFieldEndTime2(BuildContext context, String hintText, void Function(String value)? func) {
  return Container(
      width: 320.w,
      margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
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
              "assets/icons/work.svg",
              width: 16.w,
              height: 16.h,
              color: Colors.black,
            ),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              initialValue: BlocProvider.of<MyProfileAddEducationBloc>(context).state.endTime,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10), // Limit length to 10 characters
                DateInputFormatter(), // Custom date formatter
              ],
              keyboardType: TextInputType.datetime,
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

Widget buildTextFieldStartTime(
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => chooseStartTime(context),
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
                BlocProvider.of<MyProfileAddEducationBloc>(context).state.startTime ==
                        ''
                    ? translate('choose_start_time')
                    : BlocProvider.of<MyProfileAddEducationBloc>(context)
                        .state
                        .startTime,
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

Widget chooseStartTime(BuildContext context) {
  late DateTime? _selectedDay;

  if (BlocProvider.of<MyProfileAddEducationBloc>(context).state.startTime != "") {
    _selectedDay = convertToDateTime(
        BlocProvider.of<MyProfileAddEducationBloc>(context).state.startTime);
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
                    translate('choose_start_time'),
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
                      .read<MyProfileAddEducationBloc>()
                      .add(StartTimeEvent(convertDateTimeToString(newDay)));
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

Widget isWorking(BuildContext context, void Function(bool value)? func) {
  return Container(
    margin: EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h),
    width: 135.w,
    height: 30.h,
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 0.w, right: 10.w),
          child: Checkbox(
            checkColor: AppColors.background,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.element; // Selected color
                }
                return Colors.transparent; // Unselected color
              },
            ),
            onChanged: (value) => func!(value!),
            value: BlocProvider.of<MyProfileAddEducationBloc>(context).state.isStudying,
          ),
        ),
        Container(
          child: Text(
            translate('still_studying_here'),
            style: TextStyle(
              fontFamily: AppFonts.Header,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildTextFieldEndTime(
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => chooseEndTime(context),
      );
    },
    child: Container(
        width: 320.w,
        height: 40.h,
        margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
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
                BlocProvider.of<MyProfileAddEducationBloc>(context).state.endTime ==
                    ''
                    ? translate('choose_end_time')
                    : BlocProvider.of<MyProfileAddEducationBloc>(context)
                    .state
                    .endTime,
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

Widget chooseEndTime(BuildContext context) {
  late DateTime? _selectedDay;

  if (BlocProvider.of<MyProfileAddEducationBloc>(context).state.endTime != "") {
    _selectedDay = convertToDateTime(
        BlocProvider.of<MyProfileAddEducationBloc>(context).state.endTime);
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
                    translate('choose_end_time'),
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
                      .read<MyProfileAddEducationBloc>()
                      .add(EndTimeEvent(convertDateTimeToString(newDay)));
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

Widget buttonAdd(BuildContext context, int option, String id) {
  String schoolName = BlocProvider.of<MyProfileAddEducationBloc>(context).state.schoolName;
  String degree = BlocProvider.of<MyProfileAddEducationBloc>(context).state.degree;
  return GestureDetector(
    onTap: () {
      if (schoolName != "" && degree != "") {
        if (option == 0) {
          MyProfileAddEducationController(context: context).handleAddEducation();
        } else {
          MyProfileAddEducationController(context: context).handleUpdateEducation(id);
        }
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: (schoolName != "")
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
                      color: (schoolName != "")
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
                  color: (schoolName != "")
                      ? AppColors.background
                      : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          )),
    ),
  );
}