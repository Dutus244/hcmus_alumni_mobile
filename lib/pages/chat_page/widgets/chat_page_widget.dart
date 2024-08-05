import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/global.dart';
import 'package:hcmus_alumni_mobile/model/inbox.dart';

import '../../../common/services/socket_service.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/loading_widget.dart';
import '../bloc/chat_page_states.dart';
import '../bloc/chat_page_blocs.dart';
import '../bloc/chat_page_events.dart';
import '../chat_page_controller.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10.w,
          ),
          Text(
            translate('chat'),
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(context).wSemiBold(),
          ),
          Container(
            width: 60.w,
            child: Row(
              children: [
                Container(
                  width: 30.w,
                ),
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          "/chatCreate",
                        );
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.addIconP))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget buildTextField(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func) {
  return Container(
      width: 340.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 10.h, top: 0.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 280.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 20.w),
            child: TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
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
                hintStyle: AppTextStyle.small(context)
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              obscureText: false,
              maxLength: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              ChatPageController(context: context).handleSearchInbox();
            },
            child: Container(
              width: 16.w,
              height: 16.w,
              margin: EdgeInsets.only(right: 10.w),
              child: Image.asset(iconName),
            ),
          ),
        ],
      ));
}

Widget listInbox(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<ChatPageBloc>(context).state.inboxes.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<ChatPageBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    Center(
                        child: buildTextField(
                            context,
                            translate('search_inbox'),
                            'search',
                            AppAssets.searchIconP, (value) {
                      context.read<ChatPageBloc>().add(NameEvent(value));
                    })),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<ChatPageBloc>(context)
                    .state
                    .inboxes
                    .isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: buildTextField(
                              context,
                              translate('search_inbox'),
                              'search',
                              AppAssets.searchIconP, (value) {
                        context.read<ChatPageBloc>().add(NameEvent(value));
                      })),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_inboxes'),
                          style: AppTextStyle.small(context),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<ChatPageBloc>(context)
                        .state
                        .inboxes
                        .length) {
                  if (BlocProvider.of<ChatPageBloc>(context)
                      .state
                      .hasReachedMaxInbox) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        Center(
                            child: buildTextField(
                                context,
                                translate('search_inbox'),
                                'search',
                                AppAssets.searchIconP, (value) {
                          context.read<ChatPageBloc>().add(NameEvent(value));
                        })),
                        inbox(
                            context,
                            BlocProvider.of<ChatPageBloc>(context)
                                .state
                                .inboxes[index]),
                      ],
                    );
                  } else {
                    return inbox(
                        context,
                        BlocProvider.of<ChatPageBloc>(context)
                            .state
                            .inboxes[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget inbox(BuildContext context, Inbox inbox) {
  return ElevatedButton(
    onPressed: () {
      socketService.readInbox(inbox.id, {
        'userId': Global.storageService.getUserId(),
        'lastReadMessageId': inbox.latestMessage.id,
      });
      Navigator.pushNamed(context, "/chatDetail", arguments: {
        "inboxId": inbox.id,
        "name": inbox.members[0].userId != Global.storageService.getUserId()
            ? inbox.members[0].user.fullName
            : inbox.members[1].user.fullName
      });
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.transparent, backgroundColor: inbox.hasRead ? Colors.transparent : AppColors.elementLight,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Rectangular shape
      ),
    ),
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 7.h, bottom: 7.h),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            child: CircleAvatar(
              radius: 20,
              child: null,
              backgroundImage: NetworkImage(inbox.members[0].userId != Global.storageService.getUserId()
                  ? inbox.members[0].user.avatarUrl
                  : inbox.members[1].user.avatarUrl),
            ),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.w),
                width: 250.w,
                child: Row(
                  children: [
                    Text(
                      inbox.members[0].user.id == Global.storageService.getUserId()
                          ? inbox.members[1].user.fullName
                          : inbox.members[0].user.fullName,
                      style: inbox.hasRead
                          ? AppTextStyle.small(context)
                          : AppTextStyle.small(context).wSemiBold(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Container(
                    width: 180.w,
                    child: Text(
                      (inbox.latestMessage.sender.id == Global.storageService.getUserId()
                          ? '${translate('me')}: '
                          : '') +
                          (inbox.latestMessage.messageType == "IMAGE"
                              ? 'Đã gửi một ảnh'
                              : inbox.latestMessage.content),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: inbox.hasRead
                          ? AppTextStyle.small(context).withColor(AppColors.textGrey)
                          : AppTextStyle.small(context).withColor(AppColors.textGrey).wSemiBold(),
                    ),
                  ),
                  Text(
                    ' ${handleDateTime3(inbox.latestMessage.createAt)}',
                    style: inbox.hasRead
                        ? AppTextStyle.small(context).withColor(AppColors.textGrey)
                        : AppTextStyle.small(context).withColor(AppColors.textGrey).wSemiBold(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

