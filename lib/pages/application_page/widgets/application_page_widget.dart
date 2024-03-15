import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

Widget buildPage(int index) {
  List<Widget> _widget = [
    Center(child: Text('Home1')),
    Center(child: Text('Home2')),
    Center(child: Text('Home3')),
    Center(child: Text('Home4')),
    Center(child: Text('Home5')),
  ];

  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "Trang chủ",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/home.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/home.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Tin tức/Sự kiện",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/news.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/news.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Gương thành công",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/hall_of_fame.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/hall_of_fame.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Thông báo",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/notification.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/notification.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "Tài khoản",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/account.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/account.png",
          color: AppColors.primaryElement,
        ),
      )),
];
