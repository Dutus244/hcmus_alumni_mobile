import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/bloc/hof_page_states.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/hof_page_blocs.dart';
import '../bloc/hof_page_events.dart';
import '../hof_page_controller.dart';

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
                fontFamily: AppFonts.Header3,
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
                fontFamily: AppFonts.Header2,
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
              fontFamily: AppFonts.Header2,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryElement),
        ),
      ),
    ),
  );

  return Container(
    width: 200.w,
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
                fontFamily: AppFonts.Header2,
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
              fontFamily: AppFonts.Header2,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryElement),
        ),
      ),
    ),
  );

  return Container(
    width: 70.w,
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
          value: BlocProvider.of<HofPageBloc>(context).state.beginningYear == ""
              ? null
              : BlocProvider.of<HofPageBloc>(context).state.beginningYear,
          onChanged: (value) {
            if (value != null) {
              func!(value);
            }
          }),
    ),
  );
}

List<String> listYear() {
  List<String> year = [];
  for (int i = 2000; i < 2025; i += 1) {
    year.add(i.toString());
  }
  return year;
}

Widget listHof(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<HofPageBloc>(context).state.hallOfFame.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<HofPageBloc>(context).state.statusHof) {
              case Status.loading:
                return Column(
                  children: [
                    Center(
                        child: buildTextField(
                            'Tìm gương thành công', 'search', 'search',
                            (value) {
                      context.read<HofPageBloc>().add(NameEvent(value));
                    }, () {
                      HofPageController(context: context).handleSearchHof();
                    })),
                    Row(
                      children: [
                        buttonClearFilter(() {
                          context.read<HofPageBloc>().add(ClearFilterEvent());
                        }),
                        dropdownButtonFaculty([
                          'Công nghệ thông tin',
                          'Vật lý – Vật lý kỹ thuật',
                          'Địa chất',
                          'Toán – Tin học',
                          'Điện tử - Viễn thông',
                          'Khoa học & Công nghệ Vật liệu',
                          'Hóa học',
                          'Sinh học – Công nghệ Sinh học',
                          'Môi trường',
                        ], context, (value) {
                          context.read<HofPageBloc>().add(FacultyEvent(value));
                        }),
                        dropdownButtonGraduationYear(listYear(), context,
                            (value) {
                          context
                              .read<HofPageBloc>()
                              .add(BeginningYearEvent(value));
                        })
                      ],
                    ),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<HofPageBloc>(context)
                    .state
                    .hallOfFame
                    .isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: buildTextField(
                              'Tìm gương thành công', 'search', 'search',
                              (value) {
                        context.read<HofPageBloc>().add(NameEvent(value));
                      }, () {
                        HofPageController(context: context).handleSearchHof();
                      })),
                      Row(
                        children: [
                          buttonClearFilter(() {
                            context.read<HofPageBloc>().add(ClearFilterEvent());
                          }),
                          dropdownButtonFaculty([
                            'Công nghệ thông tin',
                            'Vật lý – Vật lý kỹ thuật',
                            'Địa chất',
                            'Toán – Tin học',
                            'Điện tử - Viễn thông',
                            'Khoa học & Công nghệ Vật liệu',
                            'Hóa học',
                            'Sinh học – Công nghệ Sinh học',
                            'Môi trường',
                          ], context, (value) {
                            context
                                .read<HofPageBloc>()
                                .add(FacultyEvent(value));
                          }),
                          dropdownButtonGraduationYear(listYear(), context,
                              (value) {
                            context
                                .read<HofPageBloc>()
                                .add(BeginningYearEvent(value));
                          })
                        ],
                      ),
                      Container(
                        height: 10.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'Không có dữ liệu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header2,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<HofPageBloc>(context)
                        .state
                        .hallOfFame
                        .length) {
                  if (BlocProvider.of<HofPageBloc>(context)
                      .state
                      .hasReachedMaxHof) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        Center(
                            child: buildTextField(
                                'Tìm gương thành công', 'search', 'search',
                                (value) {
                          context.read<HofPageBloc>().add(NameEvent(value));
                        }, () {
                          HofPageController(context: context).handleSearchHof();
                        })),
                        Row(
                          children: [
                            buttonClearFilter(() {
                              context
                                  .read<HofPageBloc>()
                                  .add(ClearFilterEvent());
                            }),
                            dropdownButtonFaculty([
                              'Công nghệ thông tin',
                              'Vật lý – Vật lý kỹ thuật',
                              'Địa chất',
                              'Toán – Tin học',
                              'Điện tử - Viễn thông',
                              'Khoa học & Công nghệ Vật liệu',
                              'Hóa học',
                              'Sinh học – Công nghệ Sinh học',
                              'Môi trường',
                            ], context, (value) {
                              context
                                  .read<HofPageBloc>()
                                  .add(FacultyEvent(value));
                            }),
                            dropdownButtonGraduationYear(listYear(), context,
                                (value) {
                              context
                                  .read<HofPageBloc>()
                                  .add(BeginningYearEvent(value));
                            })
                          ],
                        ),
                        Container(
                          height: 10.h,
                        ),
                        hof(
                            context,
                            BlocProvider.of<HofPageBloc>(context)
                                .state
                                .hallOfFame[index]),
                      ],
                    );
                  } else {
                    return hof(
                        context,
                        BlocProvider.of<HofPageBloc>(context)
                            .state
                            .hallOfFame[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget hof(BuildContext context, HallOfFame hallOfFame) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/hofDetail",
        (route) => false,
        arguments: {
          "route": 1,
          "id": hallOfFame.id,
        },
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.h),
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
                      image: NetworkImage(hallOfFame.thumbnail),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 20.h,
                    margin: EdgeInsets.only(left: 10.w, top: 5.h),
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, bottom: 2.h, top: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      shape: BoxShape.rectangle,
                      color: AppColors.primaryElement,
                    ),
                    child: Text(
                      hallOfFame.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  hallOfFame.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  'Khoá ${hallOfFame.beginningYear}',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primarySecondaryText,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              hallOfFame.summary,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppFonts.Header3,
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
