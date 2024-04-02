import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';

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
          Container(
            padding: EdgeInsets.only(left: Global.storageService.getUserIsLoggedIn() ? 30.w : 43.w),
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: Image.asset("assets/images/logos/logo.png"),
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

Widget buildCreatePostButton() {
  return Container(
    height: 40.h,
    padding: EdgeInsets.only(top: 0.h, bottom: 5.h, left: 10.w),
    child: Row(
      children: [
        GestureDetector(
          child: Container(
            width: 300.w,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              // Căn giữa theo chiều dọc
              child: Container(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  'Bạn đang muốn được tư vấn điều gì?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.only(left: 10.w),
            child: Image.asset(
              'assets/icons/image.png',
            ),
          ),
        )
      ],
    ),
  );
}

Widget listPost(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 0.h, bottom: 5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        post(context),
        post(context),
      ],
    ),
  );
}

Widget post(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35.h,
          margin: EdgeInsets.only(top: 5.h),
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 35.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: GestureDetector(
                    onTap: () {
                      // Xử lý khi người dùng tap vào hình ảnh
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage: AssetImage("assets/images/test1.png"),
                    )),
              ),
              Container(
                width: 270.w,
                height: 35.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Cộng đồng HCMUS',
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '4 ngày',
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 17.w,
                  height: 17.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/3dot.png"))),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 5.h,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: ExpandableText(
            'Đây là text dài hơn 2 dòng. Khi click vào "Xem thêm", text sẽ được hiển thị đầy đủ. Click vào "Thu gọn" để thu hồi text. 1211121212112112121211212111212',
            maxLines: 2,
            expandText: 'Xem thêm',
            collapseText: 'Thu gọn',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 11.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Container(
          height: 5.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200.h,
          child: Image.asset(
            'assets/images/test2.png',
            fit: BoxFit.cover, // Đảm bảo hình ảnh phủ đầy khung
          ),
        ),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.w),
                    height: 30.h,
                    width: 30.w,
                    child: Image.asset('assets/icons/like.png'),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 10.w),
                child: Text(
                  '3 bình luận',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 1.h,
          color: AppColors.primarySecondaryElement,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.w,
                        child: Image.asset('assets/icons/like1.png'),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          'Thích',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.w,
                        child: Image.asset('assets/icons/comment.png'),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          'Bình luận',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.w,
                        child: Image.asset('assets/icons/share.png'),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          'Chia sẻ',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 5.h,
          color: AppColors.primarySecondaryElement,
        ),
      ],
    ),
  );
}
