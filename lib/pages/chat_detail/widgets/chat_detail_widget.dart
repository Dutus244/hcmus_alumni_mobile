import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/model/message.dart';
import 'package:hcmus_alumni_mobile/pages/chat_detail/chat_detail_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/chat_detail_states.dart';
import '../bloc/chat_detail_blocs.dart';
import '../bloc/chat_detail_events.dart';

AppBar buildAppBar(BuildContext context, String name) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/otherProfilePage", arguments: {
                  "id": "",
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 50.w),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      width: 10.w,
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.medium().wSemiBold(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget listMessage(BuildContext context, ScrollController _scrollController,
    ScrollController _scrollControllerDeviceImage, int inboxId) {
  Message? messages = BlocProvider.of<ChatDetailBloc>(context).state.children;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemCount:
              BlocProvider.of<ChatDetailBloc>(context).state.messages.length +
                  1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<ChatDetailBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<ChatDetailBloc>(context)
                    .state
                    .messages
                    .isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<ChatDetailBloc>(context)
                        .state
                        .messages
                        .length) {
                  if (BlocProvider.of<ChatDetailBloc>(context)
                      .state
                      .hasReachedMaxMessage) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        Container(
                          height: 10.h,
                        ),
                        message(
                            context,
                            BlocProvider.of<ChatDetailBloc>(context)
                                .state
                                .messages[index]),
                      ],
                    );
                  } else {
                    return message(
                        context,
                        BlocProvider.of<ChatDetailBloc>(context)
                            .state
                            .messages[index]);
                  }
                }
            }
          },
        ),
      ),
      navigation(context, messages, inboxId, (value) {
        context.read<ChatDetailBloc>().add(ContentEvent(value));
      }),
      if (BlocProvider.of<ChatDetailBloc>(context).state.modeImage!)
        choosePicture(context, _scrollControllerDeviceImage),
    ],
  );
}

Widget message(BuildContext context, Message message) {
  return Container(
    margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (message.sender.id == Global.storageService.getUserId())
          Container(
            width: 10.w,
          ),
        if (message.sender.id == Global.storageService.getUserId() &&
            message.messageType == "TEXT" &&
            message.parentMessage == null)
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => messageOption(context, message),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.element,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                  child: Text(
                    message.content,
                    style:
                        AppTextStyle.medium().withColor(AppColors.background),
                  ),
                ),
              ),
            ),
          ),
        if (message.sender.id == Global.storageService.getUserId() &&
            message.messageType == "TEXT" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "TEXT")
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      'Đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "chính mình"
                              : message.parentMessage!.sender.fullName),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhiteDark,
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                    child: Text(
                      message.parentMessage!.content,
                      style:
                          AppTextStyle.medium().withColor(AppColors.textGrey),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.element,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                      child: Text(
                        message.content,
                        style: AppTextStyle.medium()
                            .withColor(AppColors.background),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (message.sender.id == Global.storageService.getUserId() &&
            message.messageType == "TEXT" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "IMAGE")
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      'Đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "chính mình"
                              : message.parentMessage!.sender.fullName),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: NetworkImage(message.parentMessage!.content),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.element,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                      child: Text(
                        message.content,
                        style: AppTextStyle.medium()
                            .withColor(AppColors.background),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (message.sender.id == Global.storageService.getUserId() &&
            message.messageType == "IMAGE" &&
            message.parentMessage == null)
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => messageOption(context, message),
              );
            },
            child: Container(
                width: 200.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: NetworkImage(message.content),
                    fit: BoxFit.cover,
                  ),
                )),
          ),
        if (message.sender.id == Global.storageService.getUserId() &&
            message.messageType == "IMAGE" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "TEXT")
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      'Đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "chính mình"
                              : message.parentMessage!.sender.fullName),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhiteDark,
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                    child: Text(
                      message.parentMessage!.content,
                      style:
                          AppTextStyle.medium().withColor(AppColors.textGrey),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                    width: 200.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: AppColors.element,
                      borderRadius: BorderRadius.circular(10.w),
                      image: DecorationImage(
                        image: NetworkImage(message.content),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        if (message.sender.id == Global.storageService.getUserId() &&
            message.messageType == "IMAGE" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "IMAGE")
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      'Đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "chính mình"
                              : message.parentMessage!.sender.fullName),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: NetworkImage(message.parentMessage!.content),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                    width: 200.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: AppColors.element,
                      borderRadius: BorderRadius.circular(10.w),
                      image: DecorationImage(
                        image: NetworkImage(message.content),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        if (message.sender.id != Global.storageService.getUserId() &&
            message.messageType == "TEXT" &&
            message.parentMessage == null)
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => messageOption(context, message),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundWhiteDark,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                  child: Text(
                    message.content,
                    style: AppTextStyle.medium(),
                  ),
                ),
              ),
            ),
          ),
        if (message.sender.id != Global.storageService.getUserId() &&
            message.messageType == "TEXT" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "TEXT")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      message.sender.fullName +
                          ' đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "bạn"
                              : "chính mình"),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhiteDark,
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                    child: Text(
                      message.parentMessage!.content,
                      style:
                          AppTextStyle.medium().withColor(AppColors.textGrey),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhiteDark,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                      child: Text(
                        message.content,
                        style: AppTextStyle.medium(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (message.sender.id != Global.storageService.getUserId() &&
            message.messageType == "TEXT" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "IMAGE")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      message.sender.fullName +
                          ' đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "bạn"
                              : "chính mình"),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: NetworkImage(message.parentMessage!.content),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhiteDark,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
                      child: Text(
                        message.content,
                        style: AppTextStyle.medium(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (message.sender.id != Global.storageService.getUserId() &&
            message.messageType == "IMAGE" &&
            message.parentMessage == null)
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => messageOption(context, message),
              );
            },
            child: Container(
                width: 200.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: NetworkImage(message.content),
                    fit: BoxFit.cover,
                  ),
                )),
          ),
        if (message.sender.id != Global.storageService.getUserId() &&
            message.messageType == "IMAGE" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "TEXT")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      message.sender.fullName +
                          ' đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "bạn"
                              : "chính mình"),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhiteDark,
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200.w, // Chỉ định chiều rộng tối đa
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                    child: Text(
                      message.parentMessage!.content,
                      style:
                          AppTextStyle.medium().withColor(AppColors.textGrey),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                    width: 200.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: AppColors.element,
                      borderRadius: BorderRadius.circular(10.w),
                      image: DecorationImage(
                        image: NetworkImage(message.content),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        if (message.sender.id != Global.storageService.getUserId() &&
            message.messageType == "IMAGE" &&
            message.parentMessage != null &&
            message.parentMessage?.messageType == "IMAGE")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/reply.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 2.w,
                    ),
                    Text(
                      message.sender.fullName +
                          ' đang trả lời ' +
                          (message.parentMessage!.sender.id ==
                                  Global.storageService.getUserId()
                              ? "bạn"
                              : "chính mình"),
                      style: AppTextStyle.small().withColor(AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: AppColors.element,
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: NetworkImage(message.parentMessage!.content),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => messageOption(context, message),
                  );
                },
                child: Container(
                    width: 200.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: AppColors.element,
                      borderRadius: BorderRadius.circular(10.w),
                      image: DecorationImage(
                        image: NetworkImage(message.content),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        if (message.sender.id != Global.storageService.getUserId())
          Container(
            width: 10.w,
          ),
      ],
    ),
  );
}

Widget messageOption(BuildContext context, Message message) {
  return GestureDetector(
    onTap: () async {
      await ChatDetailController(context: context).handleReplyMessage(message);
      Navigator.pop(context);
    },
    child: Container(
      height: 50.h,
      child: Container(
        margin:
            EdgeInsets.only(top: 10.h, left: 20.w, right: 10.w, bottom: 20.h),
        color: Colors.transparent,
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/reply.svg",
              width: 14.w,
              height: 14.h,
              color: AppColors.textBlack,
            ),
            Container(
              width: 10.w,
            ),
            Text(
              'Trả lời',
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildTextFieldContent(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<ChatDetailBloc>(context).state.content);

  return Container(
      width: 270.w,
      margin: EdgeInsets.only(top: 2.h, left: 10.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: Color.fromARGB(255, 245, 245, 245),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            width: 250.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: null,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: AppTextStyle.small()
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget navigation(BuildContext context, Message? message, int inboxId,
    void Function(String value)? func) {
  String content = BlocProvider.of<ChatDetailBloc>(context).state.content;
  List<File> images = BlocProvider.of<ChatDetailBloc>(context).state.images;
  return Container(
    height:
        BlocProvider.of<ChatDetailBloc>(context).state.mode == 0 ? 60.h : 100.h,
    child: Column(
      children: [
        if (BlocProvider.of<ChatDetailBloc>(context).state.mode == 0)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ChatDetailBloc>().add(ModeImageEvent(
                        !BlocProvider.of<ChatDetailBloc>(context)
                            .state
                            .modeImage!));
                    context.read<ChatDetailBloc>().add(ImagesEvent([]));
                  },
                  child: SvgPicture.asset(
                    "assets/icons/picture.svg",
                    width: 20.w,
                    height: 20.h,
                    color: BlocProvider.of<ChatDetailBloc>(context)
                            .state
                            .modeImage!
                        ? AppColors.element
                        : AppColors.textBlack.withOpacity(0.5),
                  ),
                ),
                buildTextFieldContent(
                    context, translate('message'), 'comment', '', (value) {
                  context.read<ChatDetailBloc>().add(ContentEvent(value));
                }),
                GestureDetector(
                  onTap: () {
                    if (content != "" || images.length > 0) {
                      ChatDetailController(context: context)
                          .handleSendMessage(inboxId);
                    }
                  },
                  child: SvgPicture.asset(
                    AppAssets.sendIconS,
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.element,
                  ),
                ),
              ],
            ),
          ),
        if (BlocProvider.of<ChatDetailBloc>(context).state.mode == 1)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300.w,
                        margin: EdgeInsets.only(bottom: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Đang trả lời ' +
                                    (BlocProvider.of<ChatDetailBloc>(context)
                                                .state
                                                .children!
                                                .sender
                                                .id ==
                                            Global.storageService.getUserId()
                                        ? "chính mình"
                                        : BlocProvider.of<ChatDetailBloc>(
                                                context)
                                            .state
                                            .children!
                                            .sender
                                            .fullName),
                                style: AppTextStyle.small().wSemiBold(),
                              ),
                            ),
                            Container(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                BlocProvider.of<ChatDetailBloc>(context)
                                            .state
                                            .children!
                                            .messageType ==
                                        "IMAGE"
                                    ? "Ảnh"
                                    : BlocProvider.of<ChatDetailBloc>(context)
                                        .state
                                        .children!
                                        .content,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.small(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ChatDetailBloc>().add(ModeEvent(0));
                        },
                        child: Container(
                          width: 30.w,
                          child: SvgPicture.asset(
                            AppAssets.closeIconS,
                            width: 20.w,
                            height: 20.h,
                            color: AppColors.textBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ChatDetailBloc>().add(ModeImageEvent(
                            !BlocProvider.of<ChatDetailBloc>(context)
                                .state
                                .modeImage!));
                        context.read<ChatDetailBloc>().add(ImagesEvent([]));
                      },
                      child: SvgPicture.asset(
                        "assets/icons/picture.svg",
                        width: 20.w,
                        height: 20.h,
                        color: BlocProvider.of<ChatDetailBloc>(context)
                                .state
                                .modeImage!
                            ? AppColors.element
                            : AppColors.textBlack.withOpacity(0.5),
                      ),
                    ),
                    buildTextFieldContent(
                        context, translate('message'), 'comment', '', (value) {
                      context.read<ChatDetailBloc>().add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap: () {
                        if (content != "" || images.isNotEmpty) {
                          ChatDetailController(context: context)
                              .handleSendMessage(inboxId);
                        }
                      },
                      child: SvgPicture.asset(
                        AppAssets.sendIconS,
                        width: 20.w,
                        height: 20.h,
                        color: AppColors.element,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (BlocProvider.of<ChatDetailBloc>(context).state.mode == 2)
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 15.w, bottom: 10.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w, bottom: 2.h),
                      child: Text(
                        'Chỉnh sửa bình luận',
                        style: AppTextStyle.small(),
                      ),
                    ),
                    Container(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<ChatDetailBloc>().add(ModeEvent(0));
                        context.read<ChatDetailBloc>().add(ContentEvent(''));
                        // context.read<ChatDetailBloc>().add(
                        //     ChildrenEvent(Comment('', User('', '', '', '', '', '', '', Faculty(0,''), '', '' '', '', ''), '',
                        //         0, '', '', Permissions(false, false))));
                      },
                      child: Text(
                        '- Huỷ',
                        style: AppTextStyle.small()
                            .wSemiBold()
                            .withColor(AppColors.textGrey),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ChatDetailBloc>().add(ModeImageEvent(
                            !BlocProvider.of<ChatDetailBloc>(context)
                                .state
                                .modeImage!));
                        context.read<ChatDetailBloc>().add(ImagesEvent([]));
                      },
                      child: SvgPicture.asset(
                        "assets/icons/picture.svg",
                        width: 20.w,
                        height: 20.h,
                        color: BlocProvider.of<ChatDetailBloc>(context)
                                .state
                                .modeImage!
                            ? AppColors.element
                            : AppColors.textBlack.withOpacity(0.5),
                      ),
                    ),
                    buildTextFieldContent(
                        context, translate('message'), 'comment', '', (value) {
                      context.read<ChatDetailBloc>().add(ContentEvent(value));
                    }),
                    GestureDetector(
                      onTap:
                          BlocProvider.of<ChatDetailBloc>(context).state.mode ==
                                  1
                              ? () {
                                  if (content != "") {}
                                }
                              : () {
                                  if (content != "") {}
                                },
                      child: SvgPicture.asset(
                        AppAssets.addIconP,
                        width: 20.w,
                        height: 20.h,
                        color: content != ""
                            ? AppColors.element
                            : AppColors.textBlack.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

void deletePicture(BuildContext context, File image) {
  List<File> currentList =
      BlocProvider.of<ChatDetailBloc>(context).state.images;
  for (int i = 0; i < currentList.length; i += 1) {
    if (currentList[i] == image) {
      currentList.removeAt(i);
      break;
    }
  }
  context.read<ChatDetailBloc>().add(ImagesEvent(currentList));
}

void addPicture(BuildContext context, File image) {
  List<File> currentList =
      List.from(BlocProvider.of<ChatDetailBloc>(context).state.images);
  currentList.add(image);
  context.read<ChatDetailBloc>().add(ImagesEvent(currentList));
}

bool checkChoosePicture(BuildContext context, File image) {
  List<File> currentList =
      BlocProvider.of<ChatDetailBloc>(context).state.images;
  for (int i = 0; i < currentList.length; i += 1) {
    if (currentList[i] == image) {
      return true;
    }
  }
  return false;
}

Widget choosePicture(
    BuildContext context, ScrollController _scrollControllerDeviceImage) {
  return Container(
    height: 200.h,
    child: GridView.builder(
      controller: _scrollControllerDeviceImage,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount:
          BlocProvider.of<ChatDetailBloc>(context).state.deviceImages.length,
      itemBuilder: (BuildContext context, int index) {
        switch (
            BlocProvider.of<ChatDetailBloc>(context).state.statusDeviceImage) {
          case Status.loading:
            return Column(
              children: [
                loadingWidget(),
              ],
            );
          case Status.success:
            if (BlocProvider.of<ChatDetailBloc>(context)
                .state
                .deviceImages
                .isEmpty) {
              return Column(
                children: [
                  Center(
                      child: Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: Text(
                      translate('no_pictures'),
                      style: AppTextStyle.small(),
                    ),
                  )),
                ],
              );
            }
            if (index >=
                BlocProvider.of<ChatDetailBloc>(context)
                    .state
                    .deviceImages
                    .length) {
              if (BlocProvider.of<ChatDetailBloc>(context)
                  .state
                  .hasReachedMaxDeviceImage) {
                return SizedBox();
              }
              // Return something indicating end of list, if needed
              return loadingWidget();
            } else {
              File imageFile = BlocProvider.of<ChatDetailBloc>(context)
                  .state
                  .deviceImages[index];
              bool isChosen = checkChoosePicture(context, imageFile);
              return GestureDetector(
                onTap: () {
                  if (isChosen) {
                    deletePicture(context, imageFile);
                  } else {
                    addPicture(context, imageFile);
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(imageFile),
                        ),
                      ),
                    ),
                    if (isChosen)
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.element,
                        ),
                      ),
                  ],
                ),
              );
            }
        }
      },
    ),
  );
}
