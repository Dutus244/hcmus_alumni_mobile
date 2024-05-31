import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_advise/bloc/list_interact_post_advise_blocs.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/interact.dart';
import '../bloc/list_interact_post_advise_states.dart';

Widget listInteract(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<ListInteractPostAdviseBloc>(context)
                  .state
                  .interacts
                  .length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<ListInteractPostAdviseBloc>(context)
                .state
                .statusInteract) {
              case Status.loading:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0.h, bottom: 5.h),
                      height: 1.h,
                      color: AppColors.primarySecondaryElement,
                    ),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<ListInteractPostAdviseBloc>(context)
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
                            color: AppColors.primarySecondaryElement,
                          ),
                          Center(
                              child: Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: Text(
                              'Không có dữ liệu',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header2,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<ListInteractPostAdviseBloc>(context)
                        .state
                        .interacts
                        .length) {
                  if (BlocProvider.of<ListInteractPostAdviseBloc>(context)
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
                          color: AppColors.primarySecondaryElement,
                        ),
                        interact(
                            context,
                            BlocProvider.of<ListInteractPostAdviseBloc>(context)
                                .state
                                .interacts[index]),
                      ],
                    );
                  } else {
                    return interact(
                        context,
                        BlocProvider.of<ListInteractPostAdviseBloc>(context)
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
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
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
                  color: AppColors.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppFonts.Header2,
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

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 10.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/applicationPage", (route) => false,
                  arguments: {"route": 2, "secondRoute": 0});
            },
            child: SvgPicture.asset(
              "assets/icons/back.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Container(
            width: 10.w,
          ),
          Text(
            'Người đã bày tỏ cảm xúc',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header0,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.secondaryHeader,
            ),
          ),
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}
