import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/group_page.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page.dart';
import 'package:hcmus_alumni_mobile/pages/notification_page/notification_page.dart';
import '../../../common/values/colors.dart';
import '../../friend_page/friend_page.dart';
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
    const FriendPage(),
    const NotificationPage(),
  ];

  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: translate('home'),
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(AppAssets.homeIcon1),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          AppAssets.homeIcon2,
          color: AppColors.element,
        ),
      )),
  BottomNavigationBarItem(
      label: translate('news_event'),
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(AppAssets.newsIcon1),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          AppAssets.newsIcon2,
          color: AppColors.element,
        ),
      )),
  BottomNavigationBarItem(
      label: translate('advise'),
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(AppAssets.adviseIcon1),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          AppAssets.adviseIcon2,
          color: AppColors.element,
        ),
      )),
  BottomNavigationBarItem(
      label: translate('group'),
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(AppAssets.groupIcon1),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          AppAssets.groupIcon2,
          color: AppColors.element,
        ),
      )),
  BottomNavigationBarItem(
      label: translate('friend'),
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(AppAssets.friendIcon1),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          AppAssets.friendIcon2,
          color: AppColors.element,
        ),
      )),
  BottomNavigationBarItem(
      label: translate('notification'),
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(AppAssets.notificationIcon1),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          AppAssets.notificationIcon2,
          color: AppColors.element,
        ),
      )),
];

Widget applicationPage(BuildContext context, int secondRoute) {
  return Scaffold(
    body: buildPage(
        BlocProvider.of<ApplicationPageBloc>(context).state.index, secondRoute),
    bottomNavigationBar: Container(
      width: 375.w,
      height: 58.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.h),
            topRight: Radius.circular(20.h),
          ),
          color: AppColors.elementLight,
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
        selectedItemColor: AppColors.element,
        unselectedItemColor: AppColors.textBlack,
        items: bottomTabs,
      ),
    ),
  );
}
