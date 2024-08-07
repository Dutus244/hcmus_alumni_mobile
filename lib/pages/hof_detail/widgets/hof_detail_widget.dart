import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_html_content.dart';
import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../bloc/hof_detail_blocs.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('hall_of_fame'),
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
        GestureDetector(
          onTap: () {
            if (hallOfFame.linkerUser != null) {
              Navigator.pushNamed(context, "/otherProfilePage",
                  arguments: {
                    "id": hallOfFame.linkerUser!.id,
                  });
            }
          },
          child: Container(
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
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w),
          child: Text(
            "${translate('faculty_of')} " + hallOfFame.faculty.name,
            style: TextStyle(
              fontFamily: AppFonts.Header,
              color: Color.fromARGB(255, 51, 58, 73),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Text(
            hallOfFame.title,
            style: TextStyle(
              fontFamily: AppFonts.Header,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
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
                    color: AppColors.textGrey,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    handleDateTime1(hallOfFame.publishedAt),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
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
                    color: AppColors.textGrey,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    hallOfFame.views.toString(),
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
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
                  fontFamily: AppFonts.Header,
                  color: Color.fromARGB(255, 51, 58, 73),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget hofDetail(BuildContext context) {
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
