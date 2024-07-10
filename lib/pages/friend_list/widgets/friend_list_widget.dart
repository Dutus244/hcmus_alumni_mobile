import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';

import '../../../common/function/handle_participant_count.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/friend.dart';
import '../../../model/group.dart';
import '../bloc/friend_list_blocs.dart';
import '../bloc/friend_list_events.dart';
import '../bloc/friend_list_states.dart';
import '../friend_list_controller.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('friend'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buildTextField(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func, String id) {
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
                hintStyle: AppTextStyle.small().withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
              obscureText: false,
              maxLength: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              FriendListController(context: context).handleSearchFriend(id);
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

Widget listFriend(BuildContext context, ScrollController _scrollController, String id) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<FriendListBloc>(context).state.friends.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<FriendListBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: buildTextField(
                            context, translate('search_friend'), 'search', AppAssets.searchIconP, (value) {
                      context.read<FriendListBloc>().add(NameEvent(value));
                    }, id)),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        '${BlocProvider.of<FriendListBloc>(context).state.friendCount} ${translate('friends').toLowerCase()}',
                        style: AppTextStyle.xLarge().wSemiBold(),
                      ),
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<FriendListBloc>(context)
                    .state
                    .friends
                    .isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: buildTextField(
                              context, translate('search_friend'), 'search', AppAssets.searchIconP, (value) {
                        context.read<FriendListBloc>().add(NameEvent(value));
                      }, id)),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Text(
                          '${BlocProvider.of<FriendListBloc>(context).state.friendCount} ${translate('friends').toLowerCase()}',
                          style: AppTextStyle.xLarge().wSemiBold(),
                        ),
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_friends'),
                          style: AppTextStyle.small(),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<FriendListBloc>(context)
                        .state
                        .friends
                        .length) {
                  if (BlocProvider.of<FriendListBloc>(context)
                      .state
                      .hasReachedMaxFriend) {
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
                                context, translate('search_friend'), 'search', AppAssets.searchIconP,
                                (value) {
                          context.read<FriendListBloc>().add(NameEvent(value));
                        }, id)),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '${BlocProvider.of<FriendListBloc>(context).state.friendCount} ${translate('friends').toLowerCase()}',
                            style: AppTextStyle.xLarge().wSemiBold(),
                          ),
                        ),
                        Container(
                          height: 10.h,
                        ),
                        friend(
                            context,
                            BlocProvider.of<FriendListBloc>(context)
                                .state
                                .friends[index]),
                      ],
                    );
                  } else {
                    return friend(
                        context,
                        BlocProvider.of<FriendListBloc>(context)
                            .state
                            .friends[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget friend(BuildContext context, Friend friend) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, "/otherProfilePage",
          arguments: {
            "id": friend.user.id,
          });
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
                  backgroundImage: NetworkImage(friend.user.avatarUrl),
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
                    friend.user.fullName,
                    style: AppTextStyle.small().wSemiBold(),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => friendOption(context, friend),
              );
            },
            child: Container(
              width: 17.w,
              height: 17.h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.thereDotIconP))),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget friendOption(BuildContext context, Friend friend) {
  return GestureDetector(
    onTap: () async {
      bool isDelete = await FriendListController(context: context).handleDeleteFriend(friend.user.id);
      if (isDelete) {
        Navigator.pop(context);
      }
    },
    child: Container(
      height: 60.h,
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 10.w, bottom: 20.h),
        color: Colors.transparent,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.deleteFriendIconS,
              width: 14.w,
              height: 14.h,
              color: AppColors.textBlack,
            ),
            Container(
              width: 10.w,
            ),
            Text(
              translate('unfriend'),
              style: AppTextStyle.medium().wSemiBold(),
            ),
          ],
        ),
      ),
    ),
  );
}
