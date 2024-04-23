import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_states.dart';
import 'package:intl/intl.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import '../../../model/news.dart';

Widget buildButtonChooseNewsOrEvent(
    BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            if (func != null) {
              func(0);
            }
          },
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<NewsEventPageBloc>(context).state.page == 1
                  ? AppColors.primarySecondaryElement
                  : AppColors.primaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Tin tức',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: BlocProvider.of<NewsEventPageBloc>(context)
                                .state
                                .page ==
                            1
                        ? AppColors.primaryElement
                        : AppColors.primaryBackground),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (func != null) {
              func(1);
            }
          },
          child: Container(
            width: 165.w,
            height: 30.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: BlocProvider.of<NewsEventPageBloc>(context).state.page == 1
                  ? AppColors.primaryElement
                  : AppColors.primarySecondaryElement,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                'Sự kiện',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: BlocProvider.of<NewsEventPageBloc>(context)
                                .state
                                .page ==
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

Widget loadingWidget() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(4.0),
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

Widget listNews(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<NewsEventPageBloc>(context).state.news.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (
                BlocProvider.of<NewsEventPageBloc>(context).state.statusNews) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<NewsEventPageBloc>().add(PageEvent(1));
                    }),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<NewsEventPageBloc>(context)
                    .state
                    .news
                    .isEmpty) {
                  return Text("Không có tin tức nào");
                }
                if (index >=
                    BlocProvider.of<NewsEventPageBloc>(context)
                        .state
                        .news
                        .length) {
                  if (BlocProvider.of<NewsEventPageBloc>(context)
                      .state
                      .hasReachedMaxNews) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context.read<NewsEventPageBloc>().add(PageEvent(1));
                        }),
                        news(
                            context,
                            BlocProvider.of<NewsEventPageBloc>(context)
                                .state
                                .news[index]),
                      ],
                    );
                  } else {
                    return news(
                        context,
                        BlocProvider.of<NewsEventPageBloc>(context)
                            .state
                            .news[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget news(BuildContext context, News news) {
  DateTime dateTime = DateTime.parse(news.publishedAt);
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/newsDetail",
        (route) => false,
        arguments: {
          "route": 1,
          "news": news,
        },
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
                      formattedDate,
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
                      news.views.toString(),
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
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              news.title,
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
            height: 33.h,
            child: Text(
              news.summary,
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
                      image: NetworkImage(news.thumbnail),
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
                      news.faculty.name,
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

Widget listEvent(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<NewsEventPageBloc>(context).state.event.length +
                  1,
          itemBuilder: (BuildContext context, int index) {
            switch (
                BlocProvider.of<NewsEventPageBloc>(context).state.statusEvent) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChooseNewsOrEvent(context, (value) {
                      context.read<NewsEventPageBloc>().add(PageEvent(0));
                    }),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<NewsEventPageBloc>(context)
                    .state
                    .event
                    .isEmpty) {
                  return Text("Không có tin tức nào");
                }
                if (index >=
                    BlocProvider.of<NewsEventPageBloc>(context)
                        .state
                        .event
                        .length) {
                  if (BlocProvider.of<NewsEventPageBloc>(context)
                      .state
                      .hasReachedMaxEvent) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChooseNewsOrEvent(context, (value) {
                          context.read<NewsEventPageBloc>().add(PageEvent(0));
                        }),
                        event(
                            context,
                            BlocProvider.of<NewsEventPageBloc>(context)
                                .state
                                .event[index]),
                      ],
                    );
                  } else {
                    return event(
                        context,
                        BlocProvider.of<NewsEventPageBloc>(context)
                            .state
                            .event[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget event(BuildContext context, Event event) {
  DateTime dateTimePublishedAt = DateTime.parse(event.publishedAt);
  String formattedDatePublishedAt =
      DateFormat('dd/MM/yyyy HH:mm').format(dateTimePublishedAt);

  DateTime dateTimeOrganizationTime = DateTime.parse(event.organizationTime);
  String formattedDateOrganizationTime =
      DateFormat('dd/MM/yyyy HH:mm').format(dateTimeOrganizationTime);

  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "/eventDetail",
        (route) => false,
        arguments: {"route": 1},
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
                      formattedDatePublishedAt,
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
                    margin: EdgeInsets.only(left: 5.w),
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
                    formattedDateOrganizationTime,
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
