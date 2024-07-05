import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_datetime.dart';
import 'package:hcmus_alumni_mobile/model/friend_request.dart';
import 'package:hcmus_alumni_mobile/model/friend_suggestion.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
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
                fontSize: 12.sp,
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

Widget buildButtonChoose(BuildContext context, void Function(int value)? func) {
  return Container(
    margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (BlocProvider.of<FriendPageBloc>(context).state.page != 0) {
              if (func != null) {
                func(0);
              }
            }
          },
          child: Container(
            width: 105.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: BlocProvider.of<FriendPageBloc>(context).state.page == 1
                  ? AppColors.elementLight
                  : AppColors.element,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                translate('suggestion'),
                style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<FriendPageBloc>(context).state.page == 1
                            ? AppColors.element
                            : AppColors.background),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (BlocProvider.of<FriendPageBloc>(context).state.page != 1) {
              if (func != null) {
                func(1);
              }
            }
          },
          child: Container(
            width: 105.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: BlocProvider.of<FriendPageBloc>(context).state.page == 1
                  ? AppColors.element
                  : AppColors.elementLight,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                translate('request'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<FriendPageBloc>(context).state.page == 1
                            ? AppColors.background
                            : AppColors.element),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              "/friendList",
            );
          },
          child: Container(
            width: 105.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: BlocProvider.of<FriendPageBloc>(context).state.page == 2
                  ? AppColors.element
                  : AppColors.elementLight,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                translate('friend'),
                style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        BlocProvider.of<FriendPageBloc>(context).state.page == 2
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
                      context.read<FriendPageBloc>().add(PageEvent(1));
                    }),
                    Container(
                      height: 15.h,
                    ),
                    Center(
                        child: buildTextField(
                            context, translate('search_user'), 'search', 'search', (value) {
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
                        context.read<FriendPageBloc>().add(PageEvent(1));
                      }),
                      Container(
                        height: 15.h,
                      ),
                      Center(
                          child: buildTextField(
                              context, translate('search_user'), 'search', 'search', (value) {
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
                            fontSize: 11.sp,
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
                          context.read<FriendPageBloc>().add(PageEvent(1));
                        }),
                        Container(
                          height: 15.h,
                        ),
                        Center(
                            child: buildTextField(
                                context, translate('search_user'), 'search', 'search', (value) {
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
      Navigator.pushNamed(context, "/otherProfilePage",
          arguments: {
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
                backgroundImage:
                NetworkImage(suggestion.user.avatarUrl),
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
                          fontSize: 12.sp,
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
                      GestureDetector(
                        onTap: () {
                          FriendPageController(context: context).handleSendRequest(suggestion.user.id);
                        },
                        child: Container(
                          width: 255.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.element,
                            borderRadius: BorderRadius.circular(5.w),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('add_friend'),
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.background),
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
        )
    ),
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
                      context.read<FriendPageBloc>().add(PageEvent(0));
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
                        context.read<FriendPageBloc>().add(PageEvent(0));
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
                            fontSize: 11.sp,
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
                          context.read<FriendPageBloc>().add(PageEvent(0));
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
      Navigator.pushNamed(context, "/otherProfilePage",
          arguments: {
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
                backgroundImage:
                NetworkImage(request.user.avatarUrl),
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
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
                        ),
                      ),
                      Text(
                        handleTimeDifference1(request.createAt),
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 12.sp,
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
                      GestureDetector(
                        onTap: () {
                          FriendPageController(context: context).handleApprovedRequest(request.user.id);
                        },
                        child: Container(
                          width: 120.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.element,
                            borderRadius: BorderRadius.circular(5.w),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('approve'),
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.background),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FriendPageController(context: context).handleDeniedRequest(request.user.id);
                        },
                        child: Container(
                          width: 120.w,
                          height: 30.h,
                          margin: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.circular(5.w),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate('deny'),
                              style: TextStyle(
                                  fontFamily: AppFonts.Header,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  AppColors.textBlack),
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
        )
    ),
  );
}