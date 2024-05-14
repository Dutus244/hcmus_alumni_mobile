import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../bloc/edit_post_advise_blocs.dart';
import '../bloc/edit_post_advise_events.dart';
import '../edit_post_advise_controller.dart';

Widget navigation(void Function()? func1, String title, String content,
    void Function()? func2) {
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
                onTap: func1,
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              GestureDetector(
                onTap: (title != "" && content != "") ? func2 : () {},
                child: Container(
                  width: 80.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: (title != "" && content != "")
                        ? AppColors.primaryElement
                        : AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 12.w, right: 12.w),
                        child: Row(
                          children: [
                            Text(
                              'Lưu',
                              style: TextStyle(
                                  fontFamily: AppFonts.Header2,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: (title != "" && content != "")
                                      ? AppColors.primaryBackground
                                      : Colors.black.withOpacity(0.3)),
                            ),
                            Container(
                              width: 6.w,
                            ),
                            SvgPicture.asset(
                              "assets/icons/send.svg",
                              width: 15.w,
                              height: 15.h,
                              color: (title != "" && content != "")
                                  ? AppColors.primaryBackground
                                  : Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget navigationEditPicture(void Function()? func1, void Function()? func2) {
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
                onTap: func1,
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              GestureDetector(
                onTap: func2,
                child: Container(
                  width: 60.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Xong',
                              style: TextStyle(
                                  fontFamily: AppFonts.Header2,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBackground),
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildTextFieldTitle(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .title);

  return Container(
      width: 320.w,
      margin: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
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
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldContent(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .content);

  return GestureDetector(
    child: Container(
        width: 320.w,
        margin: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w, bottom: 2.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
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
                  hintStyle: TextStyle(
                    color: AppColors.primarySecondaryElementText,
                  ),
                  counterText: '',
                ),
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppFonts.Header3,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                ),
                autocorrect: false,
              ),
            )
          ],
        )),
  );
}

Widget writePost(BuildContext context, int route, String id) {
  TextEditingController controller = TextEditingController();
  controller.text = BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .title;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(),
            chooseTag(context, (value) {
              context.read<EditPostAdviseBloc>().add(TagsEvent(value));
            }),
            buildTextFieldTitle(context, 'Tiêu đề của bài viết', 'comment', '',
                    (value) {
                  context.read<EditPostAdviseBloc>().add(TitleEvent(value));
                }),
            buildTextFieldContent(context, 'Suy nghĩ của bạn', 'comment', '',
                    (value) {
                  context.read<EditPostAdviseBloc>().add(ContentEvent(value));
                }),
            choosePicture(context, (value) {
              context.read<EditPostAdviseBloc>().add(PicturesEvent(value));
            }),
          ],
        ),
      ),
      navigation(
              () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/applicationPage",
                  (route) => false,
              arguments: {
                "route": route,
                "secondRoute": 0,
              },
            );
          },
          BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .title,
          BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .content,
              () {
            EditPostAdviseController(context: context).handlePost(id);
          }),
    ],
  );
}

Widget editPicture(BuildContext context, int route) {
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
                      .pictureNetwork
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
                                    .pictureNetwork[i].pictureUrl),
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
                              color: Colors.grey,
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
                      // Thay đổi tỷ lệ khung hình tùy theo yêu cầu của bạn
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
                              color: Colors.grey,
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
                context.read<EditPostAdviseBloc>().add(PicturesEvent(value));
              })
            ],
          )),
      navigationEditPicture(() {
        context.read<EditPostAdviseBloc>().add(PageEvent(0));
      }, () {
        context.read<EditPostAdviseBloc>().add(PageEvent(0));
      }),
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
      if (pickedFiles != null) {
        if (pickedFiles.length + currentList.length + BlocProvider
            .of<EditPostAdviseBloc>(context)
            .state
            .pictureNetwork
            .length > 5) {
          toastInfo(msg: "Chỉ được chọn tối đa 5 tấm ảnh");
          return;
        }
        currentList.addAll(pickedFiles.map((pickedFile) =>
            File(pickedFile.path))); // Concatenate currentList and picked files

        func!(currentList);
      }
    },
    child: Container(
      width: 340.w,
      height: 40.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.w),
        color: AppColors.primaryBackground,
        border: Border.all(color: AppColors.primaryElement),
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
                color: AppColors.primaryElement,
              ),
              Container(
                width: 5.w,
              ),
              Text(
                'Thêm ảnh',
                style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryElement),
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
      .pictureNetwork);
  Picture remove = currentList.removeAt(index);
  List<String> removeList = List.from(BlocProvider
      .of<EditPostAdviseBloc>(context)
      .state
      .deletePictures);
  removeList.add(remove.id);
  context.read<EditPostAdviseBloc>().add(DeletePicturesEvent(removeList));
  context.read<EditPostAdviseBloc>().add(PictureNetworkEvent(currentList));
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
                .pictureNetwork
                .length ==
            0) {
          final pickedFiles = await ImagePicker().pickMultiImage();
          if (pickedFiles != null) {
            if (pickedFiles.length +
                BlocProvider
                    .of<EditPostAdviseBloc>(context)
                    .state
                    .pictureNetwork
                    .length > 5) {
              toastInfo(msg: "Chỉ được chọn tối đa 5 tấm ảnh");
              return;
            }
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
          }
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
                  .pictureNetwork
                  .length ==
              0)
            Container(
              width: 340.w,
              height: 240.h,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: AppColors.primaryFourthElementText,
                ),
              ),
              child: Center(
                child: Container(
                  width: 100.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.w),
                    color: AppColors.primaryElement,
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
                            "assets/icons/picture.svg",
                            width: 12.w,
                            height: 12.h,
                            color: AppColors.primaryBackground,
                          ),
                          Text(
                            'Chọn ảnh',
                            style: TextStyle(
                                fontFamily: AppFonts.Header1,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBackground),
                          ),
                        ],
                      ),
                    ),
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
                  .pictureNetwork
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
                          .pictureNetwork
                          .length >
                          0
                          ? NetworkImage(
                          BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetwork[0]
                              .pictureUrl) as ImageProvider<Object>
                          : FileImage(BlocProvider
                          .of<EditPostAdviseBloc>(context)
                          .state
                          .pictures[
                      0 -
                          BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetwork
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
                            .pictureNetwork
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
                                      .pictureNetwork
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
                          color: Colors.grey,
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
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetwork
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
                              .pictureNetwork
                              .length >
                              0
                              ? NetworkImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetwork[0]
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
                                      .pictureNetwork
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
                                .pictureNetwork
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
                                          .pictureNetwork
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
                              color: Colors.grey,
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
                          image: BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictureNetwork
                              .length >
                              1
                              ? NetworkImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetwork[1]
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
                                      .pictureNetwork
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
                                .pictureNetwork
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
                                          .pictureNetwork
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
                              color: Colors.grey,
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
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetwork
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
                              .pictureNetwork
                              .length >
                              0
                              ? NetworkImage(
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetwork[0]
                                  .pictureUrl) as ImageProvider<Object>
                              : FileImage(BlocProvider
                              .of<EditPostAdviseBloc>(context)
                              .state
                              .pictures[
                          0 -
                              BlocProvider
                                  .of<EditPostAdviseBloc>(context)
                                  .state
                                  .pictureNetwork
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
                                .pictureNetwork
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
                                          .pictureNetwork
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
                              color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    1
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[1]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                1 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    2
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[2]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                2 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetwork
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
                                    .pictureNetwork
                                    .length >
                                    0
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[0]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                0 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    1
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[1]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                1 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    2
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[2]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                2 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    3
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[3]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                3 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
          if (BlocProvider
              .of<EditPostAdviseBloc>(context)
              .state
              .pictures
              .length +
              BlocProvider
                  .of<EditPostAdviseBloc>(context)
                  .state
                  .pictureNetwork
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
                                    .pictureNetwork
                                    .length >
                                    0
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[0]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                0 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    1
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[1]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                1 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    2
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[2]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                2 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                                image: BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictureNetwork
                                    .length >
                                    3
                                    ? NetworkImage(
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork[3]
                                        .pictureUrl) as ImageProvider<Object>
                                    : FileImage(BlocProvider
                                    .of<EditPostAdviseBloc>(context)
                                    .state
                                    .pictures[
                                3 -
                                    BlocProvider
                                        .of<EditPostAdviseBloc>(context)
                                        .state
                                        .pictureNetwork
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
                                  style: TextStyle(
                                    fontFamily: AppFonts.Header2,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBackground,
                                  ),
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
                                      .pictureNetwork
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
                                                .pictureNetwork
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
                                    color: Colors.grey,
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
                    backgroundImage: AssetImage("assets/images/test1.png"),
                  )),
            ),
            Text(
              'Đặng Nguyễn Duy',
              maxLines: 1,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.Header2,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget chooseTag(BuildContext context,
    void Function(List<String> value)? func) {
  List<String> selectedValues = [];

  // Convert selectedValues to ValueItem
  List<ValueItem> initialSelectedItems = [
    ValueItem(label: 'Cựu sinh viên', value: '1'),
    ValueItem(label: 'Trường học', value: '2'),
    ValueItem(label: 'Cộng đồng', value: '3'),
    ValueItem(label: 'Khởi nghiệp', value: '4'),
    ValueItem(label: 'Nghề nghiệp', value: '5'),
    ValueItem(label: 'Học tập', value: '6'),
    ValueItem(label: 'Việc làm', value: '7'),
  ]
      .where((item) =>
      BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .tags
          .contains(item.value))
      .toList();

  return Container(
    height: 35.h,
    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
    child: MultiSelectDropDown(
      selectedOptions:
      BlocProvider
          .of<EditPostAdviseBloc>(context)
          .state
          .itemTags,
      onOptionSelected: (List<ValueItem> selectedOptions) {
        selectedValues =
            selectedOptions.map((option) => option.value.toString()).toList();
        if (func != null) {
          func(selectedValues);
        }
      },
      options: const <ValueItem>[
        ValueItem(label: 'Cựu sinh viên', value: '1'),
        ValueItem(label: 'Trường học', value: '2'),
        ValueItem(label: 'Cộng đồng', value: '3'),
        ValueItem(label: 'Khởi nghiệp', value: '4'),
        ValueItem(label: 'Nghề nghiệp', value: '5'),
        ValueItem(label: 'Học tập', value: '6'),
        ValueItem(label: 'Việc làm', value: '7'),
      ],
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.scroll),
      dropdownHeight: 300,
      optionTextStyle: const TextStyle(
        color: AppColors.primaryText,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.Header2,
      ),
      hintStyle: const TextStyle(
        fontSize: 12,
        fontFamily: AppFonts.Header2,
      ),
      selectedOptionIcon: const Icon(
        Icons.check_circle,
        color: AppColors.primaryElement,
      ),
      hint: 'Chọn thẻ',
    ),
  );
}
