import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/bloc/write_post_advise_blocs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../global.dart';
import '../bloc/write_post_advise_events.dart';
import '../write_post_advise_controller.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('create_post'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium().wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buttonSend(BuildContext context) {
  String title = BlocProvider.of<WritePostAdviseBloc>(context).state.title;
  String content = BlocProvider.of<WritePostAdviseBloc>(context).state.content;
  return GestureDetector(
    onTap: () {
      if (title != "" && content != "") {
        WritePostAdviseController(context: context).handlePost();
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
          color: AppColors.backgroundGrey,
        ),
      ),
      child: Center(
          child: Container(
        margin: EdgeInsets.only(left: 12.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translate('post'),
              style: AppTextStyle.base().wSemiBold().withColor(
                  (title != "" && content != "")
                      ? AppColors.background
                      : AppColors.textBlack.withOpacity(0.3)),
            ),
            Container(
              width: 6.w,
            ),
            SvgPicture.asset(
              "assets/icons/send.svg",
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
      context.read<WritePostAdviseBloc>().add(PageEvent(0));
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
              style: AppTextStyle.base().wSemiBold(),
            ),
            Container(
              width: 6.w,
            ),
            SvgPicture.asset(
              "assets/icons/send.svg",
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
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<WritePostAdviseBloc>(context).state.title);

  return Container(
      width: 320.w,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 300.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
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
                hintStyle: AppTextStyle.small()
                    .wSemiBold()
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small().wSemiBold(),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldContent(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<WritePostAdviseBloc>(context).state.content);

  return Container(
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
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              controller: _controller,
              keyboardType: TextInputType.multiline,
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
                hintStyle: AppTextStyle.small()
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldVote(BuildContext context, int index, String hintText,
    String textType, String iconName, void Function(List<String> value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<WritePostAdviseBloc>(context).state.votes[index]);

  return Container(
    margin: EdgeInsets.only(right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 310.w,
            margin: EdgeInsets.only(
                top: 5.h, left: 10.w, right: 10.w, bottom: 10.h),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                color: AppColors.primaryFourthElementText,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  width: 290.w,
                  child: TextField(
                    onTapOutside: (PointerDownEvent event) {
                      List<String> currentList =
                          BlocProvider.of<WritePostAdviseBloc>(context)
                              .state
                              .votes;
                      currentList[index] = _controller.text;
                      func!(currentList);
                    },
                    keyboardType: TextInputType.multiline,
                    controller: _controller,
                    maxLines: null,
                    // Cho phép đa dòng
                    decoration: InputDecoration(
                      hintText: '${translate('option_vote')} ${index + 1}',
                      contentPadding: EdgeInsets.zero,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintStyle: AppTextStyle.small()
                          .withColor(AppColors.secondaryElementText),
                      counterText: '',
                    ),
                    style: AppTextStyle.small(),
                    autocorrect: false,
                  ),
                ),
              ],
            )),
        GestureDetector(
          onTap: () {
            deleteVote(context, index);
          },
          child: SvgPicture.asset(
            "assets/icons/close.svg",
            width: 14.w,
            height: 14.h,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget writePost(BuildContext context) {
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
              context.read<WritePostAdviseBloc>().add(TitleEvent(value));
            }),
            buildTextFieldContent(context, translate('content_post'), 'comment', '',
                (value) {
              context.read<WritePostAdviseBloc>().add(ContentEvent(value));
            }),
            chooseVote(context),
            choosePicture(context, (value) {
              context.read<WritePostAdviseBloc>().add(PicturesEvent(value));
            }),
          ],
        ),
      ),
      buttonSend(context),
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
                  BlocProvider.of<WritePostAdviseBloc>(context)
                      .state
                      .pictures
                      .length;
              i += 1)
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  // Thay đổi tỷ lệ khung hình tùy theo yêu cầu của bạn
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                            BlocProvider.of<WritePostAdviseBloc>(context)
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
                          "assets/icons/close.svg",
                          width: 12.w,
                          height: 12.h,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          chooseEditPicture(context, (value) {
            context.read<WritePostAdviseBloc>().add(PicturesEvent(value));
          })
        ],
      )),
      buttonFinishEditPicture(context),
    ],
  );
}

Widget chooseEditPicture(
    BuildContext context, void Function(List<File> value)? func) {
  return GestureDetector(
    onTap: () async {
      List<File> currentList =
          BlocProvider.of<WritePostAdviseBloc>(context).state.pictures;

      final pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.length + currentList.length > 5) {
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
                "assets/icons/picture.svg",
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
  List<File> currentList =
      BlocProvider.of<WritePostAdviseBloc>(context).state.pictures;
  currentList.removeAt(index);
  context.read<WritePostAdviseBloc>().add(PicturesEvent(currentList));
}

void deleteVote(BuildContext context, int index) {
  List<String> currentList =
      BlocProvider.of<WritePostAdviseBloc>(context).state.votes;
  currentList.removeAt(index);
  context.read<WritePostAdviseBloc>().add(VotesEvent(currentList));
}

Widget choosePicture(
    BuildContext context, void Function(List<File> value)? func) {
  return GestureDetector(
      onTap: () async {
        if (BlocProvider.of<WritePostAdviseBloc>(context)
                .state
                .pictures
                .length ==
            0) {
          final pickedFiles = await ImagePicker().pickMultiImage();
          if (pickedFiles.length > 5) {
            toastInfo(msg: translate('picture_above_5'));
            return;
          }
          func!(
              pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
        } else {
          context.read<WritePostAdviseBloc>().add(PageEvent(1));
        }
      },
      child: Column(
        children: [
          if (BlocProvider.of<WritePostAdviseBloc>(context)
                  .state
                  .pictures
                  .length ==
              0)
            Container(
              width: 140.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.w),
                color: Color.fromARGB(255, 230, 230, 230),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/picture.svg",
                        width: 12.w,
                        height: 12.h,
                        color: AppColors.textBlack,
                      ),
                      Text(
                        translate('choose_picture'),
                        style: AppTextStyle.small().wSemiBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (BlocProvider.of<WritePostAdviseBloc>(context)
                  .state
                  .pictures
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
                      image: FileImage(
                          BlocProvider.of<WritePostAdviseBloc>(context)
                              .state
                              .pictures[0]),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        deletePicture(context, 0);
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
                          "assets/icons/close.svg",
                          width: 12.w,
                          height: 12.h,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          if (BlocProvider.of<WritePostAdviseBloc>(context)
                  .state
                  .pictures
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
                          image: FileImage(
                              BlocProvider.of<WritePostAdviseBloc>(context)
                                  .state
                                  .pictures[0]),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            deletePicture(context, 0);
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
                              "assets/icons/close.svg",
                              width: 12.w,
                              height: 12.h,
                              color: Colors.white,
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
                          image: FileImage(
                              BlocProvider.of<WritePostAdviseBloc>(context)
                                  .state
                                  .pictures[1]),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            deletePicture(context, 1);
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
                              "assets/icons/close.svg",
                              width: 12.w,
                              height: 12.h,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          if (BlocProvider.of<WritePostAdviseBloc>(context)
                  .state
                  .pictures
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
                          image: FileImage(
                              BlocProvider.of<WritePostAdviseBloc>(context)
                                  .state
                                  .pictures[0]),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            deletePicture(context, 0);
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
                              "assets/icons/close.svg",
                              width: 12.w,
                              height: 12.h,
                              color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[1]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 1);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[2]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 2);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
          if (BlocProvider.of<WritePostAdviseBloc>(context)
                  .state
                  .pictures
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[0]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 0);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[1]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 1);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[2]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 2);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[3]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 3);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
          if (BlocProvider.of<WritePostAdviseBloc>(context)
                  .state
                  .pictures
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[0]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 0);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[1]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 1);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[2]),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 2);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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
                                image: FileImage(
                                    BlocProvider.of<WritePostAdviseBloc>(
                                            context)
                                        .state
                                        .pictures[3]),
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
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header2,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.background,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  deletePicture(context, 3);
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
                                    "assets/icons/close.svg",
                                    width: 12.w,
                                    height: 12.h,
                                    color: Colors.white,
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

Widget chooseVote(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      if (BlocProvider.of<WritePostAdviseBloc>(context).state.votes.length == 0)
        GestureDetector(
          onTap: () {
            List<String> currentList = List<String>.from(
                BlocProvider.of<WritePostAdviseBloc>(context).state.votes);
            currentList.add('');
            context.read<WritePostAdviseBloc>().add(VotesEvent(currentList));
          },
          child: Container(
            margin: EdgeInsets.only(
                left: 110.w, top: 5.h, right: 110.w, bottom: 10.h),
            width: 140.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.w),
              color: Color.fromARGB(255, 230, 230, 230),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/vote.svg",
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.textBlack,
                    ),
                    Text(
                      translate('create_vote'),
                      style: AppTextStyle.small().wSemiBold(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      for (var i = 0;
          i < BlocProvider.of<WritePostAdviseBloc>(context).state.votes.length;
          i += 1)
        buildTextFieldVote(context, i, '', '', '', (value) {
          context.read<WritePostAdviseBloc>().add(VotesEvent(value));
        }),
      if (BlocProvider.of<WritePostAdviseBloc>(context).state.votes.length > 0)
        GestureDetector(
          onTap: () {
            if (BlocProvider.of<WritePostAdviseBloc>(context)
                    .state
                    .votes
                    .length >=
                10) {
              toastInfo(msg: translate('option_above_10'));
              return;
            }
            List<String> currentList = List<String>.from(
                BlocProvider.of<WritePostAdviseBloc>(context).state.votes);
            currentList.add('');
            context.read<WritePostAdviseBloc>().add(VotesEvent(currentList));
          },
          child: Container(
            width: 310.w,
            height: 35.h,
            margin: EdgeInsets.only(
                top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.w),
              border: Border.all(
                color: AppColors.primaryFourthElementText,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/add.svg",
                    width: 14.w,
                    height: 14.h,
                    color: AppColors.textGrey,
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Text(
                    translate('add_option'),
                    style: AppTextStyle.small().withColor(AppColors.textGrey),
                  ),
                ],
              ),
            ),
          ),
        ),
      if (BlocProvider.of<WritePostAdviseBloc>(context).state.votes.length > 0)
        allowAddOptions(context, (value) {
          context.read<WritePostAdviseBloc>().add(AllowAddOptionsEvent(value));
        }),
      if (BlocProvider.of<WritePostAdviseBloc>(context).state.votes.length > 0)
        allowMultipleVotes(context, (value) {
          context
              .read<WritePostAdviseBloc>()
              .add(AllowMultipleVotesEvent(value));
        })
    ],
  );
}

Widget allowAddOptions(BuildContext context, void Function(bool value)? func) {
  return Container(
    margin: EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h),
    width: 300.w,
    height: 30.h,
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 0.w, right: 10.w),
          child: Checkbox(
            checkColor: AppColors.background,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.element; // Selected color
                }
                return Colors.transparent; // Unselected color
              },
            ),
            onChanged: (value) => func!(value!),
            value: BlocProvider.of<WritePostAdviseBloc>(context)
                .state
                .allowAddOptions,
          ),
        ),
        Container(
          child: Text(
            translate('allow_people_add_option'),
            style: AppTextStyle.small().wSemiBold(),
          ),
        )
      ],
    ),
  );
}

Widget allowMultipleVotes(
    BuildContext context, void Function(bool value)? func) {
  return Container(
    margin: EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h, bottom: 10.h),
    width: 300.w,
    height: 30.h,
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 0.w, right: 10.w),
          child: Checkbox(
            checkColor: AppColors.background,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.element; // Selected color
                }
                return Colors.transparent; // Unselected color
              },
            ),
            onChanged: (value) => func!(value!),
            value: BlocProvider.of<WritePostAdviseBloc>(context)
                .state
                .allowMultipleVotes,
          ),
        ),
        Container(
          child: Text(
            translate('allow_people_choose_multiple'),
            style: AppTextStyle.small().wSemiBold(),
          ),
        )
      ],
    ),
  );
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
                    backgroundImage:
                        NetworkImage(Global.storageService.getUserAvatarUrl()),
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
      BlocProvider.of<WritePostAdviseBloc>(context).state.tags;
  for (int i = 0; i < currentList.length; i += 1) {
    if (currentList[i] == tag) {
      currentList.removeAt(i);
      break;
    }
  }
  context.read<WritePostAdviseBloc>().add(TagsEvent(currentList));
}

void addTag(BuildContext context, String tag) {
  List<String> currentList =
      List.from(BlocProvider.of<WritePostAdviseBloc>(context).state.tags);
  currentList.add(tag);
  context.read<WritePostAdviseBloc>().add(TagsEvent(currentList));
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
                BlocProvider.of<WritePostAdviseBloc>(context).state.tags,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            inputFieldBuilder: (context, inputFieldValues) {
              inputFieldValues.tags = BlocProvider.of<WritePostAdviseBloc>(context).state.tags;
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
                    contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
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
                        : "${translate('enter_#hashtag')}...",
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
                                              style: AppTextStyle.small().wSemiBold().withColor(AppColors.background),
                                            ),
                                            onTap: () {
                                              //print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
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
                  style: TextStyle(
                    fontSize: 11.sp, // Adjust the font size here
                  ),
                  onChanged: (value) {
                    inputFieldValues.onTagChanged(value);
                  },
                  onSubmitted: (value) {
                    if (BlocProvider.of<WritePostAdviseBloc>(context)
                            .state
                            .tags
                            .length >=
                        5) {
                      toastInfo(msg: translate('tag_above_5'));
                      return;
                    }
                    if (!BlocProvider.of<WritePostAdviseBloc>(context)
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
