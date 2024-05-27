import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_html_content.dart';
import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../bloc/hof_detail_blocs.dart';

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
              if (route == 0) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/applicationPage", (route) => false,
                    arguments: {"route": route, "secondRoute": 0});
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/hofPage",
                      (route) => false,
                );
              }
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
            'Gương thành công',
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

Widget navigation(BuildContext context, int route) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (route == 0) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/applicationPage", (route) => false,
                        arguments: {"route": route, "secondRoute": 0});
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/hofPage",
                      (route) => false,
                    );
                  }
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget hofContent(BuildContext context, HallOfFame? hallOfFame) {
  if (hallOfFame == null) {
    return loadingWidget();
  } else {
    String htmlContent = hallOfFame.content;
    String htmlFix = '';
    htmlFix = handleHtmlContent(htmlContent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
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
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w),
          child: Text(
            "Khoa " + hallOfFame.faculty.name,
            style: TextStyle(
              fontFamily: AppFonts.Header3,
              color: Color.fromARGB(255, 51, 58, 73),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Text(
            hallOfFame.title,
            style: TextStyle(
              fontFamily: AppFonts.Header2,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w),
          child: Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/clock.svg",
                    width: 12.w,
                    height: 12.h,
                    color: AppColors.primarySecondaryText,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    handleDatetime(hallOfFame.publishedAt),
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              Container(
                width: 10.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/view.svg",
                    width: 12.w,
                    height: 12.h,
                    color: AppColors.primarySecondaryText,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    hallOfFame.views.toString(),
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
          child: Html(
            data: htmlFix,
            style: {
              "span": Style(fontSize: FontSize.medium, fontFamily: "Roboto")
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.w,
              ),
              Text(
                hallOfFame.creator.fullName,
                style: TextStyle(
                  fontFamily: AppFonts.Header3,
                  color: Color.fromARGB(255, 51, 58, 73),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget hofDetail(BuildContext context, int route) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            hofContent(context,
                BlocProvider.of<HofDetailBloc>(context).state.hallOfFame)
          ],
        ),
      ),
      // Container nằm dưới cùng của màn hình
    ],
  );
}
