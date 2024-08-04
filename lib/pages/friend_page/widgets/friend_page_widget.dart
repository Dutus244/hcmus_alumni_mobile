import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/global.dart';
import 'package:hcmus_alumni_mobile/model/friend_request.dart';
import 'package:hcmus_alumni_mobile/model/friend_suggestion.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/user.dart';
import '../bloc/friend_page_blocs.dart';
import '../bloc/friend_page_states.dart';
import '../bloc/friend_page_events.dart';
import '../friend_page_controller.dart';

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
                hintStyle: TextStyle(
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                color: AppColors.textBlack,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
              ),
              autocorrect: false,
              obscureText: false,
              maxLength: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              FriendPageController(context: context).handleSearchFriend();
            },
            child: Container(
              width: 16.w,
              height: 16.w,
              margin: EdgeInsets.only(right: 10.w),
              child: Image.asset("assets/icons/$iconName.png"),
            ),
          ),
        ],
      ));
}

Widget buildTextFieldUser(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
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
                hintStyle: TextStyle(
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                color: AppColors.textBlack,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
              ),
              autocorrect: false,
              obscureText: false,
              maxLength: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              FriendPageController(context: context).handleSearchUser();
            },
            child: Container(
              width: 16.w,
              height: 16.w,
              margin: EdgeInsets.only(right: 10.w),
              child: Image.asset("assets/icons/$iconName.png"),
            ),
          ),
        ],
      ));
}

Widget buildButtonChoose(BuildContext context, void Function(int value)? func) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => func!(0),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('all'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<FriendPageBloc>(context).state.page == 0
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<FriendPageBloc>(context).state.page == 0)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => func!(1),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('suggestion'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<FriendPageBloc>(context).state.page == 1
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<FriendPageBloc>(context).state.page == 1)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => func!(2),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('request'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<FriendPageBloc>(context).state.page == 2
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<FriendPageBloc>(context).state.page == 2)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () async {
            await Navigator.pushNamed(context, "/friendList",
                arguments: {"id": Global.storageService.getUserId()});
            FriendPageController(context: context).handleLoadSuggestionData(0);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 30.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Column(
            children: [
              Text(
                translate('friend'),
                style: AppTextStyle.small(context).wSemiBold().withColor(
                      BlocProvider.of<FriendPageBloc>(context).state.page == 3
                          ? AppColors.element
                          : AppColors.textGrey,
                    ),
              ),
              if (BlocProvider.of<FriendPageBloc>(context).state.page == 3)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.element,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget listUser(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<FriendPageBloc>(context).state.users.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<FriendPageBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<FriendPageBloc>().add(PageEvent(value));
                    }),
                    Container(
                      height: 15.h,
                    ),
                    Center(
                        child: buildTextFieldUser(
                            context,
                            translate('search_user'),
                            'search',
                            'search', (value) {
                      context.read<FriendPageBloc>().add(NameUserEvent(value));
                    })),
                    Container(
                      height: 5.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<FriendPageBloc>(context)
                    .state
                    .users
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<FriendPageBloc>().add(PageEvent(value));
                      }),
                      Container(
                        height: 15.h,
                      ),
                      Center(
                          child: buildTextFieldUser(
                              context,
                              translate('search_user'),
                              'search',
                              'search', (value) {
                        context
                            .read<FriendPageBloc>()
                            .add(NameUserEvent(value));
                      })),
                      Container(
                        height: 5.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                11.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<FriendPageBloc>(context)
                        .state
                        .users
                        .length) {
                  if (BlocProvider.of<FriendPageBloc>(context)
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
                      children: [
                        buildButtonChoose(context, (value) {
                          context.read<FriendPageBloc>().add(PageEvent(value));
                        }),
                        Container(
                          height: 15.h,
                        ),
                        Center(
                            child: buildTextFieldUser(
                                context,
                                translate('search_user'),
                                'search',
                                'search', (value) {
                          context
                              .read<FriendPageBloc>()
                              .add(NameUserEvent(value));
                        })),
                        Container(
                          height: 5.h,
                        ),
                        user(
                            context,
                            BlocProvider.of<FriendPageBloc>(context)
                                .state
                                .users[index]),
                      ],
                    );
                  } else {
                    return user(
                        context,
                        BlocProvider.of<FriendPageBloc>(context)
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
      Navigator.pushNamed(context, "/otherProfilePage", arguments: {
        "id": user.id,
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

Widget listSuggestion(
    BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<FriendPageBloc>(context)
                  .state
                  .friendSuggestions
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<FriendPageBloc>(context)
                .state
                .statusSuggestion) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<FriendPageBloc>().add(PageEvent(value));
                    }),
                    Container(
                      height: 15.h,
                    ),
                    Center(
                        child: buildTextField(context, translate('search_user'),
                            'search', 'search', (value) {
                      context.read<FriendPageBloc>().add(NameEvent(value));
                    })),
                    Container(
                      height: 5.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<FriendPageBloc>(context)
                    .state
                    .friendSuggestions
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<FriendPageBloc>().add(PageEvent(value));
                      }),
                      Container(
                        height: 15.h,
                      ),
                      Center(
                          child: buildTextField(
                              context,
                              translate('search_user'),
                              'search',
                              'search', (value) {
                        context.read<FriendPageBloc>().add(NameEvent(value));
                      })),
                      Container(
                        height: 5.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                11.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<FriendPageBloc>(context)
                        .state
                        .friendSuggestions
                        .length) {
                  if (BlocProvider.of<FriendPageBloc>(context)
                      .state
                      .hasReachedMaxSuggestion) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChoose(context, (value) {
                          context.read<FriendPageBloc>().add(PageEvent(value));
                        }),
                        Container(
                          height: 15.h,
                        ),
                        Center(
                            child: buildTextField(
                                context,
                                translate('search_user'),
                                'search',
                                'search', (value) {
                          context.read<FriendPageBloc>().add(NameEvent(value));
                        })),
                        Container(
                          height: 5.h,
                        ),
                        suggestion(
                            context,
                            BlocProvider.of<FriendPageBloc>(context)
                                .state
                                .friendSuggestions[index]),
                      ],
                    );
                  } else {
                    return suggestion(
                        context,
                        BlocProvider.of<FriendPageBloc>(context)
                            .state
                            .friendSuggestions[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget suggestion(BuildContext context, FriendSuggestion suggestion) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, "/otherProfilePage", arguments: {
        "id": suggestion.user.id,
      });
    },
    child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              child: CircleAvatar(
                radius: 40,
                child: null,
                backgroundImage: NetworkImage(suggestion.user.avatarUrl),
              ),
            ),
            Container(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 255.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        suggestion.user.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize:
                              12.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10.h,
                ),
                Container(
                  width: 255.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 255.w,
                        height: 30.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (BlocProvider.of<FriendPageBloc>(context).state.isLoading) {
                              return;
                            }
                            FriendPageController(context: context).handleSendRequest(suggestion.user.id);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.background, backgroundColor: AppColors.element,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            minimumSize: Size(255.w, 30.h),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('add_friend'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}

Widget listRequest(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<FriendPageBloc>(context)
                  .state
                  .friendRequests
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (
                BlocProvider.of<FriendPageBloc>(context).state.statusRequest) {
              case Status.loading:
                return Column(
                  children: [
                    buildButtonChoose(context, (value) {
                      context.read<FriendPageBloc>().add(PageEvent(value));
                    }),
                    Container(
                      height: 5.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<FriendPageBloc>(context)
                    .state
                    .friendRequests
                    .isEmpty) {
                  return Column(
                    children: [
                      buildButtonChoose(context, (value) {
                        context.read<FriendPageBloc>().add(PageEvent(value));
                      }),
                      Container(
                        height: 5.h,
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                11.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<FriendPageBloc>(context)
                        .state
                        .friendRequests
                        .length) {
                  if (BlocProvider.of<FriendPageBloc>(context)
                      .state
                      .hasReachedMaxRequest) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        buildButtonChoose(context, (value) {
                          context.read<FriendPageBloc>().add(PageEvent(value));
                        }),
                        Container(
                          height: 15.h,
                        ),
                        request(
                            context,
                            BlocProvider.of<FriendPageBloc>(context)
                                .state
                                .friendRequests[index]),
                      ],
                    );
                  } else {
                    return request(
                        context,
                        BlocProvider.of<FriendPageBloc>(context)
                            .state
                            .friendRequests[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget request(BuildContext context, FriendRequest request) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, "/otherProfilePage", arguments: {
        "id": request.user.id,
      });
    },
    child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              child: CircleAvatar(
                radius: 40,
                child: null,
                backgroundImage: NetworkImage(request.user.avatarUrl),
              ),
            ),
            Container(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 255.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request.user.fullName,
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize:
                              12.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                      Text(
                        handleTimeDifference1(request.createAt),
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize:
                              12.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10.h,
                ),
                Container(
                  width: 255.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120.w,
                        height: 30.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (BlocProvider.of<FriendPageBloc>(context).state.isLoading) {
                              return;
                            }
                            FriendPageController(context: context).handleApprovedRequest(request.user.id);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.background, backgroundColor: AppColors.element,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            minimumSize: Size(120.w, 30.h),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('accept'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120.w,
                        height: 30.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (BlocProvider.of<FriendPageBloc>(context).state.isLoading) {
                              return;
                            }
                            FriendPageController(context: context).handleDeniedRequest(request.user.id);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.textBlack, backgroundColor: Color.fromARGB(255, 230, 230, 230),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            minimumSize: Size(120.w, 30.h),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('delete'),
                              style: TextStyle(
                                fontFamily: AppFonts.Header,
                                fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}
