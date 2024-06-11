import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/picture.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';

AppBar buildAppBar(BuildContext context, int profile, int route) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (profile == 0) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/applicationPage",
                      (route) => false,
                  arguments: {
                    "route": 2,
                    "secondRoute": 0,
                  },
                );
              }
              else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/myProfilePage", (route) => false,
                    arguments: {"route": route});
              }
            },
            child: SvgPicture.asset(
              "assets/icons/back.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Text(
            'Hình ảnh',
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
          ),
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget listPicture(List<Picture> pictureList) {
  return Center(
    child: SizedBox(
      height: 400.h, // Điều chỉnh chiều cao theo yêu cầu
      child: PageView.builder(
        itemCount: pictureList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              height: 300.h, // Điều chỉnh chiều rộng theo yêu cầu
              child: AspectRatio(
                aspectRatio: 4 / 3,
                // Thay đổi tỷ lệ khung hình tùy theo yêu cầu của bạn
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(pictureList[index].pictureUrl),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
