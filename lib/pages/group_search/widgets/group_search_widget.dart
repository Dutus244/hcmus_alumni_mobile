import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/function/handle_participant_count.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/group.dart';
import '../bloc/group_search_blocs.dart';
import '../bloc/group_search_events.dart';
import '../bloc/group_search_states.dart';
import '../group_search_controller.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('group'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
            color: AppColors.secondaryHeader,
          ),
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
              GroupSearchController(context: context).handleSearchGroup();
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

Widget listGroup(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<GroupSearchBloc>(context).state.groups.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<GroupSearchBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    Center(
                        child: buildTextField(
                            context, translate('search_group'), 'search', 'search', (value) {
                      context.read<GroupSearchBloc>().add(NameEvent(value));
                    })),
                    Container(
                      height: 10.h,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<GroupSearchBloc>(context)
                    .state
                    .groups
                    .isEmpty) {
                  return Column(
                    children: [
                      Center(
                          child: buildTextField(
                              context, translate('search_group'), 'search', 'search', (value) {
                        context.read<GroupSearchBloc>().add(NameEvent(value));
                      })),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_data'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<GroupSearchBloc>(context)
                        .state
                        .groups
                        .length) {
                  if (BlocProvider.of<GroupSearchBloc>(context)
                      .state
                      .hasReachedMaxGroup) {
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
                                context, translate('search_group'), 'search', 'search',
                                (value) {
                          context.read<GroupSearchBloc>().add(NameEvent(value));
                        })),
                        Container(
                          height: 5.h,
                        ),
                        group(
                            context,
                            BlocProvider.of<GroupSearchBloc>(context)
                                .state
                                .groups[index]),
                      ],
                    );
                  } else {
                    return group(
                        context,
                        BlocProvider.of<GroupSearchBloc>(context)
                            .state
                            .groups[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget group(BuildContext context, Group group) {
  String typeGroup = '';
  if (group.privacy == 'PUBLIC') {
    typeGroup = translate('public');
  } else {
    typeGroup = translate('private');
  }

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        "/groupDetail",
        arguments: {
          "id": group.id,
        },
      );
    },
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
          color: Colors.transparent,
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 40.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          image: DecorationImage(
                            image: NetworkImage(group.coverUrl ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name,
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.w900,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2.h),
                            child: Text(
                              '$typeGroup - ${handleParticipantCount(group.participantCount)} ${translate('members').toLowerCase()}',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                          Container(
                            width: 280.w,
                            margin: EdgeInsets.only(top: 2.h),
                            child: Text(
                              group.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                          if (group.isRequestPending)
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              width: 280.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 230, 230, 230),
                                borderRadius: BorderRadius.circular(5.w),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  translate('waiting_approval'),
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header,
                                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                            ),
                          if (!group.isJoined && !group.isRequestPending)
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              width: 280.w,
                              height: 25.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (BlocProvider.of<GroupSearchBloc>(context).state.isLoading) {
                                    return;
                                  }
                                  GroupSearchController(context: context).handleRequestJoinGroup(group);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.element,
                                  foregroundColor: AppColors.background,// Background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.w), // Rounded corners
                                  ),
                                  side: BorderSide(color: Colors.transparent), // Border color
                                  minimumSize: Size(280.w, 25.h), // Button size
                                  padding: EdgeInsets.zero, // Remove default padding
                                ),
                                child: Center(
                                  child: Text(
                                    translate('join'),
                                    style: TextStyle(
                                      fontFamily: AppFonts.Header,
                                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.background, // Text color
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (group.isJoined)
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              width: 280.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: AppColors.elementLight,
                                borderRadius: BorderRadius.circular(5.w),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  translate('see_details'),
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header,
                                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.element,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          height: 2.h,
          color: AppColors.elementLight,
        ),
      ],
    ),
  );
}
