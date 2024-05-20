import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/member.dart';
import '../bloc/group_member_blocs.dart';
import '../bloc/group_member_states.dart';

// Widget listMember(
//     BuildContext context, ScrollController _scrollController, Group group, int secondRoute) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Expanded(
//         child: ListView.builder(
//           controller: _scrollController,
//           itemCount: BlocProvider.of<GroupMemberBloc>(context)
//               .state
//               .member
//               .length +
//               1,
//           itemBuilder: (BuildContext context, int index) {
//             switch (BlocProvider.of<GroupMemberBloc>(context)
//                 .state
//                 .status) {
//               case Status.loading:
//                 return Column(
//                   children: [
//                     loadingWidget(),
//                   ],
//                 );
//               case Status.success:
//                 if (BlocProvider.of<GroupMemberBloc>(context)
//                     .state
//                     .member
//                     .isEmpty) {
//                   return Column(
//                     children: [
//                       Center(
//                           child: Container(
//                             margin: EdgeInsets.only(top: 20.h),
//                             child: Text(
//                               'Không có thành viên nào',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 11.sp,
//                                 fontWeight: FontWeight.normal,
//                                 fontFamily: AppFonts.Header2,
//                               ),
//                             ),
//                           )),
//                     ],
//                   );
//                 }
//                 if (index >=
//                     BlocProvider.of<GroupMemberBloc>(context)
//                         .state
//                         .member
//                         .length) {
//                   if (BlocProvider.of<GroupMemberBloc>(context)
//                       .state
//                       .hasReachedMaxMember) {
//                     return SizedBox();
//                   }
//                   // Return something indicating end of list, if needed
//                   return loadingWidget();
//                 } else {
//                   if (index == 0) {
//                     // Create a custom widget to combine button and news item
//                     return Column(
//                       children: [
//                         Container(
//                           height: 10.h,
//                         ),
//                         member(
//                             context,
//                             BlocProvider.of<GroupMemberBloc>(context)
//                                 .state
//                                 .member[index]),
//                       ],
//                     );
//                   } else {
//                     return member(
//                         context,
//                         BlocProvider.of<GroupMemberBloc>(context)
//                             .state
//                             .member[index]);
//                   }
//                 }
//             }
//           },
//         ),
//       ),
//       navigation(context, group, secondRoute),
//     ],
//   );
// }

Widget listMember(BuildContext context, ScrollController _scrollController,
    Group group, int secondRoute) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: BlocProvider.of<GroupMemberBloc>(context)
                  .state
                  .admin
                  .length +
              BlocProvider.of<GroupMemberBloc>(context).state.member.length +
              1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<GroupMemberBloc>(context).state.status) {
              case Status.loading:
                return Column(
                  children: [
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<GroupMemberBloc>(context)
                    .state
                    .admin
                    .length + BlocProvider.of<GroupMemberBloc>(context)
                    .state
                    .member
                    .length == 0) {
                  return Column(
                    children: [
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'Không có thành viên nào',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.Header2,
                          ),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .admin
                            .length +
                        BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .member
                            .length) {
                  if (BlocProvider.of<GroupMemberBloc>(context)
                      .state
                      .hasReachedMaxMember) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (BlocProvider.of<GroupMemberBloc>(context)
                              .state
                              .admin
                              .length !=
                          0 &&
                      index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 5.h),
                          child: Text(
                            'Quản trị viên',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ),
                        member(
                            context,
                            BlocProvider.of<GroupMemberBloc>(context)
                                .state
                                .admin[index]),
                      ],
                    );
                  } else if (index -
                          BlocProvider.of<GroupMemberBloc>(context)
                              .state
                              .admin
                              .length ==
                      0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 5.h),
                          child: Text(
                            'Thành viên',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ),
                        member(
                            context,
                            BlocProvider.of<GroupMemberBloc>(context)
                                .state
                                .member[index - BlocProvider.of<GroupMemberBloc>(context)
                                .state
                                .admin
                                .length]),
                      ],
                    );
                  } else if (BlocProvider.of<GroupMemberBloc>(context)
                      .state
                      .admin.length > index) {
                    return member(
                        context,
                        BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .admin[index]);
                  } else {
                    return member(
                        context,
                        BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .member[index - BlocProvider.of<GroupMemberBloc>(context)
                            .state
                            .admin
                            .length]);
                  }
                }
            }
          },
        ),
      ),
      navigation(context, group, secondRoute),
    ],
  );
}

Widget member(BuildContext context, Member member) {
  return GestureDetector(
    onTap: () {},
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
                  backgroundImage: NetworkImage(member.participant.avatarUrl),
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
                    member.participant.fullName,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                  if (member.role == 'ADMIN')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/star_circle.svg",
                          width: 12.w,
                          height: 12.h,
                          color: AppColors.primarySecondaryText,
                        ),
                        Container(
                          width: 2.w,
                        ),
                        Text(
                          'Quản trị viên',
                          style: TextStyle(
                            color: AppColors.primarySecondaryText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            fontFamily: AppFonts.Header2,
                          ),
                        ),
                      ],
                    ),
                  if (member.role == 'MEMBER')
                    Text(
                      'Thành viên',
                      style: TextStyle(
                        color: AppColors.primarySecondaryText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppFonts.Header2,
                      ),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget navigation(BuildContext context, Group group, int secondRoute) {
  return Container(
    height: 45.h,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/groupInfo",
                    (route) => false,
                    arguments: {
                      "group": group,
                      "secondRoute": secondRoute,
                    },
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
