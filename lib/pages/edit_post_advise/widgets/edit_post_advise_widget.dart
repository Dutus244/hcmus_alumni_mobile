import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/common/widgets/loading_widget.dart';
import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../global.dart';
import '../../../model/post.dart';
import '../bloc/edit_post_advise_blocs.dart';
import '../bloc/edit_post_advise_events.dart';
import '../edit_post_advise_controller.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets
            .only(top: 40.h),
        child: Text(
          translate('edit_post'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buttonEdit(BuildContext context, String id) {
  String title = BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .title;
  String content = BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .content;
  return GestureDetector(
    onTap: () {
      if (title != "" && content != "") {
        EditPostAdviseController(context: context).handlePost(id);
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: (title != "" && content != "")
            ? AppColors.element
            : AppColors.background,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
        ),
      ),
      child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate('save'),
                  style: AppTextStyle.base().wSemiBold().withColor(
                      (title != "" && content != "")
                          ? AppColors.background
                          : Colors.black.withOpacity(0.3)),
                ),
                Container(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  AppAssets.sendIconS,
                  width: 15.w,
                  height: 15.h,
                  color: (title != "" && content != "")
                      ? AppColors.background
                      : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          )),
    ),
  );
}

Widget buttonFinishEditPicture(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.read<EditPostAdviseBloc>().add(PageEvent(0));
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColors.element,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
        ),
      ),
      child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate('save'),
                  style: AppTextStyle.base().wSemiBold().withColor(
                      AppColors.background),
                ),
                Container(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  AppAssets.sendIconS,
                  width: 15.w,
                  height: 15.h,
                  color: AppColors.background,
                ),
              ],
            ),
          )),
    ),
  );
}

Widget buildTextFieldTitle(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 320.w,
      margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 300.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .title,
              maxLines: null,
              // Cho phép đa dòng
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
                hintStyle: AppTextStyle.small().withColor(
                    AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldContent(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  print(BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .content);
  return GestureDetector(
    child: Container(
        width: 320.w,
        margin: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w, bottom: 2.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Container(
              width: 300.w,
              child: TextFormField(
                onChanged: (value) {
                  func!(value);
                },
                keyboardType: TextInputType.multiline,
                initialValue: BlocProvider
                    .of<EditPostAdviseBloc>(context)
                    .state
                    .content,
                maxLines: null,
                // Cho phép đa dòng
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
                  hintStyle: AppTextStyle.small().withColor(
                      AppColors.secondaryElementText),
                  counterText: '',
                ),
                style: AppTextStyle.small(),
                autocorrect: false,
              ),
            )
          ],
        )),
  );
}

Widget writePost(BuildContext context, Post? post) {
  if (post == null) {
    return loadingWidget();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(),
            buildTextFieldTag(context),
            buildTextFieldTitle(context, translate('title_post'), 'comment', '',
                    (value) {
                  context.read<EditPostAdviseBloc>().add(TitleEvent(value));
                }),
            buildTextFieldContent(
                context, translate('content_post'), 'comment', '',
                    (value) {
                  context.read<EditPostAdviseBloc>().add(ContentEvent(value));
                }),
            choosePicture(context, (value) {
              context.read<EditPostAdviseBloc>().add(PicturesEvent(value));
            }),
          ],
        ),
      ),
      buttonEdit(context, post.id),
    ],
  );
}

Widget editPicture(BuildContext context) {
  return Column(
    children: [
      Expanded(
          child: ListView(
            children: [
              for (int i = 0;
              i <
                  BlocProvider
                      .of<EditPostAdviseBloc>(context)
                      .state
                      .pictureNetworks
                      .length;
              i += 1)
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      // Thay đổi tỷ lệ khung hình tùy theo yêu cầu của bạn
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.w, top: 5.h, right: 10.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks[i].pictureUrl),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            deletePictureNetwork(context, i);
                          },
                          child: Container(
                            margin:
                            EdgeInsets.only(left: 15.w, top: 8.h, right: 15.w),
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundGrey,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.closeIconS,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.textBlack,
                            ),
                          ),
                        )),
                  ],
                ),
              for (int i = 0;
              i <
                  BlocProvider
                      .of<EditPostAdviseBloc>(context)
                      .state
                      .pictures
                      .length;
              i += 1)
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.w, top: 5.h, right: 10.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                                BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[i]),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            deletePicture(context, i);
                          },
                          child: Container(
                            margin:
                            EdgeInsets.only(left: 15.w, top: 8.h, right: 15.w),
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundGrey,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.closeIconS,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.textBlack,
                            ),
                          ),
                        )),
                  ],
                ),
              chooseEditPicture(context, (value) {
                context.read<EditPostAdviseBloc>().add(PicturesEvent(value));
              })
            ],
          )),
      buttonFinishEditPicture(context),
    ],
  );
}

Widget chooseEditPicture(BuildContext context,
    void Function(List<File> value)? func) {
  return GestureDetector(
    onTap: () async {
      List<File> currentList = List.from(BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .pictures);

      final pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.length + currentList.length + BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .pictureNetworks
          .length > 5) {
        toastInfo(msg: translate('picture_above_5'));
        return;
      }
      currentList.addAll(pickedFiles.map((pickedFile) =>
          File(pickedFile.path))); // Concatenate currentList and picked files

      func!(currentList);
    },
    child: Container(
      width: 340.w,
      height: 40.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.w),
        color: AppColors.background,
        border: Border.all(color: AppColors.element),
      ),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.pictureIconS,
                width: 12.w,
                height: 12.h,
                color: AppColors.element,
              ),
              Container(
                width: 5.w,
              ),
              Text(
                translate('add_picture'),
                style: AppTextStyle.small().wSemiBold().withColor(
                    AppColors.element),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void deletePicture(BuildContext context, int index) {
  List<File> currentList = List.from(
      BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .pictures);
  currentList.removeAt(index);
  context.read<EditPostAdviseBloc>().add(PicturesEvent(currentList));
}

void deletePictureNetwork(BuildContext context, int index) {
  List<Picture> currentList = List.from(BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .pictureNetworks);
  Picture remove = currentList.removeAt(index);
  List<String> removeList = List.from(BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .deletePictures);
  removeList.add(remove.id);
  context.read<EditPostAdviseBloc>().add(DeletePicturesEvent(removeList));
  context.read<EditPostAdviseBloc>().add(PictureNetworksEvent(currentList));
}

Widget choosePicture(BuildContext context,
    void Function(List<File> value)? func) {
  return GestureDetector(
      onTap: () async {
        if (BlocProvider
            .of<EditPostAdviseBloc>(context)
            .state
            .pictures
            .length +
            BlocProvider
                .of<EditPostAdviseBloc>(context)
                .state
                .pictureNetworks
                .length ==
            0) {
          final pickedFiles = await ImagePicker().pickMultiImage();
          if (pickedFiles.length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length > 5) {
            toastInfo(msg: translate('picture_above_5'));
            return;
          }
          func!(pickedFiles
              .map((pickedFile) => File(pickedFile.path))
              .toList());
        } else {
          context.read<EditPostAdviseBloc>().add(PageEvent(1));
        }
      },
      child: Column(
        children: [
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length ==
              0)
            Container(
              width: 160.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.w),
                color: AppColors.element,
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        AppAssets.pictureIconS,
                        width: 12.w,
                        height: 12.h,
                        color: AppColors.background,
                      ),
                      Text(
                        translate('choose_picture'),
                        style: AppTextStyle.small().wSemiBold().withColor(
                            AppColors.background),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length ==
              1)
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
                  width: 340.w,
                  height: 240.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: BlocProvider
                          .of<EditPostAdviseBloc>(context)
                          .state
                          .pictureNetworks
                          .length >
                          0
                          ? NetworkImage(
                          BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetworks[0]
                              .pictureUrl) as ImageProvider<Object>
                          : FileImage(BlocProvider
                          .of<EditPostAdviseBloc>(context)
                          .state
                          .pictures[
                      0 -
                          BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetworks
                              .length]) as ImageProvider<Object>,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (BlocProvider
                            .of<EditPostAdviseBloc>(context)
                            .state
                            .pictureNetworks
                            .length >
                            0) {
                          deletePictureNetwork(context, 0);
                        } else {
                          deletePicture(
                              context,
                              0 -
                                  BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length);
                        }
                      },
                      child: Container(
                        margin:
                        EdgeInsets.only(left: 15.w, top: 8.h, right: 15.w),
                        padding: EdgeInsets.only(
                            left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.backgroundGrey,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.closeIconS,
                          width: 12.w,
                          height: 12.h,
                          color: AppColors.background,
                        ),
                      ),
                    )),
              ],
            ),
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length ==
              2)
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
                      width: 340.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetworks
                              .length >
                              0
                              ? NetworkImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetworks[0]
                                  .pictureUrl) as ImageProvider<Object>
                              : FileImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictures[
                              0 -
                                  BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length]) as ImageProvider<Object>,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (BlocProvider
                                .of<EditPostAdviseBloc>(context)
                                .state
                                .pictureNetworks
                                .length >
                                0) {
                              deletePictureNetwork(context, 0);
                            } else {
                              deletePicture(
                                  context,
                                  0 -
                                      BlocProvider
                                          .of<EditPostAdviseBloc>(
                                          context)
                                          .state
                                          .pictureNetworks
                                          .length);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15.w, top: 8.h, right: 15.w),
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundGrey,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.closeIconS,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.background,
                            ),
                          ),
                        )),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      width: 340.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetworks
                              .length >
                              1
                              ? NetworkImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetworks[1]
                                  .pictureUrl) as ImageProvider<Object>
                              : FileImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictures[
                              1 -
                                  BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length]) as ImageProvider<Object>,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (BlocProvider
                                .of<EditPostAdviseBloc>(context)
                                .state
                                .pictureNetworks
                                .length >
                                1) {
                              deletePictureNetwork(context, 1);
                            } else {
                              deletePicture(
                                  context,
                                  1 -
                                      BlocProvider
                                          .of<EditPostAdviseBloc>(
                                          context)
                                          .state
                                          .pictureNetworks
                                          .length);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15.w, top: 8.h, right: 15.w),
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundGrey,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.closeIconS,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.background,
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length ==
              3)
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
                      width: 340.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetworks
                              .length >
                              0
                              ? NetworkImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetworks[0]
                                  .pictureUrl) as ImageProvider<Object>
                              : FileImage(BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictures[
                          0 -
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetworks
                                  .length]) as ImageProvider<Object>,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (BlocProvider
                                .of<EditPostAdviseBloc>(context)
                                .state
                                .pictureNetworks
                                .length >
                                0) {
                              deletePictureNetwork(context, 0);
                            } else {
                              deletePicture(
                                  context,
                                  0 -
                                      BlocProvider
                                          .of<EditPostAdviseBloc>(context)
                                          .state
                                          .pictureNetworks
                                          .length);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15.w, top: 8.h, right: 15.w),
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundGrey,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.closeIconS,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.background,
                            ),
                          ),
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 170.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    1
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[1]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                1 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      1) {
                                    deletePictureNetwork(context, 1);
                                  } else {
                                    deletePicture(
                                        context,
                                        1 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    2
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[2]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                2 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      2) {
                                    deletePictureNetwork(context, 2);
                                  } else {
                                    deletePicture(
                                        context,
                                        2 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length ==
              4)
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 170.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    0
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[0]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                0 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      0) {
                                    deletePictureNetwork(context, 0);
                                  } else {
                                    deletePicture(
                                        context,
                                        0 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    1
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[1]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                1 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      1) {
                                    deletePictureNetwork(context, 1);
                                  } else {
                                    deletePicture(
                                        context,
                                        1 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 170.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    2
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[2]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                2 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      2) {
                                    deletePictureNetwork(context, 2);
                                  } else {
                                    deletePicture(
                                        context,
                                        2 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    3
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[3]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                3 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      3) {
                                    deletePictureNetwork(context, 3);
                                  } else {
                                    deletePicture(
                                        context,
                                        3 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetworks
                  .length ==
              5)
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 170.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    0
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[0]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                0 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      0) {
                                    deletePictureNetwork(context, 0);
                                  } else {
                                    deletePicture(
                                        context,
                                        0 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    1
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[1]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                1 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      1) {
                                    deletePictureNetwork(context, 1);
                                  } else {
                                    deletePicture(
                                        context,
                                        1 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 170.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    2
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[2]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                2 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      2) {
                                    deletePictureNetwork(context, 2);
                                  } else {
                                    deletePicture(
                                        context,
                                        2 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetworks
                                    .length >
                                    3
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks[3]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                3 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetworks
                                        .length]) as ImageProvider<Object>,
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
                                color: Color.fromARGB(255, 24, 59, 86)
                                    .withOpacity(0.5),
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
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (BlocProvider
                                      .of<EditPostAdviseBloc>(context)
                                      .state
                                      .pictureNetworks
                                      .length >
                                      3) {
                                    deletePictureNetwork(context, 3);
                                  } else {
                                    deletePicture(
                                        context,
                                        3 -
                                            BlocProvider
                                                .of<EditPostAdviseBloc>(context)
                                                .state
                                                .pictureNetworks
                                                .length);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.closeIconS,
                                    width: 12.w,
                                    height: 12.h,
                                    color: AppColors.background,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ));
}

Widget header() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 5.h),
        child: Row(
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              child: GestureDetector(
                  onTap: () {
                    // Xử lý khi người dùng tap vào hình ảnh
                  },
                  child: CircleAvatar(
                    radius: 10,
                    child: null,
                    backgroundImage: NetworkImage(
                        Global.storageService.getUserAvatarUrl()),
                  )),
            ),
            Text(
              Global.storageService.getUserFullName(),
              maxLines: 1,
              style: AppTextStyle.small().wSemiBold(),
            ),
          ],
        ),
      ),
    ],
  );
}

void deleteTag(BuildContext context, String tag) {
  List<String> currentList =
      BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .tags;
  for (int i = 0; i < currentList.length; i += 1) {
    if (currentList[i] == tag) {
      currentList.removeAt(i);
      break;
    }
  }
  context.read<EditPostAdviseBloc>().add(TagsEvent(currentList));
}

void addTag(BuildContext context, String tag) {
  List<String> currentList =
  List.from(BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .tags);
  currentList.add(tag);
  context.read<EditPostAdviseBloc>().add(TagsEvent(currentList));
}

Widget buildTextFieldTag(BuildContext context) {
  TextfieldTagsController<String> _stringTagController =
  TextfieldTagsController<String>();

  return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        children: [
          TextFieldTags<String>(
            textfieldTagsController: _stringTagController,
            initialTags:
            BlocProvider
                .of<EditPostAdviseBloc>(context)
                .state
                .tags,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            inputFieldBuilder: (context, inputFieldValues) {
              inputFieldValues.tags = BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .tags;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: TextField(
                  onTap: () {
                    _stringTagController.getFocusNode?.requestFocus();
                  },
                  controller: inputFieldValues.textEditingController,
                  focusNode: inputFieldValues.focusNode,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 13, horizontal: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryFourthElementText,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryFourthElementText,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    helperStyle: const TextStyle(
                      color: AppColors.elementLight,
                    ),
                    hintText: inputFieldValues.tags.isNotEmpty
                        ? ''
                        : "${translate("enter_#hashtag")}...",
                    errorText: inputFieldValues.error,
                    prefixIconConstraints:
                    BoxConstraints(maxWidth: 300.w * 0.8),
                    prefixIcon: inputFieldValues.tags.isNotEmpty
                        ? SingleChildScrollView(
                      controller: inputFieldValues.tagScrollController,
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 8,
                        ),
                        child: Wrap(
                            runSpacing: 4.0,
                            spacing: 4.0,
                            children:
                            inputFieldValues.tags.map((String tag) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: AppColors.element,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      child: Text(
                                          '#$tag',
                                          style: AppTextStyle.small()
                                              .wSemiBold()
                                              .withColor(
                                              AppColors.background)),
                                      onTap: () {
                                        //print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color: AppColors.background,
                                      ),
                                      onTap: () {
                                        inputFieldValues
                                            .onTagRemoved(tag);
                                        deleteTag(context, tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                      ),
                    )
                        : null,
                  ),
                  style: AppTextStyle.small(),
                  onChanged: (value) {
                    inputFieldValues.onTagChanged(value);
                  },
                  onSubmitted: (value) {
                    if (BlocProvider
                        .of<EditPostAdviseBloc>(context)
                        .state
                        .tags
                        .length >=
                        5) {
                      toastInfo(msg: translate('tag_above_5'));
                      return;
                    }
                    if (!BlocProvider
                        .of<EditPostAdviseBloc>(context)
                        .state
                        .tags
                        .contains(value)) {
                      inputFieldValues.onTagSubmitted(value);
                      addTag(context, value);
                    } else {
                      // Optionally, show a message to the user about the duplicate tag
                      toastInfo(msg: translate('duplicate_tag'));
                    }
                  },
                ),
              );
            },
          ),
        ],
      ));
}
