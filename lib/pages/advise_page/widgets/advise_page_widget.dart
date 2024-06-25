import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/function/handle_percentage_vote.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/colors.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page_controller.dart';

import '../../../common/function/handle_datetime.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../global.dart';
import '../bloc/advise_page_blocs.dart';
import '../bloc/advise_page_states.dart';

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
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage",
                (route) => false,
                arguments: {"route": 0},
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.w),
              child: SizedBox(
                width: 60.w,
                height: 120.h,
                child: Image.asset(AppAssets.logoImage),
              ),
            ),
          ),
          Text(
            translate('advise'),
            textAlign: TextAlign.center,
            style: AppTextStyle.medium().wSemiBold(),
          ),
          Container(
            width: 60.w,
            child: Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/chatPage");
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.chatIconP))),
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
                Container(
                  width: 20.w,
                  height: 20.w,
                  margin: EdgeInsets.only(),
                  child: GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(context, "/myProfilePage");
                        AdvisePageController(context: context)
                            .handleLoadPostData(0);
                      },
                      child: CircleAvatar(
                        radius: 10,
                        child: null,
                        backgroundImage: NetworkImage(
                            'https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                      )),
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

Widget buildCreatePostButton(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      await Navigator.pushNamed(
        context,
        "/writePostAdvise",
      );
      AdvisePageController(context: context).handleLoadPostData(0);
    },
    child: Container(
      height: 40.h,
      padding: EdgeInsets.only(top: 0.h, bottom: 5.h, left: 10.w),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 300.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    translate('what_advise_do_you_want'),
                    style: AppTextStyle.small(),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                AppAssets.imageIconP,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget listPost(BuildContext context, ScrollController _scrollController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
              BlocProvider.of<AdvisePageBloc>(context).state.posts.length + 1,
          itemBuilder: (BuildContext context, int index) {
            switch (BlocProvider.of<AdvisePageBloc>(context).state.statusPost) {
              case Status.loading:
                return Column(
                  children: [
                    if (Global.storageService.permissionCounselCreate())
                      buildCreatePostButton(context),
                    loadingWidget(),
                  ],
                );
              case Status.success:
                if (BlocProvider.of<AdvisePageBloc>(context)
                    .state
                    .posts
                    .isEmpty) {
                  return Column(
                    children: [
                      if (Global.storageService.permissionCounselCreate())
                        buildCreatePostButton(context),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          translate('no_posts'),
                          style: AppTextStyle.small(),
                        ),
                      )),
                    ],
                  );
                }
                if (index >=
                    BlocProvider.of<AdvisePageBloc>(context)
                        .state
                        .posts
                        .length) {
                  if (BlocProvider.of<AdvisePageBloc>(context)
                      .state
                      .hasReachedMaxPost) {
                    return SizedBox();
                  }
                  // Return something indicating end of list, if needed
                  return loadingWidget();
                } else {
                  if (index == 0) {
                    // Create a custom widget to combine button and news item
                    return Column(
                      children: [
                        if (Global.storageService.permissionCounselCreate())
                          buildCreatePostButton(context),
                        post(
                            context,
                            BlocProvider.of<AdvisePageBloc>(context)
                                .state
                                .posts[index]),
                      ],
                    );
                  } else {
                    return post(
                        context,
                        BlocProvider.of<AdvisePageBloc>(context)
                            .state
                            .posts[index]);
                  }
                }
            }
          },
        ),
      ),
    ],
  );
}

Widget postOption(BuildContext context, Post post) {
  return Container(
    height: post.votes.length == 0 ? 90.h : 50.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (post.votes.length == 0)
                GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      "/editPostAdvise",
                      arguments: {
                        "post": post,
                      },
                    );
                    AdvisePageController(context: context)
                        .handleLoadPostData(0);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, top: 10.h),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.editIconS,
                          width: 14.w,
                          height: 14.h,
                          color: AppColors.textBlack,
                        ),
                        Container(
                          width: 10.w,
                        ),
                        Text(
                          translate('edit_post'),
                          style: AppTextStyle.medium().wMedium(),
                        ),
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () async {
                  bool shouldDelete =
                      await AdvisePageController(context: context)
                          .handleDeletePost(post.id);
                  if (shouldDelete) {
                    Navigator.pop(context); // Close the modal after deletion
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.trashIconS,
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_post'),
                        style: AppTextStyle.medium().wMedium(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget post(BuildContext context, Post post) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35.h,
          margin: EdgeInsets.only(top: 5.h),
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 35.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: GestureDetector(
                    onTap: () {
                      if (post.creator.id ==
                          Global.storageService.getUserId()) {
                        Navigator.pushNamed(
                          context,
                          "/myProfilePage",
                        );
                      } else {
                        Navigator.pushNamed(context, "/otherProfilePage",
                            arguments: {
                              "id": post.creator.id,
                            });
                      }
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                          NetworkImage(post.creator.avatarUrl ?? ""),
                    )),
              ),
              Container(
                width: 270.w,
                height: 35.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      post.creator.fullName,
                      maxLines: 1,
                      style: AppTextStyle.small().wSemiBold(),
                    ),
                    Row(
                      children: [
                        Text(
                          handleTimeDifference2(post.publishedAt),
                          maxLines: 1,
                          style: AppTextStyle.xSmall()
                              .withColor(AppColors.textGrey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (post.permissions.edit || post.permissions.delete)
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => postOption(context, post),
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
        Container(
          margin: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
          child: Text(
            post.title,
            textAlign: TextAlign.left,
            style: AppTextStyle.small().wSemiBold(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.tagIconS,
                width: 12.w,
                height: 12.h,
                color: AppColors.textGrey,
              ),
              Container(
                margin: EdgeInsets.only(left: 2.w),
                width: 300.w,
                child: Text(
                  post.tags.map((tag) => tag.name).join(' '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.xSmall().withColor(AppColors.tag),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: ExpandableText(
            post.content,
            maxLines: 4,
            expandText: translate('see_more'),
            collapseText: translate('collapse'),
            style: AppTextStyle.small(),
          ),
        ),
        if (!post.allowMultipleVotes)
          for (int i = 0; i < post.votes.length; i += 1)
            Container(
              width: 350.w,
              height: 35.h,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (Global.storageService.permissionCounselVote())
                          Radio(
                            value: post.votes[i].name,
                            groupValue: post.voteSelectedOne,
                            onChanged: (value) {
                              if (post.voteSelectedOne == "") {
                                AdvisePageController(context: context)
                                    .handleVote(post.id, post.votes[i].id);
                              } else {
                                for (int j = 0; j < post.votes.length; j += 1) {
                                  if (post.votes[j].name ==
                                      post.voteSelectedOne) {
                                    AdvisePageController(context: context)
                                        .handleUpdateVote(post.id,
                                            post.votes[j].id, post.votes[i].id);
                                  }
                                }
                              }
                            },
                          ),
                        Container(
                          width: 220.w,
                          child: Text(
                            post.votes[i].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.small()
                                .withColor(AppColors.textGrey),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          "/advisePageListVoters",
                          arguments: {
                            "vote": post.votes[i],
                            "post": post,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                            style: AppTextStyle.small()
                                .withColor(AppColors.element),
                          ),
                          Container(
                            width: 5.w,
                          ),
                          SvgPicture.asset(
                            AppAssets.arrowNextIconS,
                            height: 15.h,
                            width: 15.w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        if (post.allowMultipleVotes)
          for (int i = 0; i < post.votes.length; i += 1)
            Container(
              width: 350.w,
              height: 35.h,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (Global.storageService.permissionCounselVote())
                          Checkbox(
                            checkColor: AppColors.background,
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return AppColors.element; // Selected color
                                }
                                return Colors.transparent; // Unselected color
                              },
                            ),
                            onChanged: (value) {
                              if (value! == true) {
                                AdvisePageController(context: context)
                                    .handleVote(post.id, post.votes[i].id);
                              } else {
                                AdvisePageController(context: context)
                                    .handleDeleteVote(
                                        post.id, post.votes[i].id);
                              }
                            },
                            value: post.voteSelectedMultiple
                                .contains(post.votes[i].name),
                          ),
                        Container(
                          width: 220.w,
                          child: Text(
                            post.votes[i].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.small()
                                .withColor(AppColors.textGrey),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/advisePageListVoters",
                          arguments: {
                            "vote": post.votes[i],
                            "post": post,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            '${calculatePercentages(post.votes[i].voteCount, post.totalVote)}%',
                            style: AppTextStyle.small()
                                .withColor(AppColors.element),
                          ),
                          Container(
                            width: 5.w,
                          ),
                          SvgPicture.asset(
                            AppAssets.arrowNextIconS,
                            height: 15.h,
                            width: 15.w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        if (post.votes.length > 0 && post.allowAddOptions)
          GestureDetector(
            onTap: () {
              if (post.votes.length >= 10) {
                toastInfo(msg: translate("option_above_10"));
                return;
              }
              TextEditingController textController = TextEditingController();

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(translate('add_option')),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: translate('add_option'),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(translate('cancel')),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, {
                        'confirmed': true,
                        'vote': textController.text,
                      }),
                      child: Text(translate('add')),
                    ),
                  ],
                ),
              ).then((result) {
                if (result != null && result['confirmed'] == true) {
                  String vote = result['vote'];
                  AdvisePageController(context: context)
                      .handleAddVote(post.id, vote);
                } else {}
              });
            },
            child: Container(
              width: 350.w,
              height: 35.h,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.addIconS,
                      width: 14.w,
                      height: 14.h,
                      color: AppColors.textGrey,
                    ),
                    Container(
                      width: 5.w,
                    ),
                    Text(
                      translate('add_option'),
                      style: AppTextStyle.small(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Container(
          height: 5.h,
        ),
        if (post.pictures.length == 1)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              width: 340.w,
              height: 240.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(post.pictures[0].pictureUrl),
                ),
              ),
            ),
          ),
        if (post.pictures.length == 2)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Column(
                children: [
                  Container(
                    width: 340.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.pictures[0].pictureUrl),
                      ),
                    ),
                  ),
                  Container(
                    width: 340.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.pictures[1].pictureUrl),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (post.pictures.length == 3)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: 340.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.pictures[0].pictureUrl),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[1].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[2].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (post.pictures.length == 4)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[0].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[1].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[2].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[3].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (post.pictures.length == 5)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/listPicturePostAdvise",
                arguments: {
                  "post": post,
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[0].pictureUrl),
                            ),
                          ),
                        ),
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[1].pictureUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Container(
                          width: 170.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(post.pictures[2].pictureUrl),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 170.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(post.pictures[3].pictureUrl),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: 170.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color:
                                      AppColors.blurredPicture.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    '+1',
                                    style: AppTextStyle.xLarge()
                                        .size(32.sp)
                                        .wSemiBold(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        Container(
          height: 5.h,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/listInteractPostAdvise",
                    arguments: {
                      "id": post.id,
                    },
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: SvgPicture.asset(
                        AppAssets.likeIconS1,
                        height: 15.h,
                        width: 15.w,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        post.reactionCount.toString(),
                        style: AppTextStyle.xSmall(),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    "/listCommentPostAdvise",
                    arguments: {
                      "id": post.id,
                    },
                  );
                  AdvisePageController(context: context).handleLoadPostData(0);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    '${post.childrenCommentNumber} ${translate('comments').toLowerCase()}',
                    style: AppTextStyle.xSmall(),
                  ),
                ),
              )
            ],
          ),
        ),
        if (Global.storageService.permissionCounselReactionCreate() ||
            Global.storageService.permissionCounselCommentCreate())
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5.h),
                height: 1.h,
                color: AppColors.elementLight,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (Global.storageService.permissionCounselReactionCreate())
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            AdvisePageController(context: context)
                                .handleLikePost(post.id);
                          },
                          child: post.isReacted
                              ? Container(
                                  margin: EdgeInsets.only(left: 40.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.likeIconS2,
                                        width: 20.w,
                                        height: 20.h,
                                        color: AppColors.element,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(
                                          translate('like'),
                                          style: AppTextStyle.xSmall()
                                              .withColor(AppColors.element),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 40.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.likeIconS2,
                                        width: 20.w,
                                        height: 20.h,
                                        color: AppColors.textBlack,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(translate('like'),
                                            style: AppTextStyle.xSmall()),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    if (Global.storageService.permissionCounselCommentCreate())
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "/listCommentPostAdvise",
                              arguments: {
                                "id": post.id,
                              },
                            );
                          },
                          child: Container(
                            margin: Global.storageService
                                    .permissionCounselReactionCreate()
                                ? EdgeInsets.only(right: 40.w)
                                : EdgeInsets.only(left: 40.w),
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Image.asset(AppAssets.commentIconP),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(translate('comment'),
                                      style: AppTextStyle.xSmall()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          height: 5.h,
          color: AppColors.elementLight,
        ),
      ],
    ),
  );
}
