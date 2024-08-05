import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/user.dart';

import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/loading_widget.dart';
import '../chat_create_controller.dart';
import '../bloc/chat_create_blocs.dart';
import '../bloc/chat_create_states.dart';
import '../bloc/chat_create_events.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('create_chat'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium(context).wSemiBold(),
        ),
      ),
    ),
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
              ChatCreateController(context: context).handleSearchUser();
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

Widget listUser(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<ChatCreateBloc>(context).state.users.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<ChatCreateBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: buildTextField(context, translate('search_user'),
                            'search', AppAssets.searchIconP, (value) {
                      context.read<ChatCreateBloc>().add(NameEvent(value));
                    })),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<ChatCreateBloc>(context)
                    .state
                    .users
                    .isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: buildTextField(
                              context,
                              translate('search_user'),
                              'search',
                              AppAssets.searchIconP, (value) {
                        context.read<ChatCreateBloc>().add(NameEvent(value));
                      })),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_users'),
                          style: AppTextStyle.small(context),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<ChatCreateBloc>(context)
                        .state
                        .users
                        .length) {
                  if (BlocProvider.of<ChatCreateBloc>(context)
                      .state
                      .hasReachedMaxUser) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: buildTextField(
                                context,
                                translate('search_user'),
                                'search',
                                AppAssets.searchIconP, (value) {
                          context.read<ChatCreateBloc>().add(NameEvent(value));
                        })),
                        Container(
                          height: 5.h,
                        ),
                        user(
                            context,
                            BlocProvider.of<ChatCreateBloc>(context)
                                .state
                                .users[index]),
                      ],
                    );
                  } else {
                    return user(
                        context,
                        BlocProvider.of<ChatCreateBloc>(context)
                            .state
                            .users[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget user(BuildContext context, User user) {
  return GestureDetector(
    onTap: () {
      if (BlocProvider.of<ChatCreateBloc>(context).state.isLoading) {
        return;
      }
      ChatCreateController(context: context).handleCreateInbox(user);
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
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: AppTextStyle.small(context).wSemiBold(),
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
