import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:intl/intl.dart';

import '../../../common/function/handle_html_content.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import '../bloc/event_detail_blocs.dart';

Widget buildButtonChooseInfoOrParticipant(
    BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => func!(0),
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<EventDetailBloc>(context).state.page == 1
                  ? AppColors.primarySecondaryElement
                  : AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Thông tin',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<EventDetailBloc>(context).state.page ==
                                1
                            ? AppColors.primaryElement
                            : AppColors.primaryBackground),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => func!(1),
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<EventDetailBloc>(context).state.page == 1
                  ? AppColors.primaryElement
                  : AppColors.primarySecondaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Người tham gia',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<EventDetailBloc>(context).state.page ==
                                1
                            ? AppColors.primaryBackground
                            : AppColors.primaryElement),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

String replaceHeightAttribute(String original) {
  return original.replaceAllMapped(
    RegExp(r'(<img[^>]+)(h=)', caseSensitive: false),
    (match) => '${match.group(1)}_${match.group(1)}',
  );
}

Widget eventContent(Event event) {
  String htmlContent = event.content;
  String htmlFix = '';
  htmlFix = handleHtmlContent(htmlContent);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        width: 340.w,
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(event.thumbnail),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Text(
          "Khoa " + event.faculty.name,
          style: TextStyle(
            fontFamily: AppFonts.Header3,
            color: Color.fromARGB(255, 51, 58, 73),
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Text(
          event.title,
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
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
                  width: 5.w,
                ),
                Text(
                  handleDatetime(event.publishedAt),
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 11.sp,
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
                  width: 5.w,
                ),
                Text(
                  event.views.toString(),
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 11.sp,
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
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/location.svg",
              width: 12.w,
              height: 12.h,
              color: Color.fromARGB(255, 255, 95, 92),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Địa điểm: ',
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
                      ),
                    ),
                    TextSpan(
                      text: event.organizationLocation,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
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
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/time.svg",
                width: 12.w,
                height: 12.h,
                color: Color.fromARGB(255, 153, 214, 216),
              ),
              Container(
                width: 5.w,
              ),
              Text(
                'Thời gian:',
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 63, 63, 70),
                ),
              ),
              Container(
                width: 5.w,
              ),
              Text(
                handleDatetime(event.organizationTime),
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 63, 63, 70),
                ),
              ),
            ],
          )),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/participant.svg",
              width: 50.w,
              height: 50.h,
              color: AppColors.primarySecondaryText,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  event.participants.toString(),
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    color: AppColors.primaryElement,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'Người tham gia',
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    color: AppColors.primarySecondaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      Center(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Tham gia ngay',
                style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBackground),
              ),
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        child: Text(
          'Thông tin chi tiết',
          style: TextStyle(
            fontFamily: AppFonts.Header2,
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 0.h, left: 5.w, right: 5.w),
        child: Html(
          data: htmlFix,
          style: {
            "span": Style(fontSize: FontSize.medium, fontFamily: "Roboto")
          },
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100.w,
            ),
            Text(
              event.creator.fullName,
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                color: Color.fromARGB(255, 51, 58, 73),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 10.h, left: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/tag.svg",
              width: 12.w,
              height: 12.h,
              color: AppColors.primarySecondaryText,
            ),
            for (int i = 0; i < event.tags.length; i += 1)
              Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Text(
                  event.tags[i].name,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 5, 90, 188),
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

Widget detail(BuildContext context, Event event) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      eventContent(event),
      listComment(context),
      listRelatedEvent(
          context, BlocProvider.of<EventDetailBloc>(context).state.relatedEvent)
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
              color: Color.fromARGB(255, 245, 245, 245),
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
                      fontFamily: AppFonts.Header2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
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
            fontFamily: AppFonts.Header1,
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
            color: Color.fromARGB(255, 230, 240, 251),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              'Xem thêm bình luận',
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 43, 107, 182),
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
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '4 ngày',
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.primarySecondaryText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header3,
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
              fontFamily: AppFonts.Header3,
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
                              fontFamily: AppFonts.Header3,
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
                        fontFamily: AppFonts.Header3,
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

Widget listRelatedEvent(BuildContext context, List<Event> eventList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 10.h),
        child: Text(
          "Tin tức liên quan",
          style: TextStyle(
            fontFamily: AppFonts.Header2,
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
          for (int i = 0; i < eventList.length; i += 1)
            Container(
              padding: EdgeInsets.only(left: 0.w, right: 0.w),
              child: event(context, eventList[i]),
            ),
        ],
      )
    ],
  );
}

Widget event(BuildContext context, Event event) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/eventDetail",
        (route) => false,
        arguments: {"route": 1, "event": event},
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
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
                      handleDatetime(event.publishedAt),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
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
                      event.views.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
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
                      "assets/icons/participant.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.primarySecondaryText,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      event.participants.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/tag.svg",
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.primarySecondaryText,
                ),
                for (int i = 0; i < event.tags.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Text(
                      event.tags[i].name,
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
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppFonts.Header2,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 3.h),
              height: 15.h,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    width: 12.w,
                    height: 12.h,
                    color: Color.fromARGB(255, 255, 95, 92),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Địa điểm:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Container(
                    width: 250.w,
                    child: Text(
                      event.organizationLocation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppFonts.Header3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 63, 63, 70),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              height: 15.h,
              margin: EdgeInsets.only(top: 3.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/time.svg",
                    width: 12.w,
                    height: 12.h,
                    color: Color.fromARGB(255, 153, 214, 216),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    'Thời gian:',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    handleDatetime(event.organizationTime),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 63, 63, 70),
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Stack(
              children: [
                Container(
                  width: 340.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(event.thumbnail),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 20.h,
                    margin: EdgeInsets.only(left: 10.w, top: 5.h),
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, bottom: 2.h, top: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      shape: BoxShape.rectangle,
                      color: AppColors.primaryElement,
                    ),
                    child: Text(
                      event.faculty.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.Header3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10.h,
          ),
          Container(
            height: 1.h,
            color: AppColors.primarySecondaryElement,
          ),
          Container(
            height: 10.h,
          ),
        ],
      ),
    ),
  );
}

Widget listParticipant() {
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    child: Column(
      children: [
        participant(),
        participant(),
        participant(),
      ],
    ),
  );
}

Widget participant() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                child: CircleAvatar(
                  radius: 10,
                  child: null,
                  backgroundImage: AssetImage("assets/images/test1.png"),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                'Nguyễn Duy',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
          Text(
            'Người tạo sự kiện',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
            ),
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
            ],
          ),
        )
      ],
    ),
  );
}
