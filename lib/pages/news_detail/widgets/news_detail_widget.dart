import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_states.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';

import '../../../common/values/fonts.dart';
import '../../../global.dart';
import '../../../model/news.dart';
import '../bloc/news_detail_events.dart';

String replaceHeightAttribute(String original) {
  return original.replaceAllMapped(
    RegExp(r'(<img[^>]+)(h=)', caseSensitive: false),
    (match) => '${match.group(1)}_${match.group(1)}',
  );
}

FontSize getContentFontSize(double value) {
  switch (value) {
    case 0:
      return FontSize.xxSmall;
    case 20:
      return FontSize.xSmall;
    case 40:
      return FontSize.medium;
    case 60:
      return FontSize.xLarge;
    case 80:
      return FontSize.xxLarge;
    default:
      return FontSize.medium; // Trường hợp mặc định
  }
}

double getTimeFontSize(double value) {
  switch (value) {
    case 0:
      return 8.sp;
    case 20:
      return 9.sp;
    case 40:
      return 10.sp;
    case 60:
      return 11.sp;
    case 80:
      return 12.sp;
    default:
      return 10.sp; // Trường hợp mặc định
  }
}

double getFacultyFontSize(double value) {
  switch (value) {
    case 0:
      return 10.sp;
    case 20:
      return 11.sp;
    case 40:
      return 12.sp;
    case 60:
      return 13.sp;
    case 80:
      return 14.sp;
    default:
      return 12.sp; // Trường hợp mặc định
  }
}

double getTitleFontSize(double value) {
  switch (value) {
    case 0:
      return 16.sp;
    case 20:
      return 17.sp;
    case 40:
      return 18.sp;
    case 60:
      return 19.sp;
    case 80:
      return 20.sp;
    default:
      return 18.sp; // Trường hợp mặc định
  }
}

String getLabelFontSize(double value) {
  switch (value) {
    case 0:
      return "Nhỏ nhất";
    case 20:
      return "Nhỏ";
    case 40:
      return "Bình thường";
    case 60:
      return "Lớn";
    case 80:
      return "Lớn nhất";
    default:
      return "Bình thường"; // Trường hợp mặc định
  }
}

Widget newsContent(BuildContext context, News news) {
  String htmlContent = news.content;

  String htmlFix = '';

  htmlFix = "<span>" + replaceHeightAttribute(htmlContent) + "</span>";

  DateTime dateTime = DateTime.parse(news.publishedAt);
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/clock.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.primarySecondaryText,
                ),
                Container(
                  width: 2.w,
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: getTimeFontSize(
                        BlocProvider.of<NewsDetailBloc>(context)
                            .state
                            .fontSize),
                  ),
                ),
              ],
            ),
            Container(
              width: 10.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/view.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.primarySecondaryText,
                ),
                Container(
                  width: 2.w,
                ),
                Text(
                  news.views.toString(),
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: getTimeFontSize(
                        BlocProvider.of<NewsDetailBloc>(context)
                            .state
                            .fontSize),
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/tag.svg",
              width: 12.w,
              height: 12.h,
              color: AppColors.primarySecondaryText,
            ),
            for (int i = 0; i < news.tags.length; i += 1)
              Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Text(
                  news.tags[i].name,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 5, 90, 188),
                  ),
                ),
              ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Text(
          "Khoa " + news.faculty.name,
          style: TextStyle(
            fontFamily: AppFonts.Header3,
            color: Color.fromARGB(255, 51, 58, 73),
            fontWeight: FontWeight.w500,
            fontSize: getFacultyFontSize(
                BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Text(
          news.title,
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: getTitleFontSize(
                BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
        child: Html(
          data: htmlFix,
          style: {
            "span": Style(
                fontSize: getContentFontSize(
                    BlocProvider.of<NewsDetailBloc>(context).state.fontSize),
                fontFamily:
                    BlocProvider.of<NewsDetailBloc>(context).state.fontFamily)
          },
        ),
      ),
    ],
  );
}

Widget listComment(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/newsDetailWriteComment",
            (route) => false,
          );
        },
        child: Container(
            width: 340.w,
            height: 40.h,
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Container(
              height: 20.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Viết bình luận',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/send.svg",
                    width: 15.w,
                    height: 15.h,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            )),
      ),
      Container(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, bottom: 10.h),
        child: Text(
          "Bình luận (5)",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          comment(),
          comment(),
          comment(),
        ],
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 340.w,
          height: 40.h,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            color: AppColors.primaryBackground,
            border: Border.all(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          child: Center(
            child: Text(
              'Xem thêm bình luận',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
      Container(
        height: 20.h,
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        height: 2.h,
        color: AppColors.primarySecondaryElement,
      )
    ],
  );
}

Widget comment() {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    child: Column(
      children: [
        Container(
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
            ],
          ),
        ),
        Container(
          height: 5.h,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Text(
            'Đây là text dài hơn 2 dòng. Khi click vào "Xem thêm", text sẽ được hiển thị đầy đủ. Click vào "Thu gọn" để thu hồi text. 1211121212112112121211212111212',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 20.w, top: 7.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/comment.svg",
                            width: 11.w,
                            height: 11.h,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          Container(
                            width: 3.w,
                          ),
                          Text(
                            '2 trả lời',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 50.w,
                  ),
                  GestureDetector(
                    child: Text(
                      'Trả lời',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget listRelatedNews() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 10.h),
        child: Text(
          "Bài viết liên quan",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          news(),
          news(),
          news(),
        ],
      )
    ],
  );
}

Widget news() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Text(
              '15 phút trước',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            height: 40.h,
            child: Text(
              'Trương Samuel - Từ học sinh tỉnh lẻ thành giáo sư đại học Mỹ ',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            height: 33.h,
            child: Text(
              'TP Vinh muốn thí điểm thu phí dừng, đỗ oto dưới lòng đường, vỉa hè một số tuyến chính theo khung giờ để giảm ùn tắt, đảm bảo trật tự an toàn giao thông',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/test1.png'),
              ),
            ),
          ),
          Container(
            height: 10.h,
          ),
          Container(
            height: 1.h,
            color: AppColors.primarySecondaryElement,
          )
        ],
      ),
    ),
  );
}

Widget navigation(void Function()? func) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          height: 1.h,
          color: AppColors.primarySecondaryElement,
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: func,
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Row(
              //   children: [
              //     ButtonEditText(),
              //     Container(
              //       width: 20.w,
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: SvgPicture.asset(
              //         "assets/icons/comment.svg",
              //         width: 25.w,
              //         height: 25.h,
              //         color: Colors.black.withOpacity(0.5),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        )
      ],
    ),
  );
}

class ButtonEditText extends StatefulWidget {
  const ButtonEditText({Key? key}) : super(key: key);

  @override
  State<ButtonEditText> createState() => _ButtonEditTextState();
}

class _ButtonEditTextState extends State<ButtonEditText> {
  final _currentValueNotifier = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) =>
              BlocBuilder<NewsDetailBloc, NewsDetailState>(
            builder: (context, state) {
              return Container(
                width: 350.w,
                height: 150.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chọn cỡ chữ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElement,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              width: 20.w,
                              height: 20.h,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              color: AppColors.primarySecondaryElement,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/aa.svg",
                              width: 10.w,
                              height: 10.h,
                              color: AppColors.primaryElement,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: BlocProvider.of<NewsDetailBloc>(context)
                                  .state
                                  .fontSize,
                              max: 80,
                              divisions: 4,
                              label: getLabelFontSize(
                                  BlocProvider.of<NewsDetailBloc>(context)
                                      .state
                                      .fontSize),
                              onChanged: (double value) {
                                BlocProvider.of<NewsDetailBloc>(context)
                                    .add(FontSizeEvent(value));
                              },
                              activeColor: AppColors.primaryElement,
                              inactiveColor: AppColors.primarySecondaryElement,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 30.w,
                                height: 30.h,
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: AppColors.primarySecondaryElement,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/aa_big.svg",
                                  width: 10.w,
                                  height: 10.h,
                                  color: AppColors.primaryElement,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<NewsDetailBloc>(context)
                                      .add(FontSizeResetEvent());
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: AppColors.primarySecondaryElement,
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/refresh.svg",
                                    width: 10.w,
                                    height: 10.h,
                                    color: AppColors.primaryElement,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      margin: EdgeInsets.only(top: 5.h),
                      color: AppColors.primarySecondaryElement,
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chọn font chữ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElement,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<NewsDetailBloc>(context)
                                  .add(FontFamilyEvent("Roboto"));
                            },
                            child: Container(
                              width: 140.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: BlocProvider.of<NewsDetailBloc>(context)
                                            .state
                                            .fontFamily !=
                                        "Roboto"
                                    ? AppColors.primarySecondaryElement
                                    : AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(15.w),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Roboto',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: BlocProvider.of<NewsDetailBloc>(
                                                      context)
                                                  .state
                                                  .fontFamily !=
                                              "Roboto"
                                          ? AppColors.primaryElement
                                          : AppColors.primaryBackground),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<NewsDetailBloc>(context)
                                  .add(FontFamilyEvent("Times New Roman"));
                            },
                            child: Container(
                              width: 140.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: BlocProvider.of<NewsDetailBloc>(context)
                                            .state
                                            .fontFamily ==
                                        "Roboto"
                                    ? AppColors.primarySecondaryElement
                                    : AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(15.w),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Times New Roman',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: BlocProvider.of<NewsDetailBloc>(
                                                      context)
                                                  .state
                                                  .fontFamily ==
                                              "Roboto"
                                          ? AppColors.primaryElement
                                          : AppColors.primaryBackground),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          onPop: () {},
          direction: PopoverDirection.top,
          width: 300.w,
          height: 160.h,
        );
      },
      child: SvgPicture.asset(
        "assets/icons/aa.svg",
        width: 25,
        height: 25,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
