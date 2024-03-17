import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page.dart';

import '../../../common/values/colors.dart';

Widget buildPage(int index) {
  List<Widget> _widget = [
    const HomePage(),
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
      label: "Tin tức/Sự kiện",
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
      label: "Gương thành công",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/hall_of_fame1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/hall_of_fame2.png",
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
  BottomNavigationBarItem(
      label: "Tài khoản",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/account1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/account2.png",
          color: AppColors.primaryElement,
        ),
      )),
];
