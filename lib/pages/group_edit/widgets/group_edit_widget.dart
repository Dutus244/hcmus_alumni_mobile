import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../global.dart';
import '../../../model/group.dart';
import '../bloc/group_edit_blocs.dart';
import '../bloc/group_edit_events.dart';
import '../group_edit_controller.dart';

AppBar buildAppBar(BuildContext context, Group group, int secondRoute) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
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
                "/groupManagement",
                    (route) => false,
                arguments: {
                  "group": group,
                  "secondRoute": secondRoute,
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.w),
              child: SizedBox(
                width: 25.w,
                height: 25.h,
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Text(
            'Chỉnh sửa nhóm',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header0,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.secondaryHeader,
            ),
          ),
          Container(
            width: 25.w,
            color: Colors.transparent,
            child: Row(
              children: [],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget buttonEdit(BuildContext context, Group group, int secondRoute) {
  String name = BlocProvider.of<GroupEditBloc>(context).state.name;
  return GestureDetector(
    onTap: () {
      if (name != "") {
        GroupEditController(context: context).handleEditGroup(group, secondRoute);
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: (name != "")
            ? AppColors.primaryElement
            : AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.primarySecondaryElement,
        ),
      ),
      child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lưu',
                  style: TextStyle(
                      fontFamily: AppFonts.Header1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: (name != "")
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
                  color: (name != "")
                      ? AppColors.primaryBackground
                      : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          )),
    ),
  );
}

Widget buildTextFieldName(BuildContext context, String hintText, String textType, String iconName,
    void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider
          .of<GroupEditBloc>(context)
          .state
          .name);


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

Widget buildTextFieldDescription(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider
          .of<GroupEditBloc>(context)
          .state
          .description);

  return Container(
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
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget choosePrivacy(BuildContext context) {
  return Container(
    height: 200.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'Chọn quyền riêng tư',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/earth.svg",
                      width: 11.w,
                      height: 13.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Công khai',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                          Container(
                            width: 270.w,
                            child: Text(
                              'Bất kỳ ai cũng có thể nhìn thấy mọi người trong nhóm và những gì họ đăng',
                              style: TextStyle(
                                color: AppColors.primarySecondaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 0,
                        groupValue: BlocProvider.of<GroupEditBloc>(context)
                            .state
                            .privacy,
                        onChanged: (value) {
                          (context
                              .read<GroupEditBloc>()
                              .add(PrivacyEvent(0)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/lock.svg",
                      width: 11.w,
                      height: 13.h,
                      color: AppColors.primaryText,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Riêng tư',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                          Container(
                            width: 270.w,
                            child: Text(
                              'Chỉ thành viên mới nhìn thấy mọi người trong nhóm và những gì họ đăng',
                              style: TextStyle(
                                color: AppColors.primarySecondaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 1,
                        groupValue: BlocProvider.of<GroupEditBloc>(context)
                            .state
                            .privacy,
                        onChanged: (value) {
                          (context
                              .read<GroupEditBloc>()
                              .add(PrivacyEvent(1)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 70.h,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextFieldPrivacy(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => choosePrivacy(context),
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 10.h),
      width: 340.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: AppColors.primaryFourthElementText,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              BlocProvider.of<GroupEditBloc>(context).state.privacy == 0
                  ? 'Công khai'
                  : 'Riêng tư',
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header3,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/dropdown.svg",
              width: 12.w,
              height: 12.h,
              color: AppColors.primaryText,
            ),
          ],
        ),
      ),
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

Widget groupEdit(BuildContext context, Group group, int secondRoute) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(),
            buildTextFieldName(context, 'Tên nhóm của bạn', 'comment', '', (value) {
              context.read<GroupEditBloc>().add(NameEvent(value));
            }),
            buildTextFieldDescription(context, 'Mô tả về nhóm của bạn', 'comment', '',
                    (value) {
                  context.read<GroupEditBloc>().add(DescriptionEvent(value));
                }),
            buildTextFieldPrivacy(context),
            choosePicture(context, (value) {
              context.read<GroupEditBloc>().add(PicturesEvent(value));
            }),
          ],
        ),
      ),
      buttonEdit(context, group, secondRoute),
    ],
  );
}

void deletePicture(BuildContext context, int index) {
  if (BlocProvider.of<GroupEditBloc>(context).state.networkPicture != "") {
    context.read<GroupEditBloc>().add(NetworkPictureEvent(""));
  }
  else {
    List<File> currentList =
        BlocProvider.of<GroupEditBloc>(context).state.pictures;
    currentList.removeAt(index);
    context.read<GroupEditBloc>().add(PicturesEvent(currentList));
  }
}

Widget choosePicture(
    BuildContext context, void Function(List<File> value)? func) {
  return GestureDetector(
      onTap: () async {
        final pickedFiles = await ImagePicker().pickMultiImage();
        if (pickedFiles.length > 1) {
          toastInfo(msg: "Chỉ được chọn tối đa 1 tấm ảnh");
          return;
        }
        context.read<GroupEditBloc>().add(NetworkPictureEvent(""));
        func!(pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
      },
      child: Column(
        children: [
          if (BlocProvider.of<GroupEditBloc>(context).state.networkPicture == '' && BlocProvider.of<GroupEditBloc>(context).state.pictures.length ==
              0)
            Container(
              width: 120.w,
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
                        'Chọn ảnh bìa',
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
          if (BlocProvider.of<GroupEditBloc>(context).state.networkPicture != '' || BlocProvider.of<GroupEditBloc>(context).state.pictures.length ==
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
                      image: BlocProvider.of<GroupEditBloc>(context).state.networkPicture != '' ? NetworkImage(BlocProvider.of<GroupEditBloc>(context).state.networkPicture) as ImageProvider<Object> : FileImage(BlocProvider.of<GroupEditBloc>(context)
                          .state
                          .pictures[0]) as ImageProvider<Object>,
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
      ));
}