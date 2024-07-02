import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/interact.dart';
import '../bloc/list_interact_post_group_blocs.dart';
import '../bloc/list_interact_post_group_states.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('people_who_react'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget listInteract(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<ListInteractPostGroupBloc>(context)
                  .state
                  .interacts
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<ListInteractPostGroupBloc>(context)
                .state
                .statusInteract) {
              case Status.loading:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                      height: 1.h,
                      color: AppColors.elementLight,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<ListInteractPostGroupBloc>(context)
                    .state
                    .interacts
                    .isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                            height: 1.h,
                            color: AppColors.elementLight,
                          ),
                          Center(
                              child: Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: Text(
                              translate('no_data'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<ListInteractPostGroupBloc>(context)
                        .state
                        .interacts
                        .length) {
                  if (BlocProvider.of<ListInteractPostGroupBloc>(context)
                      .state
                      .hasReachedMaxInteract) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                          height: 1.h,
                          color: AppColors.elementLight,
                        ),
                        interact(
                            context,
                            BlocProvider.of<ListInteractPostGroupBloc>(context)
                                .state
                                .interacts[index]),
                      ],
                    );
                  } else {
                    return interact(
                        context,
                        BlocProvider.of<ListInteractPostGroupBloc>(context)
                            .state
                            .interacts[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget interact(BuildContext context, Interact interact) {
  return GestureDetector(
    onTap: () {
      if (interact.creator.id ==
          Global.storageService.getUserId()) {
        Navigator.pushNamed(
          context,
          "/myProfilePage",
        );
      } else {
        Navigator.pushNamed(context, "/otherProfilePage",
            arguments: {
              "id": interact.creator.id,
            });
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
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
                  backgroundImage:
                      NetworkImage(interact.creator.avatarUrl ?? ''),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                interact.creator.fullName,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppFonts.Header,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            "assets/icons/like_react.svg",
            height: 15.h,
            width: 15.w,
          ),
        ],
      ),
    ),
  );
}