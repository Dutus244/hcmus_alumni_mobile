import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'widgets/news_detail_write_comment_widget.dart';

class NewsDetailWriteComment extends StatefulWidget {
  const NewsDetailWriteComment({super.key});

  @override
  State<NewsDetailWriteComment> createState() => _NewsDetailWriteCommentState();
}

class _NewsDetailWriteCommentState extends State<NewsDetailWriteComment> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/newsDetail",
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: buildAppBar(context, 'Tin tức'),
        backgroundColor: AppColors.primaryBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                    child: Text(
                      'Từ học trò tỉnh lẻ thành giáo sư đại học Mỹ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                    child: Text(
                      'Gửi bình luận',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
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
                                backgroundImage:
                                    AssetImage("assets/images/test1.png"),
                              )),
                        ),
                        Text(
                          'Đặng Nguyễn Duy',
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildTextField(
                      'Bình luận của bạn', 'comment', '', (value) {}),
                ],
              ),
            ),
            navigation(() {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/newsDetail",
                (route) => false,
              );
            }),
          ],
        ),
      ),
    );
  }
}
