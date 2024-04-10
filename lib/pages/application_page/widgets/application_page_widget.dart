import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page.dart';
import '../../../common/values/colors.dart';
import '../../news_event_page/news_event_page.dart';

Widget buildPage(int index, int secondIndex) {
  List<Widget> _widget = [
    const HomePage(),
    NewsEventPage(page: secondIndex,),
    const AdvisePage(),
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
        child: Image.asset("assets/icons/advise1.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/advise2.png",
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
