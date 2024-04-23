import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/values/colors.dart';
import '../../../global.dart';
import '../bloc/hof_page_blocs.dart';

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func1, void Function()? func2) {
  return Container(
      width: 340.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 10.h, top: 0.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 280.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 20.w),
            child: TextField(
              onChanged: (value) => func1!(value),
              keyboardType: TextInputType.multiline,
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
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
              obscureText: false,
              maxLength: 50,
            ),
          ),
          GestureDetector(
            onTap: func2,
            child: Container(
              width: 16.w,
              height: 16.w,
              margin: EdgeInsets.only(right: 10.w),
              child: Image.asset("assets/icons/$iconName.png"),
            ),
          ),
        ],
      ));
}

Widget buttonClearFilter(void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 50.w,
      height: 40.h,
      margin: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
        color: AppColors.primarySecondaryElement,
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Container(
        width: 20.w,
        height: 20.h,
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          "assets/icons/clear_filter.svg",
          width: 20.w,
          height: 20.h,
          color: AppColors.primaryElement,
        ),
      ),
    ),
  );
}

Widget dropdownButtonFaculty(List<String> faculties, BuildContext context,
    void Function(String value)? func) {
  List<DropdownMenuItem<String>> items = List.generate(
    faculties.length,
    (int index) {
      return DropdownMenuItem<String>(
        value: faculties[index],
        child: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            faculties[index],
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElement),
          ),
        ),
      );
    },
  );

  items.insert(
    0,
    DropdownMenuItem<String>(
      value: null,
      child: Container(
        padding: EdgeInsets.only(left: 5.w),
        child: Text(
          'Khoa',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryElement),
        ),
      ),
    ),
  );

  return Container(
    width: 170.w,
    height: 40.h,
    margin: EdgeInsets.only(left: 10.w),
    decoration: BoxDecoration(
      color: AppColors.primarySecondaryElement,
      borderRadius: BorderRadius.circular(5.w),
      border: Border.all(
        color: Colors.transparent,
      ),
    ),
    child: Center(
      child: DropdownButton<String>(
          isExpanded: true, // Đặt isExpanded thành true
          items: items,
          value: BlocProvider.of<HofPageBloc>(context).state.faculty == ""
              ? null
              : BlocProvider.of<HofPageBloc>(context).state.faculty,
          onChanged: (value) {
            if (value != null) {
              func!(value);
            }
          }),
    ),
  );
}

Widget dropdownButtonGraduationYear(List<String> graduationYear,
    BuildContext context, void Function(String value)? func) {
  List<DropdownMenuItem<String>> items = List.generate(
    graduationYear.length,
    (int index) {
      return DropdownMenuItem<String>(
        value: graduationYear[index],
        child: Container(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            graduationYear[index],
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElement),
          ),
        ),
      );
    },
  );

  items.insert(
    0,
    DropdownMenuItem<String>(
      value: null,
      child: Container(
        padding: EdgeInsets.only(left: 5.w),
        child: Text(
          'Khoá',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryElement),
        ),
      ),
    ),
  );

  return Container(
    width: 100.w,
    height: 40.h,
    margin: EdgeInsets.only(left: 10.w),
    decoration: BoxDecoration(
      color: AppColors.primarySecondaryElement,
      borderRadius: BorderRadius.circular(5.w),
      border: Border.all(
        color: Colors.transparent,
      ),
    ),
    child: Center(
      child: DropdownButton<String>(
          items: items,
          value:
              BlocProvider.of<HofPageBloc>(context).state.graduationYear == ""
                  ? null
                  : BlocProvider.of<HofPageBloc>(context).state.graduationYear,
          onChanged: (value) {
            if (value != null) {
              func!(value);
            }
          }),
    ),
  );
}

Widget listHof() {
  return Container(
    child: Column(
      children: [
        hof(),
        hof(),
        hof(),
        hof(),
      ],
    ),
  );
}

Widget hof() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  'Trương Samuel',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  'Khoá 2024 - Khoa Công nghệ Thông tin',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              'TP Vinh muốn thí điểm thu phí dừng, đỗ oto dưới lòng đường, vỉa hè một số tuyến chính theo khung giờ để giảm ùn tắt, đảm bảo trật tự an toàn giao thông',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            height: 10.h,
          ),
          Container(
            height: 1.h,
            color: AppColors.primarySecondaryElement,
          )
        ],
      ),
    ),
  );
}
