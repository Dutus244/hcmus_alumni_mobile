import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/group_create_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../global.dart';
import '../bloc/group_create_blocs.dart';
import '../bloc/group_create_events.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('create_group'),
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

Widget buttonCreate(BuildContext context) {
  String name = BlocProvider.of<GroupCreateBloc>(context).state.name;
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
    height: 40.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor:
        (name != "") ? AppColors.background : Colors.black.withOpacity(0.3),
        backgroundColor: (name != "") ? AppColors.element : AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
        side: BorderSide(
          color: AppColors.elementLight,
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        if (name != "" && !BlocProvider.of<GroupCreateBloc>(context).state.isLoading) {
          GroupCreateController(context: context).handleCreateGroup();
        }
      },
      child: Container(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate('create'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: (name != "")
                        ? AppColors.background
                        : Colors.black.withOpacity(0.3),
                  ),
                ),
                Container(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  "assets/icons/send.svg",
                  width: 15.w,
                  height: 15.h,
                  color: (name != "")
                      ? AppColors.background
                      : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildTextFieldName(BuildContext context, String hintText, String textType, String iconName,
    void Function(String value)? func) {
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
            child: TextField(
              onChanged: (value) => func!(value),
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
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldDescription(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func) {
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
              onChanged: (value) => func!(value),
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
                  color: AppColors.secondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
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
                    translate('choose_privacy'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header,
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
                      color: AppColors.textBlack,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('public'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            width: 270.w,
                            child: Text(
                              translate('public_description'),
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Radio(
                        value: 0,
                        groupValue: BlocProvider.of<GroupCreateBloc>(context)
                            .state
                            .privacy,
                        onChanged: (value) {
                          (context
                              .read<GroupCreateBloc>()
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
                      color: AppColors.textBlack,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('private'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                          Container(
                            width: 270.w,
                            child: Text(
                              translate('private_description'),
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.normal,
                                fontFamily: AppFonts.Header,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Radio(
                        value: 1,
                        groupValue: BlocProvider.of<GroupCreateBloc>(context)
                            .state
                            .privacy,
                        onChanged: (value) {
                          (context
                              .read<GroupCreateBloc>()
                              .add(PrivacyEvent(1)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
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
              BlocProvider.of<GroupCreateBloc>(context).state.privacy == 0
                  ? translate('public')
                  : translate('private'),
              style: TextStyle(
                color: AppColors.textBlack,
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/dropdown.svg",
              width: 12.w,
              height: 12.h,
              color: AppColors.textBlack,
            ),
          ],
        ),
      ),
    ),
  );
}

void deleteTag(BuildContext context, String tag) {
  List<String> currentList =
      BlocProvider.of<GroupCreateBloc>(context).state.tags;
  for (int i = 0; i < currentList.length; i += 1) {
    if (currentList[i] == tag) {
      currentList.removeAt(i);
      break;
    }
  }
  context.read<GroupCreateBloc>().add(TagsEvent(currentList));
}

void addTag(BuildContext context, String tag) {
  List<String> currentList =
      List.from(BlocProvider.of<GroupCreateBloc>(context).state.tags);
  currentList.add(tag);
  context.read<GroupCreateBloc>().add(TagsEvent(currentList));
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
            BlocProvider.of<GroupCreateBloc>(context).state.tags,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            inputFieldBuilder: (context, inputFieldValues) {
              inputFieldValues.tags = BlocProvider.of<GroupCreateBloc>(context).state.tags;
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
                                        style: TextStyle(
                                            fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppFonts.Header,
                                            color: Colors.white),
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
                    fontSize: 11.sp / MediaQuery.of(context).textScaleFactor, // Adjust the font size here
                  ),
                  onChanged: (value) {
                    inputFieldValues.onTagChanged(value);
                  },
                  onSubmitted: (value) {
                    if (BlocProvider.of<GroupCreateBloc>(context)
                        .state
                        .tags
                        .length >=
                        5) {
                      toastInfo(msg: translate('tag_above_5'));
                      return;
                    }
                    if (!BlocProvider.of<GroupCreateBloc>(context)
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

Widget header(BuildContext context) {
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
                color: AppColors.textBlack,
                fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.Header,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget groupCreate(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            header(context),
            buildTextFieldName(context, translate('your_group_name'), 'comment', '', (value) {
              context.read<GroupCreateBloc>().add(NameEvent(value));
            }),
            buildTextFieldDescription(context, translate('description_your_group'), 'comment', '',
                (value) {
              context.read<GroupCreateBloc>().add(DescriptionEvent(value));
            }),
            buildTextFieldPrivacy(context),
            buildTextFieldTag(context),
            choosePicture(context, (value) {
              context.read<GroupCreateBloc>().add(PicturesEvent(value));
            }),
          ],
        ),
      ),
      buttonCreate(context),
    ],
  );
}

void deletePicture(BuildContext context, int index) {
  List<File> currentList =
      BlocProvider.of<GroupCreateBloc>(context).state.pictures;
  currentList.removeAt(index);
  context.read<GroupCreateBloc>().add(PicturesEvent(currentList));
}

Widget choosePicture(
    BuildContext context, void Function(List<File> value)? func) {
  return Column(
    children: [
      if (BlocProvider.of<GroupCreateBloc>(context).state.pictures.length ==
          0)
        Container(
          margin: EdgeInsets.only(
              left: 100.w, top: 5.h, right: 100.w, bottom: 10.h),
          width: 160.w,
          height: 40.h,
          child: ElevatedButton(
            onPressed: () async {
              final pickedFiles = await ImagePicker().pickMultiImage();
              if (pickedFiles.length > 1) {
                toastInfo(msg: translate('picture_above_1'));
                return;
              }
              func!(pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.textBlack, backgroundColor: Color.fromARGB(255, 230, 230, 230),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.w),
                side: BorderSide(color: Colors.transparent),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Container(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                        style: AppTextStyle.small(context).wSemiBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      GestureDetector(
        onTap: () async {
          final pickedFiles = await ImagePicker().pickMultiImage();
          if (pickedFiles.length > 1) {
            toastInfo(msg: translate('picture_above_1'));
            return;
          }
          func!(pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
        },
        child: Column(
          children: [
            if (BlocProvider.of<GroupCreateBloc>(context).state.pictures.length ==
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
                        image: FileImage(BlocProvider.of<GroupCreateBloc>(context)
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
      )
    ],
  );
}