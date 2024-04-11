import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_blocs.dart';

import '../../../common/values/colors.dart';
import '../../../global.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Global.storageService.getUserIsLoggedIn() ? 30.w : 17.w,
            height: Global.storageService.getUserIsLoggedIn() ? 30.h : 17.w,
            margin: EdgeInsets.only(),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/signIn");
              },
              child: Global.storageService.getUserIsLoggedIn()
                  ? CircleAvatar(
                radius: 10,
                child: null,
                backgroundImage: AssetImage("assets/images/test1.png"),
              )
                  : Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/login.png"))),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage",
                    (route) => false,
                arguments: {"route": 0, "secondRoute": 0},
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: Global.storageService.getUserIsLoggedIn() ? 30.w : 43.w),
              child: SizedBox(
                width: 120.w,
                height: 120.h,
                child: Image.asset("assets/images/logos/logo.png"),
              ),
            ),
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

Widget buildButtonChooseNewsOrEvent(BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            if (func != null) {
              func(0);
            }
          },
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<NewsEventPageBloc>(context).state.page == 1 ? AppColors.primarySecondaryElement : AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Tin tức',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: BlocProvider.of<NewsEventPageBloc>(context).state.page == 1 ? AppColors.primaryElement : AppColors.primaryBackground),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (func != null) {
              func(1);
            }
          },
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<NewsEventPageBloc>(context).state.page == 1 ? AppColors.primaryElement : AppColors.primarySecondaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Sự kiện',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: BlocProvider.of<NewsEventPageBloc>(context).state.page == 1 ? AppColors.primaryBackground : AppColors.primaryElement),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget listNews() {
  return Container(
    child: Column(
      children: [
        news(),
        news(),
        news(),
        news(),
      ],
    ),
  );
}

Widget news() {
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
            child: Text(
              '15 phút trước',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              'Trương Samuel - Từ học sinh tỉnh lẻ thành giáo sư đại học Mỹ',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
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

Widget listEvent() {
  return Container(
    child: Column(
      children: [
        event(),
        event(),
        event(),
        event(),
      ],
    ),
  );
}

Widget event() {
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
            child: Text(
              '15 phút trước',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              'Lễ tốt nghiệp thạc sĩ, tiến sĩ năm 2023',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 3.h),
              child: Row(
                children: [
                  Text(
                    'Thời gian tổ chức:',
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    '01/04/2024 - 09:00',
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 3.h),
              child: Row(
                children: [
                  Text(
                    'Địa điểm:',
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Hội trường I - CS NVC',
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              )),
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
