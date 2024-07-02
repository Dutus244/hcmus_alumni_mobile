import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../common/function/handle_percentage_vote.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../../../model/group.dart';
import '../../../model/post.dart';
import '../../../model/vote.dart';
import '../../../model/voter.dart';
import '../bloc/group_detail_list_voters_blocs.dart';
import '../bloc/group_detail_list_voters_states.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('voter_list'),
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

Widget listVoters(BuildContext context, Vote vote, Post post, ScrollController _scrollController) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount:
            BlocProvider.of<GroupDetailListVotersBloc>(context).state.voters.length + 1,
            itemBuilder: (BuildContext context, int index) {
              switch (BlocProvider.of<GroupDetailListVotersBloc>(context).state.statusVoter) {
                case Status.loading:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Text(
                            vote.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                          child: Text(
                            '${calculatePercentages(vote.voteCount, post.totalVote)}% - ${vote.voteCount} lượt bình chọn',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ),
                      ),
                      loadingWidget(),
                    ],
                  );
                case Status.success:
                  if (BlocProvider.of<GroupDetailListVotersBloc>(context)
                      .state
                      .voters
                      .isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Text(
                              vote.name,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                            child: Text(
                              '${calculatePercentages(vote.voteCount, post.totalVote)}% - ${vote.voteCount} lượt bình chọn',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: Text(
                                translate('no_votes'),
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
                      BlocProvider.of<GroupDetailListVotersBloc>(context)
                          .state
                          .voters
                          .length) {
                    if (BlocProvider.of<GroupDetailListVotersBloc>(context)
                        .state
                        .hasReachedMaxVoter) {
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
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w, right: 10.w),
                              child: Text(
                                vote.name,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.Header,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                              child: Text(
                                '${calculatePercentages(vote.voteCount, post.totalVote)}% - ${vote.voteCount} lượt bình chọn',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.Header,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 5.h,
                          ),
                          voter(
                              context,
                              BlocProvider.of<GroupDetailListVotersBloc>(context)
                                  .state
                                  .voters[index]),
                        ],
                      );
                    } else {
                      return voter(
                          context,
                          BlocProvider.of<GroupDetailListVotersBloc>(context)
                              .state
                              .voters[index]);
                    }
                  }
              }
            },
          ),
        ),
        Container(
          height: 70.h,
        )
      ],
    ),
  );
}

Widget voter(BuildContext context, Voter voter) {
  return GestureDetector(
    onTap: () {
      if (voter.user.id ==
          Global.storageService.getUserId()) {
        Navigator.pushNamed(
          context,
          "/myProfilePage",
        );
      } else {
        Navigator.pushNamed(context, "/otherProfilePage",
            arguments: {
              "id": voter.user.id,
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
                  backgroundImage: NetworkImage(voter.user.avatarUrl),
                ),
              ),
              Container(
                width: 10.w,
              ),
              Text(
                voter.user.fullName,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppFonts.Header,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}