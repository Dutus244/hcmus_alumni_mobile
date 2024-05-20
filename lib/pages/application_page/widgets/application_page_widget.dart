import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/group_page.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page.dart';
import '../../../common/values/colors.dart';
import '../../news_event_page/news_event_page.dart';
import '../bloc/application_page_events.dart';

Widget buildPage(int index, int secondIndex) {
  List<Widget> _widget = [
    const HomePage(),
    NewsEventPage(
      page: secondIndex,
    ),
    const AdvisePage(),
    GroupPage(
      page: secondIndex,
    ),
    Center(child: Text('Home5')),
  ];

  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "Trang chủ",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/home1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/home2.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Tin tức/Sự kiện/Gương thành công",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/news1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/news2.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Tư vấn/Cố vấn",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/question1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/question2.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Nhóm",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/group1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/group2.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Thông báo",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/notification1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/notification2.png",
          color: AppColors.primaryElement,
        ),
      )),
];

Widget applicationPage(BuildContext context, int secondRoute) {
  return Scaffold(
    body: buildPage(BlocProvider.of<ApplicationPageBloc>(context).state.index, secondRoute),
    bottomNavigationBar: Container(
      width: 375.w,
      height: 58.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.h),
            topRight: Radius.circular(20.h),
          ),
          color: AppColors.primarySecondaryElement,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ]),
      child: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: BlocProvider.of<ApplicationPageBloc>(context).state.index,
        onTap: (value) {
          context
              .read<ApplicationPageBloc>()
              .add(TriggerApplicationPageEvent(value));
        },
        selectedItemColor: AppColors.primaryElement,
        unselectedItemColor: AppColors.primaryText,
        items: bottomTabs,
      ),
    ),
  );
}
