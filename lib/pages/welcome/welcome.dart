import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/values/fonts.dart';
import 'bloc/welcome_blocs.dart';
import 'bloc/welcome_events.dart';
import 'bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Scaffold(body: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 34.h),
            width: 375.w,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    state.page = index;
                    BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _page(
                        1,
                        context,
                        "Tiếp tục",
                        "Chào mừng trở lại!",
                        "Khám phá các tính năng và cơ hội mới với cộng đồng cựu sinh viên.",
                        "assets/images/welcome1.png"),
                    _page(
                        2,
                        context,
                        "Tiếp tục",
                        "Khám phá ứng dụng mới",
                        "Tìm hiểu cách ứng dụng có thể giúp bạn duy trì kết nối và phát triển sau đại học.",
                        "assets/images/welcome2.png"),
                    _page(
                        3,
                        context,
                        "Bắt đầu",
                        "Bắt đầu hành trình của bạn",
                        "Đăng nhập hoặc đăng ký để trải nghiệm các tính năng đầy đủ của ứng dụng.",
                        "assets/images/welcome3.png"),
                  ],
                ),
                Positioned(
                    bottom: 100.h,
                    child: DotsIndicator(
                      position: state.page,
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          color: AppColors.primaryThirdElementText,
                          activeColor: AppColors.primaryElement,
                          size: const Size.square(8.0),
                          activeSize: const Size(18.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ))
              ],
            ),
          );
        },
      )),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Text(
            "${title}",
            style: TextStyle(
                fontFamily: AppFonts.Header0,
                color: AppColors.primaryText,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            "${subTitle}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: AppFonts.Header2,
                color: AppColors.primaryText,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            } else {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/signIn", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
            ),
            child: Center(
              child: Text(
                "${buttonName}",
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
