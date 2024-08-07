import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/model/achievement.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import 'package:hcmus_alumni_mobile/model/job.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/bloc/my_profile_edit_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/my_profile_edit_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../model/user.dart';
import '../bloc/my_profile_edit_events.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('edit_personal_information'),
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

Widget myProfileEdit(BuildContext context, User? user) {
  if (user == null) {
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
          editAvatar(context, (value) {
            context.read<MyProfileEditBloc>().add(AvatarEvent(value));
          }),
          editCover(context, (value) {
            context.read<MyProfileEditBloc>().add(CoverEvent(value));
          }),
          editProfile(context),
          editContact(context),
          editAboutMe(context),
          editAlumni(context),
          editJob(context),
          editEducation(context),
          editAchievement(context),
        ],
      )),
    ],
  );
}

Widget editAvatar(BuildContext context, void Function(List<File> value)? func) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('avatar'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
                  return;
                }
                final pickedFiles = await ImagePicker().pickMultiImage();
                if (pickedFiles.length > 1) {
                  toastInfo(msg: translate('picture_above_1'));
                  return;
                }
                context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
                func!(pickedFiles
                    .map((pickedFile) => File(pickedFile.path))
                    .toList());
                MyProfileEditController(context: context).handleChangeAvatar(File(pickedFiles[0].path));
              },
              child: Text(
                translate('edit'),
                style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                  color: AppColors.element,
                ),
              ),
            )
          ],
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkAvatar != "")
        GestureDetector(
          onTap: () async {
            if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
              return;
            }
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: translate('picture_above_1'));
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
            MyProfileEditController(context: context).handleChangeAvatar(File(pickedFiles[0].path));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Center(
              child: CircleAvatar(
                radius: 65.w, // Đặt bán kính của CircleAvatar
                backgroundImage: NetworkImage(
                    BlocProvider.of<MyProfileEditBloc>(context)
                        .state
                        .networkAvatar), // URL hình ảnh của CircleAvatar
              ),
            ),
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.avatar.length != 0)
        GestureDetector(
          onTap: () async {
            if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
              return;
            }
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: translate('picture_above_1'));
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
            MyProfileEditController(context: context).handleChangeAvatar(File(pickedFiles[0].path));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Center(
              child: CircleAvatar(
                radius: 65.w, // Đặt bán kính của CircleAvatar
                backgroundImage: FileImage(
                    BlocProvider.of<MyProfileEditBloc>(context).state.avatar[0] ??
                        File('')), // URL hình ảnh của CircleAvatar
              ),
            ),
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkAvatar ==
              "" &&
          BlocProvider.of<MyProfileEditBloc>(context).state.avatar.length == 0)
        GestureDetector(
          onTap: () async {
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: translate('picture_above_1'));
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
            MyProfileEditController(context: context).handleChangeAvatar(File(pickedFiles[0].path));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Center(
              child: CircleAvatar(
                radius: 65.w, // Đặt bán kính của CircleAvatar
                backgroundImage: AssetImage(
                    "assets/images/avatar/none_avatar.png"), // URL hình ảnh của CircleAvatar
              ),
            ),
          ),
        )
    ],
  );
}

Future<void> _loadPicker(BuildContext context, ImageSource source,
    void Function(File value)? func) async {
  final picked = await ImagePicker().pickImage(source: source);
  if (picked != null) {
    File pickedFile = File(picked.path);
    _cropImage(context, pickedFile,
        func); // Pass the context and picked file to _cropImage
  }
  Navigator.pop(context); // Close the dialog after picking an image
}

Future<void> _cropImage(
    BuildContext context, File picked, void Function(File value)? func) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: picked.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    cropStyle: CropStyle.circle,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: translate('copper'),
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: translate('copper'),
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  if (croppedFile != null) {
    // Convert CroppedFile to File if it has a path property
    File croppedFileAsFile = File(croppedFile.path);

    // Dispatch event with the cropped file
    func!(croppedFileAsFile);
    print("hello");
    MyProfileEditController(context: context).handleChangeAvatar(croppedFileAsFile);
  }
}

void _showPickOptionsDialog(
    BuildContext context, void Function(File value)? func) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(translate('choose_from_library')),
            onTap: () {
              _loadPicker(context, ImageSource.gallery,
                  func); // Pass context to _loadPicker
            },
          ),
          ListTile(
            title: Text(translate('take_photo')),
            onTap: () {
              _loadPicker(context, ImageSource.camera,
                  func); // Pass context to _loadPicker
            },
          )
        ],
      ),
    ),
  );
}

Widget editCover(BuildContext context, void Function(List<File> value)? func) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('cover'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
                  return;
                }
                final pickedFiles = await ImagePicker().pickMultiImage();
                if (pickedFiles.length > 1) {
                  toastInfo(msg: translate('picture_above_1'));
                  return;
                }
                context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
                func!(pickedFiles
                    .map((pickedFile) => File(pickedFile.path))
                    .toList());
                MyProfileEditController(context: context).handleChangeCover(File(pickedFiles[0].path));
              },
              child: Text(
                translate('edit'),
                style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                  color: AppColors.element,
                ),
              ),
            )
          ],
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkCover != '')
        GestureDetector(
          onTap: () async {
            if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
              return;
            }
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: translate('picture_above_1'));
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
            MyProfileEditController(context: context).handleChangeCover(File(pickedFiles[0].path));
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(BlocProvider.of<MyProfileEditBloc>(context)
                    .state
                    .networkCover),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.w),
            ),
            height: 180.h,
            width: double.infinity,
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.cover.length > 0)
        GestureDetector(
          onTap: () async {
            if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
              return;
            }
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: translate('picture_above_1'));
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
            MyProfileEditController(context: context).handleChangeCover(File(pickedFiles[0].path));
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                    BlocProvider.of<MyProfileEditBloc>(context).state.cover[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.w),
            ),
            height: 180.h,
            width: double.infinity,
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkCover ==
              '' &&
          BlocProvider.of<MyProfileEditBloc>(context).state.cover.length == 0)
        GestureDetector(
          onTap: () async {
            if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
              return;
            }
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: translate('picture_above_1'));
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
            MyProfileEditController(context: context).handleChangeCover(File(pickedFiles[0].path));
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.w),
            ),
            height: 180.h,
            width: double.infinity,
            child: Center(
              child: Text(
                translate('add_cover'),
                style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

Widget editProfile(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('basic_information'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/user.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldFullName(context, translate('full_name'), '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(FullNameEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('full_name'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => chooseSex(context),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              BlocProvider.of<MyProfileEditBloc>(context).state.sex == "Nam"
                  ? SvgPicture.asset(
                      "assets/icons/men.svg",
                      width: 25.w,
                      height: 25.h,
                      color: Colors.black,
                    )
                  : SvgPicture.asset(
                      "assets/icons/women.svg",
                      width: 25.w,
                      height: 25.h,
                      color: Colors.black,
                    ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: 232.w,
                    child: Text(
                      BlocProvider.of<MyProfileEditBloc>(context).state.sex,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      translate('sex'),
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                        color: AppColors.secondaryElementText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => chooseBirthday(context),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/calendar.svg",
                width: 25.w,
                height: 25.h,
                color: Colors.black,
              ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 232.w,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      BlocProvider.of<MyProfileEditBloc>(context)
                                  .state
                                  .dob !=
                              ""
                          ? BlocProvider.of<MyProfileEditBloc>(context)
                              .state
                              .dob
                          : translate('birthday'),
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      translate('birthday'),
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                        color: AppColors.secondaryElementText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/social_network.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldSocialLink(
                    context, translate('social_network'), '', '', (value) {
                  context.read<MyProfileEditBloc>().add(SocialLinkEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('social_network'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldClass(context, translate('class'), '', '', (value) {
                  context.read<MyProfileEditBloc>().add(ClasssEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('class'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldEndYear(
                    context, translate('graduation_year'), '', '', (value) {
                  context.read<MyProfileEditBloc>().add(EndYearEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('graduation_year'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget editContact(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('contact_info'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/email.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    BlocProvider.of<MyProfileEditBloc>(context)
                        .state
                        .email,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('email'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/phone.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldPhoneNumber(context, translate('phone'), '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(PhoneEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('phone'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget editAboutMe(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('about_me'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      buildTextFieldAboutMe(context, translate('describe_yourself'), '', '',
          (value) {
        context.read<MyProfileEditBloc>().add(AboutMeEvent(value));
      }),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        height: 40.h,
        child: ElevatedButton(
          onPressed: () {
            if (BlocProvider.of<MyProfileEditBloc>(context)
                .state
                .isLoading) {
              return;
            }
            MyProfileEditController(context: context).handleSaveProfile();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.background, backgroundColor: AppColors.element, // Màu văn bản của nút
            padding: EdgeInsets.zero, // Để nút giữ nguyên kích thước như Container
            elevation: 0, // Không có đổ bóng
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w), // Bo góc của nút
            ),
            minimumSize: Size(double.infinity, 30.h), // Đảm bảo chiều cao của nút
          ),
          child: Center(
            child: Text(
              translate('save'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.bold,
                color: AppColors.background,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget editAlumni(BuildContext context) {
  String status = "";
  switch (BlocProvider.of<MyProfileEditBloc>(context).state.status) {
    case "PENDING":
      status = translate('waiting_approval');
    case "APPROVED":
      status = translate('accepted');
    case "DENIED":
      status = translate('denied');
    case "UNSENT":
      status = translate('unsent');
  }

  String faculty = translate('choose_faculty');
  switch (BlocProvider.of<MyProfileEditBloc>(context).state.facultyId) {
    case 1:
      faculty = "Công nghệ thông tin";
    case 2:
      faculty = "Vật lý – Vật lý kỹ thuật";
    case 3:
      faculty = "Địa chất";
    case 4:
      faculty = "Toán – Tin học";
    case 5:
      faculty = "Điện tử - Viễn thông";
    case 6:
      faculty = "Khoa học & Công nghệ Vật liệu";
    case 7:
      faculty = "Hóa học";
    case 8:
      faculty = "Sinh học – Công nghệ Sinh học";
    case 9:
      faculty = "Môi trường";
  }

  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('information_approval'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status,
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                color: BlocProvider.of<MyProfileEditBloc>(context).state.status == "APPROVED" ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "DENIED" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "UNSENT" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "PENDING")
                  buildTextFieldStudentId(
                      context, translate('student_id'), '', '', (value) {
                    context.read<MyProfileEditBloc>().add(StudentIdEvent(value));
                  }),
                if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "APPROVED")
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                    child: Text(
                        BlocProvider.of<MyProfileEditBloc>(context).state.studentId,
                      style: AppTextStyle.small(context).wSemiBold(),
                    ),
                  ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('student_id'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "PENDING" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "DENIED" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "UNSENT")
                  buildTextFieldStartYear(context, translate('year_admission'), '', '',
                          (value) {
                        context.read<MyProfileEditBloc>().add(StartYearEvent(value));
                      }),
                if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "APPROVED")
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                    child: Text(
                      BlocProvider.of<MyProfileEditBloc>(context).state.startYear,
                      style: AppTextStyle.small(context).wSemiBold(),
                    ),
                  ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('year_admission'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "APPROVED")
        Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(
                    faculty,
                    style: AppTextStyle.small(context).wSemiBold(),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    translate('faculty'),
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "PENDING" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "DENIED" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "UNSENT")
        GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => chooseFaculty(context),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin:
          EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h, bottom: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/study.svg",
                width: 25.w,
                height: 25.h,
                color: Colors.black,
              ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: 232.w,
                    child: Text(
                      faculty,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      translate('faculty'),
                      style: TextStyle(
                        fontFamily: AppFonts.Header,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                        color: AppColors.secondaryElementText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "DENIED" || BlocProvider.of<MyProfileEditBloc>(context).state.status == "UNSENT")
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {
              if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
                return;
              }
              MyProfileEditController(context: context).handleAlumniVerification();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.background, backgroundColor: AppColors.element, // Màu văn bản của nút
              padding: EdgeInsets.zero, // Để nút giữ nguyên kích thước như Container
              elevation: 0, // Không có đổ bóng
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w), // Bo góc của nút
              ),
              minimumSize: Size(double.infinity, 30.h), // Đảm bảo chiều cao của nút
            ),
            child: Center(
              child: Text(
                translate('reapply'),
                style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.status == "PENDING")
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {
              if (BlocProvider.of<MyProfileEditBloc>(context).state.isLoading) {
                return;
              }
              MyProfileEditController(context: context).handleEditAlumniVerification();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.background, backgroundColor: AppColors.element, // Màu văn bản của nút
              padding: EdgeInsets.zero, // Để nút giữ nguyên kích thước như Container
              elevation: 0, // Không có đổ bóng
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w), // Bo góc của nút
              ),
              minimumSize: Size(double.infinity, 30.h), // Đảm bảo chiều cao của nút
            ),
            child: Center(
              child: Text(
                translate('edit'),
                style: TextStyle(
                  fontFamily: AppFonts.Header,
                  fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

Widget editJob(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('job'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
          i < BlocProvider.of<MyProfileEditBloc>(context).state.jobs.length;
          i += 1)
        job(context, BlocProvider.of<MyProfileEditBloc>(context).state.jobs[i]),
      GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(
            context,
            "/myProfileAddJob",
            arguments: {"option": 0},
          );
          MyProfileEditController(context: context).handleGetJob();
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/add.svg",
                width: 25.w,
                height: 25.h,
                color: AppColors.element,
              ),
              Container(
                width: 10.w,
              ),
              Container(
                child: Text(
                  translate('add_job'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    color: AppColors.element,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget job(BuildContext context, Job job) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/work.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    job.companyName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 232.w,
                  child: Text(
                    job.position,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    job.isWorking
                        ? '${job.startTime} - ${translate('still_working_here')}'
                        : '${job.startTime} - ${job.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => jobOption(context, job),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 25.w,
            height: 25.h,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget jobOption(BuildContext context, Job job) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    "/myProfileAddJob",
                    arguments: {"option": 1, "job": job},
                  );
                  MyProfileEditController(context: context).handleGetJob();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('edit_job'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool shouldDelete =
                  await MyProfileEditController(context: context).handleDeleteJob(job);
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
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_job'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
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

Widget editEducation(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('education'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
          i <
              BlocProvider.of<MyProfileEditBloc>(context)
                  .state
                  .educations
                  .length;
          i += 1)
        education(context,
            BlocProvider.of<MyProfileEditBloc>(context).state.educations[i]),
      GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(
            context,
            "/myProfileAddEducation",
            arguments: {"option": 0},
          );
          MyProfileEditController(context: context).handleGetEducation();
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/add.svg",
                width: 25.w,
                height: 25.h,
                color: AppColors.element,
              ),
              Container(
                width: 10.w,
              ),
              Container(
                child: Text(
                  translate('add_education'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    color: AppColors.element,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget education(BuildContext context, Education education) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    education.schoolName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 232.w,
                  child: Text(
                    education.degree,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    education.isLearning
                        ? '${education.startTime} - ${translate('still_studying_here')}'
                        : '${education.startTime} - ${education.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => educationOption(context, education),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 25.w,
            height: 25.h,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget educationOption(BuildContext context, Education education) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    "/myProfileAddEducation",
                    arguments: {"option": 1, "education": education},
                  );
                  MyProfileEditController(context: context).handleGetEducation();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('edit_education'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool shouldDelete =
                  await MyProfileEditController(context: context).handleDeleteEducation(education);
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
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_education'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
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

Widget editAchievement(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate('achievement'),
              style: TextStyle(
                fontFamily: AppFonts.Header,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp / MediaQuery.of(context).textScaleFactor,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
          i <
              BlocProvider.of<MyProfileEditBloc>(context)
                  .state
                  .achievements
                  .length;
          i += 1)
        achievement(context,
            BlocProvider.of<MyProfileEditBloc>(context).state.achievements[i]),
      GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(
            context,
            "/myProfileAddAchievement",
            arguments: {"option": 0},
          );
          MyProfileEditController(context: context).handleGetAchievement();
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/add.svg",
                width: 25.w,
                height: 25.h,
                color: AppColors.element,
              ),
              Container(
                width: 10.w,
              ),
              Container(
                child: Text(
                  translate('add_achievement'),
                  style: TextStyle(
                    fontFamily: AppFonts.Header,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    color: AppColors.element,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget achievement(BuildContext context, Achievement achievement) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/achievement.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    achievement.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                Container(
                  width: 232.w,
                  child: Text(
                    achievement.type,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    achievement.time,
                    style: TextStyle(
                      fontFamily: AppFonts.Header,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp / MediaQuery.of(context).textScaleFactor,
                      color: AppColors.secondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => achievementOption(context, achievement),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 25.w,
            height: 25.h,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget achievementOption(BuildContext context, Achievement achievement) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    "/myProfileAddAchievement",
                    arguments: {"option": 1, "achievement": achievement},
                  );
                  MyProfileEditController(context: context).handleGetAchievement();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('edit_achievement'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool shouldDelete =
                  await MyProfileEditController(context: context).handleDeleteAchievement(achievement);
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
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.textBlack,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        translate('delete_achievement'),
                        style: TextStyle(
                          fontFamily: AppFonts.Header,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
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

Widget buildTextFieldFullName(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.fullName,
              maxLines: 1,
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

Widget buildTextFieldPhoneNumber(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.phone,
              keyboardType: TextInputType.number,
              maxLines: 1,
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

Widget chooseFaculty(BuildContext context) {
  return Container(
    height: 450.h,
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
                    translate('choose_faculty'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Công nghệ thông tin',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 1,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Vật lý – Vật lý kỹ thuật',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 2,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Địa chất',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 3,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Toán – Tin học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 4,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Điện tử - Viễn thông',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 5,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Khoa học & Công nghệ Vật liệu',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 6,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hóa học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 7,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sinh học – Công nghệ Sinh học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 8,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Môi trường',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 9,
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
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

Widget chooseSex(
  BuildContext context,
) {
  return Container(
    height: 150.h,
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
                    translate('choose_sex'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Nam',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 'Nam',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .sex,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(SexEvent(value!)));
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Nữ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 'Nữ',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .sex,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(SexEvent(value!)));
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

DateTime convertToDateTime(String dateString) {
  List<String> parts = dateString.split('/');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  return DateTime.utc(year, month, day);
}

String convertDateTimeToString(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  return '$day/$month/$year';
}

Widget chooseBirthday(BuildContext context) {
  late DateTime? _selectedDay;

  if (BlocProvider.of<MyProfileEditBloc>(context).state.dob != "") {
    _selectedDay = convertToDateTime(
        BlocProvider.of<MyProfileEditBloc>(context).state.dob);
  } else {
    _selectedDay = convertToDateTime("01/01/2000");
  }

  return Container(
    height: 210.h,
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
                    translate('choose_birthday'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header,
                    ),
                  ),
                ),
              ),
              DatePickerWidget(
                looping: false,
                firstDate: DateTime(1950),
                lastDate: DateTime(2030),
                initialDate: _selectedDay,
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('vi'),
                onChange: (DateTime newDay, _) {
                  context
                      .read<MyProfileEditBloc>()
                      .add(DobEvent(convertDateTimeToString(newDay)));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.element,
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translate('choose'),
                          style: TextStyle(
                            fontFamily: AppFonts.Header,
                            fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                            fontWeight: FontWeight.bold,
                            color: AppColors.background,
                          ),
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
  );
}

Widget buildTextFieldSocialLink(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.socialLink,
              maxLines: 1,
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

Widget buildTextFieldAboutMe(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: TextFormField(
      onChanged: (value) {
        func!(value);
      },
      keyboardType: TextInputType.multiline,
      initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.aboutMe,
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
  );
}

Widget buildTextFieldStudentId(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.studentId,
              maxLines: 1,
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

Widget buildTextFieldStartYear(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.startYear,
              keyboardType: TextInputType.number,
              maxLines: 1,
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

Widget buildTextFieldEndYear(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.endYear,
              keyboardType: TextInputType.number,
              maxLines: 1,
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

Widget buildTextFieldClass(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextFormField(
              onChanged: (value) {
                func!(value);
              },
              keyboardType: TextInputType.multiline,
              initialValue: BlocProvider.of<MyProfileEditBloc>(context).state.classs,
              maxLines: 1,
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
