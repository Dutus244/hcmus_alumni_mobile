import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/model/participant.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';

import '../../../common/function/handle_html_content.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/event_detail_blocs.dart';
import '../bloc/event_detail_states.dart';
import '../event_detail_controller.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('event'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

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
                  ? AppColors.elementLight
                  : AppColors.element,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                translate('information'),
                style: AppTextStyle.small().wSemiBold().withColor(
                    BlocProvider.of<EventDetailBloc>(context).state.page == 1
                        ? AppColors.element
                        : AppColors.background),
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
                  ? AppColors.element
                  : AppColors.elementLight,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                translate('participants'),
                style: AppTextStyle.small().wSemiBold().withColor(
                    BlocProvider.of<EventDetailBloc>(context).state.page == 1
                        ? AppColors.background
                        : AppColors.element),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget eventContent(BuildContext context, Event event) {
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
          "${translate('faculty_of')} " + event.faculty.name,
          style: AppTextStyle.small().withColor(AppColors.textGrey),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Text(
          event.title,
          style: AppTextStyle.large().wSemiBold(),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w),
        child: Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.clockIconS,
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.textGrey,
                ),
                Container(
                  width: 5.w,
                ),
                Text(
                  handleDateTime1(event.publishedAt),
                  style: AppTextStyle.small(),
                ),
              ],
            ),
            Container(
              width: 10.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.viewIconS,
                  width: 12.w,
                  height: 12.h,
                  color: AppColors.textGrey,
                ),
                Container(
                  width: 5.w,
                ),
                Text(
                  event.views.toString(),
                  maxLines: 2,
                  style: AppTextStyle.small(),
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
              AppAssets.locationIconS,
              width: 12.w,
              height: 12.h,
              color: AppColors.red,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Container(
                        width: 65.w, // Đặt chiều rộng cụ thể tại đây
                        child: Text(
                          '${translate('location')}: ',
                          style: AppTextStyle.small(),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: event.organizationLocation,
                      style: AppTextStyle.small(),
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
                AppAssets.timeIconS,
                width: 12.w,
                height: 12.h,
                color: AppColors.timeIcon,
              ),
              Container(
                width: 5.w,
              ),
              Container(
                width: 60.w,
                child: Text(
                  '${translate('time')}:',
                  maxLines: 1,
                  style: AppTextStyle.small(),
                ),
              ),
              Container(
                width: 5.w,
              ),
              Text(
                handleDateTime1(event.organizationTime),
                maxLines: 1,
                style: AppTextStyle.small(),
              ),
            ],
          )),
      Container(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.participantIconS,
              width: 50.w,
              height: 50.h,
              color: AppColors.textGrey,
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
                  style: AppTextStyle.base()
                      .wSemiBold()
                      .withColor(AppColors.element),
                ),
                Text(
                  translate('participants'),
                  style: AppTextStyle.base()
                      .wSemiBold()
                      .withColor(AppColors.textGrey),
                ),
              ],
            )
          ],
        ),
      ),
      if (Global.storageService.permissionEventParticipantCreate())
        Center(
          child: BlocProvider.of<EventDetailBloc>(context).state.isParticipated
              ? GestureDetector(
                  onTap: () {
                    EventDetailController(context: context)
                        .handleExitEvent(event.id);
                  },
                  child: Container(
                    width: 165.w,
                    height: 30.h,
                    margin: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(15.w),
                      border: Border.all(
                        color: AppColors.element,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        translate('cancel'),
                        style: AppTextStyle.small()
                            .wSemiBold()
                            .withColor(AppColors.element),
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    EventDetailController(context: context)
                        .handleJoinEvent(event.id);
                  },
                  child: Container(
                    width: 165.w,
                    height: 30.h,
                    margin: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.element,
                      borderRadius: BorderRadius.circular(15.w),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        translate('join'),
                        style: AppTextStyle.small()
                            .wSemiBold()
                            .withColor(AppColors.background),
                      ),
                    ),
                  ),
                ),
        ),
      Container(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        child: Text(
          translate('detail'),
          style: AppTextStyle.medium().wSemiBold(),
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
              style: AppTextStyle.base(),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 10.h, left: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.tagIconS,
              width: 12.w,
              height: 12.h,
              color: AppColors.textGrey,
            ),
            for (int i = 0; i < event.tags.length; i += 1)
              Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Text(event.tags[i].name,
                    style: AppTextStyle.small()
                        .withColor(AppColors.element)),
              ),
          ],
        ),
      ),
    ],
  );
}

Widget detail(
    BuildContext context, Event? event, ScrollController _scrollController) {
  if (event == null) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: ListView(
        controller: _scrollController,
        children: [
          buildButtonChooseInfoOrParticipant(context, (value) {
            context.read<EventDetailBloc>().add(PageEvent(value));
          }),
          loadingWidget()
        ],
      )),
    ]);
  } else {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
          child: ListView(
        controller: _scrollController,
        children: [
          buildButtonChooseInfoOrParticipant(context, (value) {
            context.read<EventDetailBloc>().add(PageEvent(value));
          }),
          eventContent(context, event),
          listComment(context, event,
              BlocProvider.of<EventDetailBloc>(context).state.comments),
          // listRelatedEvent(context,
          //     BlocProvider.of<EventDetailBloc>(context).state.relatedEvent)
        ],
      )),
    ]);
  }
}

Widget listComment(
    BuildContext context, Event? event, List<Comment> commentList) {
  if (event == null) {
    return Column(
      children: [],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (Global.storageService.permissionEventCommentCreate())
          GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(
                context,
                "/eventDetailWriteComment",
                arguments: {
                  "event": event,
                },
              );
              EventDetailController(context: context)
                  .handleGetComment(event.id, 0);
            },
            child: Container(
                width: 340.w,
                height: 40.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  color: AppColors.backgroundWhiteDark,
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
                        translate('write_comment'),
                        style: AppTextStyle.base().wMedium().withColor(AppColors.textBlack.withOpacity(0.5)),
                      ),
                      SvgPicture.asset(
                        AppAssets.sendIconS,
                        width: 15.w,
                        height: 15.h,
                        color: AppColors.textBlack.withOpacity(0.5),
                      ),
                    ],
                  ),
                )),
          ),
        Container(
          padding: EdgeInsets.only(top: 20.h, left: 10.w, bottom: 10.h),
          child: Text(
            "${translate('comment')} (${event.childrenCommentNumber})",
            style: AppTextStyle.large().wSemiBold(),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < commentList.length; i += 1)
              buildCommentWidget(context, event, commentList[i], 0)
          ],
        ),
        if (event.childrenCommentNumber > 5 &&
            !BlocProvider.of<EventDetailBloc>(context)
                .state
                .hasReachedMaxComment)
          GestureDetector(
            onTap: () {
              EventDetailController(context: context).handleGetComment(event.id,
                  BlocProvider.of<EventDetailBloc>(context).state.indexComment);
            },
            child: Container(
              width: 340.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: AppColors.elementLight,
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  translate('more_comment'),
                  style: AppTextStyle.base().wSemiBold().withColor(AppColors.element),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Widget buildCommentWidget(
    BuildContext context, Event event, Comment comment, int index) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
                      if (comment.creator.id ==
                          Global.storageService.getUserId()) {
                        Navigator.pushNamed(
                          context,
                          "/myProfilePage",
                        );
                      } else {
                        Navigator.pushNamed(context, "/otherProfilePage",
                            arguments: {
                              "id": comment.creator.id,
                            });
                      }
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                          NetworkImage(comment.creator.avatarUrl ?? ""),
                    )),
              ),
              Container(
                width: 270.w,
                height: 35.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        comment.creator.fullName,
                        maxLines: 1,
                        style: AppTextStyle.small().wSemiBold(),
                      ),
                    ),
                    Container(
                      child: Text(
                        handleDateTime1(comment.updateAt),
                        maxLines: 1,
                        style: AppTextStyle.small().withColor(AppColors.textGrey),
                      ),
                    ),
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
          width: (340 - 10 * index).w,
          child: Text(
            comment.content,
            style: AppTextStyle.small(),
          ),
        ),
        if (index <= 1)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        EventDetailController(context: context)
                            .handleGetChildrenComment(comment.id);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.commentIconS,
                              width: 11.w,
                              height: 11.h,
                              color: AppColors.textBlack.withOpacity(0.8),
                            ),
                            Container(
                              width: 3.w,
                            ),
                            Text(
                              "${comment.childrenCommentNumber.toString()} ${translate('reply').toLowerCase()}",
                              style: AppTextStyle.small().withColor(AppColors.textBlack.withOpacity(0.8)).size(11.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (Global.storageService.permissionEventCommentCreate())
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                "/eventDetailWriteChildrenComment",
                                arguments: {
                                  "event": event,
                                  "comment": comment,
                                },
                              );
                              EventDetailController(context: context)
                                  .handleGetComment(event.id, 0);
                            },
                            child: Text(
                              translate('reply'),
                              style: AppTextStyle.small().withColor(AppColors.textBlack.withOpacity(0.8)).size(11.sp),
                            ),
                          ),
                        ],
                      ),
                    if (comment.permissions.edit)
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                "/eventDetailEditComment",
                                arguments: {
                                  "event": event,
                                  "comment": comment,
                                },
                              );
                              EventDetailController(context: context)
                                  .handleGetComment(event.id, 0);
                            },
                            child: Text(
                              translate('edit'),
                              style: AppTextStyle.small().withColor(AppColors.textBlack.withOpacity(0.8)).size(11.sp),
                            ),
                          ),
                        ],
                      ),
                    if (comment.permissions.delete)
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              EventDetailController(context: context)
                                  .handleDeleteComment(event.id, comment.id);
                            },
                            child: Text(
                              translate('delete'),
                              style: AppTextStyle.small().withColor(AppColors.textBlack.withOpacity(0.8)).size(11.sp),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        if (index > 1)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
            child: Row(
              children: [
                Row(
                  children: [
                    if (comment.permissions.edit)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                "/eventDetailEditComment",
                                arguments: {
                                  "event": event,
                                  "comment": comment,
                                },
                              );
                              EventDetailController(context: context)
                                  .handleGetComment(event.id, 0);
                            },
                            child: Text(
                              translate('edit'),
                              style: AppTextStyle.small().withColor(AppColors.textBlack.withOpacity(0.8)).size(11.sp),
                            ),
                          ),
                        ],
                      ),
                    if (comment.permissions.delete)
                      Row(
                        children: [
                          Container(
                            width: 50.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              EventDetailController(context: context)
                                  .handleDeleteComment(event.id, comment.id);
                            },
                            child: Text(
                              translate('delete'),
                              style: AppTextStyle.small().withColor(AppColors.textBlack.withOpacity(0.8)).size(11.sp),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            children: [
              for (int i = 0; i < comment.childrenComments.length; i += 1)
                IntrinsicHeight(
                    child: Row(
                  children: [
                    Container(width: 1, color: AppColors.textBlack),
                    // This is divider
                    Container(
                        child: buildCommentWidget(context, event,
                            comment.childrenComments[i], index + 1)),
                  ],
                ))
            ],
          ),
        ),
      ],
    ),
  );
}

Widget listParticipant(
    BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<EventDetailBloc>(context)
                  .state
                  .participants
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<EventDetailBloc>(context)
                .state
                .statusParticipant) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChooseInfoOrParticipant(context, (value) {
                      context.read<EventDetailBloc>().add(PageEvent(value));
                    }),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<EventDetailBloc>(context)
                    .state
                    .participants
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChooseInfoOrParticipant(context, (value) {
                        context.read<EventDetailBloc>().add(PageEvent(value));
                      }),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_participants'),
                          style: AppTextStyle.small(),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<EventDetailBloc>(context)
                        .state
                        .participants
                        .length) {
                  if (BlocProvider.of<EventDetailBloc>(context)
                      .state
                      .hasReachedMaxParticipant) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChooseInfoOrParticipant(context, (value) {
                          context.read<EventDetailBloc>().add(PageEvent(value));
                        }),
                        Container(
                          height: 10.h,
                        ),
                        participant(
                            context,
                            BlocProvider.of<EventDetailBloc>(context)
                                .state
                                .participants[index]),
                      ],
                    );
                  } else {
                    return participant(
                        context,
                        BlocProvider.of<EventDetailBloc>(context)
                            .state
                            .participants[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget participant(BuildContext context, Participant participant) {
  return GestureDetector(
    onTap: () {
      if (participant.user.id == Global.storageService.getUserId()) {
        Navigator.pushNamed(
          context,
          "/myProfilePage",
        );
      } else {
        Navigator.pushNamed(context, "/otherProfilePage", arguments: {
          "id": participant.user.id,
        });
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      color: Colors.transparent,
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
                  backgroundImage: NetworkImage(participant.user.avatarUrl),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                participant.user.fullName,
                style: AppTextStyle.small().wSemiBold(),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
