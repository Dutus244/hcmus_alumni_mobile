import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/model/picture.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          'Hình ảnh',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header0,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
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
